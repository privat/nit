# This file is part of NIT ( http://www.nitlanguage.org ).
#
# Copyright 2014-2015 Alexandre Terrasa <alexandre@moz-code.org>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# `nitrpg` achievements.
#
# Players can unlock achievements by performing remarkable actions on the repo.
# Achievements are rewarded by nitcoins.
module achievements

import statistics

redef class Game
	redef fun init_default_reactors do
		super
		add_reactor(new Player1Issue, new Player100Issues, new Player1KIssues)
		add_reactor(new Player1Pull, new Player100Pulls, new Player1KPulls)
		add_reactor(new Player1Commit, new Player100Commits, new Player1KCommits)
		add_reactor(new IssueAboutNitdoc, new IssueAboutFFI)
		add_reactor(new Player1Comment, new Player100Comments, new Player1KComments)
		add_reactor(new PlayerPingGod, new PlayerFirstReview, new PlayerSaysNitcoin)
	end
end

redef class GameEntity

	# Register a new achievement for this game entity.
	#
	# Saves the achievement in game data.
	# Do nothing is the achievement is already registered.
	#
	# TODO should update the achievement?
	fun add_achievement(achievement: Achievement) do
		stats.inc("achievements")
		achievement.owner = self
		achievement.save
	end

	# Is `a` unlocked for this `Player`?
	fun has_achievement(a: Achievement): Bool do return load_achievement(a.id) != null

	# Load the event from its `id`.
	#
	# Looks for the event save file in game data.
	# Returns `null` if the event cannot be found.
	fun load_achievement(id: String): nullable Achievement do
		var req = new JsonObject
		req["id"] = id
		req["game"] = game.key
		req["owner"] = key
		var obj = game.db.collection("achievements").find(req)
		if obj isa JsonObject then
			return new Achievement.from_json(game, obj)
		end
		return null
	end

	# List all events registered in this entity.
	#
	# This list is reloaded from game data each time its called.
	#
	# To add events see `add_event`.
	fun load_achievements: MapRead[String, Achievement] do
		var req = new JsonObject
		req["game"] = game.key
		req["owner"] = key
		var res = new HashMap[String, Achievement]
		for obj in game.db.collection("achievements").find_all(req) do
			var achievement = new Achievement.from_json(game, obj)
			res[achievement.id] = achievement
		end
		return res
	end
end

# Achievements are rewarded by `nitcoins`.
#
# An achievement represents a notable action performed by a `Player`.
# Player that `unlock` achievements are rewarded by nitcoins.
class Achievement
	super GameEntity

	redef var collection_name = "achievements"

	redef var game

	redef fun key do
		var owner = self.owner
		if owner == null then return id
		return "{owner.key}-{id}"
	end

	# Uniq ID for this achievement.
	var id: String

	# Name of this achievement.
	var name: String

	# Description of the achievement.
	var desc: String

	# Reward that this achievement give in nitcoins.
	var reward: Int

	# Is this achievement unlocked by somebody?
	var is_unlocked: Bool is lazy do return not load_events.is_empty

	# Game entity this achievement is about.
	var owner: nullable GameEntity = null

	# Init `self` from a `json` object.
	#
	# Used to load achievements from storage.
	init from_json(game: Game, json: JsonObject) do
		init(game,
			json["id"].as(String),
			json["name"].as(String),
			json["desc"].as(String),
			json["reward"].as(Int))
	end

	redef fun to_json do
		var json = super
		json["id"] = id
		json["name"] = name
		json["desc"] = desc
		json["reward"] = reward
		json["game"] = game.key
		var owner = self.owner
		if owner != null then json["owner"] = owner.key
		return json
	end
end

redef class Player
	# Unlocks an achievement for this Player based on a GithubEvent.
	#
	# Register the achievement and adds the achievement reward to the player
	# nitcoins.
	#
	# Do nothing is this player has already unlocked the achievement.
	#
	# TODO: add abstraction so achievements do not depend on GithubEvent.
	fun unlock_achievement(a: Achievement, event: GithubEvent) do
		if has_achievement(a) then
			update_achievement(a, event)
			return
		end
		game.message(1, "Player {name} unlocked achievement {a}")
		nitcoins += a.reward
		add_achievement(a)
		trigger_unlock_event(a, event)
		save
	end

	# Update achievement in a new and oldest one is found.
	#
	# Comparison is based on github incremental id.
	fun update_achievement(a: Achievement, new_event: GithubEvent) do
		var req = new JsonObject
		req["game"] = game.key
		req["data.player"] = key
		req["data.achievement"] = a.id
		for e in game.db.collection("events").find_all(req) do
			var event = new GameEvent.from_json(game, e)
			var old_event = new GithubEvent.from_json(game.api, event.data["github_event"].as(JsonObject))
			if new_event.date < old_event.date then
				game.message(1, "Found older event for achievement {a.id} and player {name}")
				event.data = new_event.json
				event.save
			end
		end
	end

	# Create a new event that marks the achievement unlocking.
	fun trigger_unlock_event(achievement: Achievement, event: GithubEvent) do
		var obj = new JsonObject
		obj["player"] = name
		obj["reward"] = achievement.reward
		obj["achievement"] = achievement.id
		obj["github_event"] = event.json
		var ge = new GameEvent(game, "achievement_unlocked", obj)
		add_event(ge)
		game.add_event(ge)
		achievement.add_event(ge)
	end
end

# `GameReactor` dedicated to achievements unlocking.
interface AchievementReactor
	super GameReactor

	# Unic ID of the achievement this reactor unlocks.
	fun id: String is abstract

	# Name of the achievement this reactor unlocks.
	fun name: String is abstract

	# Description of the achievement this reactor unlocks.
	fun desc: String is abstract

	# Amount of nitcoins rewarded for unlocking the achievement.
	fun reward: Int is abstract

	# Return a new instance of the achievement to unlock.
	fun new_achievement(game: Game): Achievement do
		var achievement = game.load_achievement(id)
		if achievement == null then
			achievement = new Achievement(game, id, name, desc, reward)
			game.add_achievement(achievement)
		end
		return achievement
	end
end

#####################
### Issues
#####################

# Unlock achievement after X issues.
#
# Used to factorize behavior.
abstract class PlayerXIssues
	super AchievementReactor

	# Number of PR required to unlock the achievement.
	var threshold: Int is noinit

	redef fun react_event(game, event) do
		if not event isa IssuesEvent then return
		if not event.action == "opened" then return
		var player = event.issue.user.player(game)
		if player.stats["issues"] == threshold then
			var a = new_achievement(game)
			player.unlock_achievement(a, event)
		end
	end
end

# Player open his first issue.
class Player1Issue
	super PlayerXIssues

	redef var id = "player_1_issue"
	redef var name = "First complaint"
	redef var desc = "Open your first issue."
	redef var reward = 10
	redef var threshold = 1
end

# Player open 100 issues.
class Player100Issues
	super PlayerXIssues

	redef var id = "player_100_issues"
	redef var name = "Mature whiner"
	redef var desc = "Open 100 issues in the game."
	redef var reward = 100
	redef var threshold = 100
end

# Player open 1 000 issues.
class Player1KIssues
	super PlayerXIssues

	redef var id = "player_1000_issues"
	redef var name = "You, sir, complain a lot"
	redef var desc = "Open 1000 issues in the game."
	redef var reward = 1000
	redef var threshold = 1000
end

# Player open an issue about nitdoc.
class IssueAboutNitdoc
	super AchievementReactor

	redef var id = "issue_about_nitdoc"
	redef var name = "Say nitdoc again, I double dare you!"
	redef var desc = "Open an issue with \"nitdoc\" in the title."
	redef var reward = 10

	redef fun react_event(game, event) do
		if not event isa IssuesEvent then return
		if not event.action == "opened" then return
		var player = event.issue.user.player(game)
		var re = "nitdoc".to_re
		re.ignore_case = true
		if event.issue.title.has(re) then
			var a = new_achievement(game)
			player.unlock_achievement(a, event)
		end
	end
end

# Player open an issue about FFI.
class IssueAboutFFI
	super PlayerXIssues

	redef var id = "issue_about_ffi"
	redef var name = "Polyglot what?"
	redef var desc = "Open an issue with `ffi` in the title."
	redef var reward = 10

	redef fun react_event(game, event) do
		if not event isa IssuesEvent then return
		if not event.action == "opened" then return
		var player = event.issue.user.player(game)
		var re = "\\bffi\\b".to_re
		re.ignore_case = true
		if event.issue.title.has(re) then
			var a = new_achievement(game)
			player.unlock_achievement(a, event)
		end
	end
end

#####################
### Pull requests
#####################

# Unlock achievement after X pull requests.
#
# Used to factorize behavior.
abstract class PlayerXPulls
	super AchievementReactor

	# Number of PR required to unlock the achievement.
	var threshold: Int is noinit

	redef fun react_event(game, event) do
		if not event isa PullRequestEvent then return
		if not event.action == "opened" then return
		var player = event.pull.user.player(game)
		if player.stats["pulls"] == threshold then
			var a = new_achievement(game)
			player.unlock_achievement(a, event)
		end
	end
end

# Open your first pull request.
class Player1Pull
	super PlayerXPulls

	redef var id = "player_1_pull"
	redef var name = "First PR"
	redef var desc = "Open your first pull request."
	redef var reward = 10
	redef var threshold = 1
end

# Author 100 pull requests.
class Player100Pulls
	super PlayerXPulls

	redef var id = "player_100_pulls"
	redef var name = "100 pull requests!!!"
	redef var desc = "Open 100 pull requests in the game."
	redef var reward = 100
	redef var threshold = 100
end

# Author 1000 pull requests.
class Player1KPulls
	super PlayerXPulls

	redef var id = "player_1000_pulls"
	redef var name = "1000 PULL REQUESTS!!!"
	redef var desc = "Open 1000 pull requests in the game."
	redef var reward = 1000
	redef var threshold = 1000
end

#####################
### Commits
#####################

# Unlock achievement after X merged commits.
#
# Used to factorize behavior.
abstract class PlayerXCommits
	super AchievementReactor

	# Number of PR required to unlock the achievement.
	var threshold: Int is noinit

	redef fun react_event(game, event) do
		if not event isa PullRequestEvent then return
		if not event.action == "closed" then return
		if not event.pull.merged then return
		var player = event.pull.user.player(game)
		if player.stats["commits"] >= threshold then
			var a = new_achievement(game)
			player.unlock_achievement(a, event)
		end
	end
end

# Author your first commit in the game.
class Player1Commit
	super PlayerXCommits

	redef var id = "player_1_commit"
	redef var name = "First blood"
	redef var desc = "Author your first commit in the game."
	redef var reward = 10
	redef var threshold = 1
end

# Author 100 commits.
class Player100Commits
	super PlayerXCommits

	redef var id = "player_100_commits"
	redef var name = "100 commits"
	redef var desc = "Author 100 commits in the game."
	redef var reward = 100
	redef var threshold = 100
end

# Author 1 000 commits.
class Player1KCommits
	super PlayerXCommits

	redef var id = "player_1000_commits"
	redef var name = "1000 commits!!!"
	redef var desc = "Author 1000 commits in the game."
	redef var reward = 1000
	redef var threshold = 1000
end

# Author 10 000 commits.
class Player10KCommits
	super PlayerXCommits

	redef var id = "player_10000_commits"
	redef var name = "10000 COMMITS!!!"
	redef var desc = "Author 10000 commits in the game."
	redef var reward = 10000
	redef var threshold = 10000
end

#####################
### Issue Comments
#####################

# Unlock achievement after X issue comments.
#
# Used to factorize behavior.
abstract class PlayerXComments
	super AchievementReactor

	# Number of comments required to unlock the achievement.
	var threshold: Int is noinit

	redef fun react_event(game, event) do
		if not event isa IssueCommentEvent then return
		if not event.action == "created" then return
		var player = event.comment.user.player(game)
		if player.stats["comments"] == threshold then
			var a = new_achievement(game)
			player.unlock_achievement(a, event)
		end
	end
end

# Player author his first comment in issues.
class Player1Comment
	super PlayerXComments

	redef var id = "player_1_comment"
	redef var name = "From lurker to member"
	redef var desc = "Comment on an issue."
	redef var reward = 10
	redef var threshold = 1
end

# Player author 100 issue comments.
class Player100Comments
	super PlayerXComments

	redef var id = "player_100_comments"
	redef var name = "Chatter"
	redef var desc = "Comment 100 times on issues."
	redef var reward = 100
	redef var threshold = 100
end

# Player author 1000 issue comments.
class Player1KComments
	super PlayerXComments

	redef var id = "player_1000_comments"
	redef var name = "You sir, talk a lot!"
	redef var desc = "Comment 1000 times on issues."
	redef var reward = 1000
	redef var threshold = 1000
end

# Ping @privat in a comment.
class PlayerPingGod
	super AchievementReactor

	redef var id = "player_ping_god"
	redef var name = "Ping god"
	redef var desc = "Ping the owner of the repo for the first time."
	redef var reward = 50

	redef fun react_event(game, event) do
		if not event isa IssueCommentEvent then return
		var owner = game.repo.owner.login
		if event.comment.body.has("@{owner}".to_re) then
			var player = event.comment.user.player(game)
			var a = new_achievement(game)
			player.unlock_achievement(a, event)
		end
	end
end

# Give your first +1
class PlayerFirstReview
	super AchievementReactor

	redef var id = "player_first_review"
	redef var name = "First +1"
	redef var desc = "Give a +1 for the first time."
	redef var reward = 10

	redef fun react_event(game, event) do
		if not event isa IssueCommentEvent then return
		# FIXME use a more precise way to locate reviews
		if event.comment.is_ack then
			var player = event.comment.user.player(game)
			var a = new_achievement(game)
			player.unlock_achievement(a, event)
		end
	end
end

# Talk about nitcoin in issue comments.
class PlayerSaysNitcoin
	super AchievementReactor

	redef var id = "player_says_nitcoin"
	redef var name = "Talking about money"
	redef var desc = "Say something about nitcoins in a comment."
	redef var reward = 10

	redef fun react_event(game, event) do
		if not event isa IssueCommentEvent then return
		if event.comment.body.has("(n|N)itcoin".to_re) then
			var player = event.comment.user.player(game)
			var a = new_achievement(game)
			player.unlock_achievement(a, event)
		end
	end
end
