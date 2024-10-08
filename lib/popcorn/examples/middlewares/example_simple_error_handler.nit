# This file is part of NIT ( https://nitlanguage.org ).
#
# Copyright 2016 Alexandre Terrasa <alexandre@moz-code.org>
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

import popcorn

class SimpleErrorHandler
	super Handler

	redef fun all(req, res) do
		if res.status_code != 200 then
			res.send("An error occurred!", res.status_code)
		end
	end
end

class SomeHandler
	super Handler

	redef fun get(req, res) do res.send "Hello World!"
end


var app = new App
app.use("/", new SomeHandler)
app.use("/*", new SimpleErrorHandler)
app.listen("localhost", 3000)
