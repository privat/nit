# This file is part of NIT ( http://www.nitlanguage.org ).
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

# nitcc, a parser and lexer generator for Nit
module nitcc

import nitcc_semantic

# Load the grammar file

if args.is_empty then
	print "usage: nitcc <file> | -"
	exit 1
end
var fi = args.first

var text
if fi != "-" then
	var f = new FileReader.open(fi)
	text = f.read_all
	f.close
else
	text = stdin.read_all
end

# Parse the grammar file

var l = new Lexer_nitcc(text)
var ts = l.lex

var p = new Parser_nitcc
p.tokens.add_all ts

var node = p.parse

if not node isa NProd then
	assert node isa NError
	print "{node.position.as(not null)} Syntax Error: {node.message}"
	exit 1
	abort
end

var name = node.children.first.as(Ngrammar).children[1].as(Nid).text

print "Grammar {name} (see {name}.gram.dot))"
node.to_dot("{name}.gram.dot")

# Semantic analysis

var v2 = new CollectNameVisitor
v2.start(node)
var gram = v2.gram

if gram.prods.is_empty then
	print "Error: grammar with no production"
	exit(1)
end

# Generate the LR automaton

var lr = gram.lr0

var conflitcs = new ArraySet[Production]
for s in lr.states do
	for i in s.conflicting_items do conflitcs.add(i.alt.prod)
end

if not conflitcs.is_empty then
	print "Error: there is conflicts"
end

if false then loop
if conflitcs.is_empty then break
print "Inline {conflitcs.join(" ")}"
gram.inline(conflitcs)
lr=gram.lr0
end

# Output concrete grammar and LR automaton

var nbalts = 0
for prod in gram.prods do nbalts += prod.alts.length
print "Concrete grammar: {gram.prods.length} productions, {nbalts} alternatives (see {name}.concrete_grammar.out)"

var pretty = gram.pretty
var f = new FileWriter.open("{name}.concrete_grammar.out")
f.write "// Concrete grammar of {name}\n"
f.write pretty
f.close

print "LR automaton: {lr.states.length} states (see {name}.lr.dot and {name}.lr.out)"
lr.to_dot("{name}.lr.dot")
pretty = lr.pretty
f = new FileWriter.open("{name}.lr.out")
f.write "// LR automaton of {name}\n"
f.write pretty
f.close

# NFA and DFA

var nfa = v2.nfa
print "NFA automaton: {nfa.states.length} states (see {name}.nfa.dot)"
nfa.to_dot.write_to_file("{name}.nfa.dot")
var nfanoe = nfa.to_nfa_noe
nfanoe.to_dot.write_to_file("{name}.nfanoe.dot")
print "NFA automaton without epsilon: {nfanoe.states.length} states (see {name}.nfanoe.dot)"

var dfa = nfa.to_dfa
dfa.to_dot.write_to_file("{name}.dfanomin.dot")
print "DFA automaton (non minimal): {dfa.states.length} states (see {name}.dfanomin.dot)"

dfa = dfa.to_minimal_dfa

dfa.solve_token_inclusion

print "DFA automaton: {dfa.states.length} states (see {name}.dfa.dot)"
dfa.to_dot.write_to_file("{name}.dfa.dot")

if dfa.tags.has_key(dfa.start) then
	print "Error: Empty tokens {dfa.tags[dfa.start].join(" ")}"
	exit(1)
end
for s, tks in dfa.tags do
	if tks.length <= 1 then continue
	print "Error: Conflicting tokens: {tks.join(" ")}"
	exit(1)
end
for t in gram.tokens do
	if t.name == "Eof" then continue
	if dfa.retrotags.has_key(t) and not dfa.retrotags[t].is_empty then continue
	print "Error: Token {t} matches nothing"
	exit(1)
end


# Launched Dijkstra's algorithm on NFA, NFANOE and DFA

var graphs = [nfa,nfanoe,dfa] 
for g in [0..graphs.length[ # for `nfa` then `nfanoe` and finally `dfa`
do
	if g == 0 then 
		print "Dijkstra's algorithm on NFA"
	else if g == 1 then 
		print "Dijkstra's algorithm on NFANOE"
	else
		print "Dijkstra's algorithm on DFA"
	end

	graphs[g].launch_dijkstra(graphs[g].start) # launch Dijkstra's algorithm since start node

	var iter = graphs[g].retrotags.iterator 
	while iter.is_ok # for all tokens of the grammar
	do
		print "{iter.key.name} : " # print the name of the token

		var iter_states = iter.item.iterator 
		while iter_states.is_ok # for all accepted states of this token 
		do
			var state = iter_states.item # the accepted state concerned
			
			var path2 = graphs[g].search_path_dijkstra(state) # get the path from start node to accepted state concerned
			for j in [0..path2.length[ do # for all the path
				if not(path2[j].symbol == null) # transition symbol == epsilon or not
				then
					printn path2[j].symbol.to_s # not epsilon, print the symbol
				else
					printn "ɛ" # epsilon, print it
				end
				if not(j == path2.length-1 ) then printn ", " # except the last, print all symbol next by a comma
			end

			print "" # print \n to the end of the path
			iter_states.next
		end
		print "" # print \n to the end of the token ( for legibility )

		iter.next
	end

	print ""  # print \n to the end of the graph ( for legibility )
end

# Generate Nit code

print "Generate {name}_lexer.nit {name}_parser.nit {name}_test_parser.nit"
dfa.gen_to_nit("{name}_lexer.nit", name, "{name}_parser")
lr.gen_to_nit("{name}_parser.nit", name)

f = new FileWriter.open("{name}_test_parser.nit")
f.write """# Generated by nitcc for the language {{{name}}}

# Standalone parser tester for the language {{{name}}}
module {{{name}}}_test_parser is generated
import nitcc_runtime
import {{{name}}}_lexer
import {{{name}}}_parser

# Class to test the parser for the language {{{name}}}
class TestParser_{{{name}}}
	super TestParser
	redef fun name do return \"{{{name}}}\"
	redef fun new_lexer(text) do return new Lexer_{{{name}}}(text)
	redef fun new_parser do return new Parser_{{{name}}}
end
var t = new TestParser_{{{name}}}
t.main
"""
f.close
