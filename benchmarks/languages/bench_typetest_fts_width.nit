#!/usr/bin/env nit

# Microbenchmak generation for multiple language
# Just a quick an dirty Nit script file :)

# This benchmark focuses on effects of the numvers of generic parameters
# on the typetest performances

# class Root
# class Klass[E] super Root
# class C1...CX super Root
# Klass[C1, C2, ... CX] isa Klass[C1, C2, ... CX]

class Klass
	var id: Int
	var supers = new Array[Klass]
	var all_supers = new HashSet[Klass]
	redef fun to_s
	do
		return "C{id}"
	end
end

class Generator

	var classes = new Array[Klass]

	var dept = 5
	var width = 1
	var loops = 10000
	var middle = 0

	var fts = new Array[String]
	var paramsF = new Array[String]
	var paramsL = new Array[String]
	var paramsM = new Array[String]

	fun genhier
	do
		var s: nullable Klass = null
		for d in [1..dept[ do
			var c = new Klass(d)

			classes.add(c)
			c.all_supers.add(c)
			if s != null then
				c.supers.add(s)
				c.all_supers.add_all(s.all_supers)
			end
			s = c
		end
		middle = (dept / 2) - 1

		for i in [0..width[ do fts.add("FT{i}")
		for i in [0..width[ do paramsF.add(classes.first.to_s)
		for i in [0..width[ do paramsL.add(classes.last.to_s)
		for i in [0..width[ do paramsM.add(classes[middle].to_s)
	end

	var file: nullable OFStream = null
	fun write(str: String)
	do
		file.write(str)
		file.write("\n")
	end

	fun writenit(dir: String, name: String)
	do
		dir = "{dir}/nit"
		dir.mkdir
		file = new OFStream.open("{dir}/{name}.nit")

		write "class Root\n\tfun id: Int do return 0\nend"
		write "class Klass[{fts.join(",")}] super Root"

		write "\tredef fun id do return 0"
		write "end"

		for c in classes do
			write "class {c}"
			if c.supers.is_empty then
				write "\tsuper Root"
			else for s in c.supers do
				write "\tsuper {s}"
			end
			write "\tredef fun id do return {c.id}"
			write "end"
		end

		write "for i in [0..{loops}[ do"
		write "\tfor j in [0..{loops}[ do"
		write "\t\tvar klass:Klass[{paramsF.join(",")}] = new Klass[{paramsL.join(",")}]"
		write "\t\tprint klass isa Klass[{paramsM.join(",")}]"
		write "\tend"
		write "end"

		file.close
	end

	fun writejava(dir: String, name: String, interfaces: Bool)
	do
		dir = "{dir}/java"
		dir.mkdir
		file = new OFStream.open("{dir}/{name}.java")

		var cl = ""
		if interfaces then cl = "X"
		write "class {name} \{"
		if interfaces then
			write "static interface Root\n\t\{ int id(); \}"
			write "static class Klass<{fts.join(",")}> implements Root\n\t\{ public int id() \{ return 0;\} \}"
		else
			write "static class Root\n\t\{ int id() \{ return 0;\} \}"
			write "static class Klass<{fts.join(",")}> extends Root\n\t\{ public int id() \{ return 0;\} \}"
		end

		for c in classes do
			if interfaces then
				write "static interface {c} "
			else
				write "static class {c} "
			end
			if c.supers.is_empty then
				write "\textends Root"
			else for s in [c.supers.first] do
				write "\textends {s}"
			end
			if interfaces then
				write "\{\}"
				write "static class X{c} implements {c}"
			end
			write "\{"
			write "\tpublic int id() \{ return {c.id}; \}"
			write "\}"
		end

		write "static public void main(String args[]) \{"
		write "\tfor(int i = 0; i < {loops}; i++) \{"
		write "\t\tfor(int j = 0; j < {loops}; j++) \{"
		var outs = new Array[String]
		if interfaces then
			for i in [0..paramsF.length[ do outs[i] = "X{paramsF[i]}"
		end
		write "\t\t\tKlass<{outs.join(",")}> klass = new Klass<{outs.join(",")}>();"
		write "\t\t\tSystem.out.println(klass instanceof Klass);"
		write "\t\t}"
		write "\t\}"
		write "\}"
		write "\}"
		file.close
	end

	fun writecsharp(dir: String, name: String, interfaces: Bool)
	do
		dir = "{dir}/cs"
		dir.mkdir
		file = new OFStream.open("{dir}/{name}.cs")

		var cl = ""
		if interfaces then cl = "X"
		write "class {name} \{"
		if interfaces then
			write "interface Root\n\t\{ int Id(); \}"
		else
			write "class Root\n\t\{ int Id() \{ return 0;\} \}"
		end

		var outs = new Array[String]
		for ft in fts do outs.add("out {ft}")

		write "interface Interface<{outs.join(",")}> : Root\n\t\{\}"
		write "class Klass<{fts.join(",")}> : Interface<{fts.join(",")}>\n\t\{ public int Id() \{ return 0;\} \}"
		for c in classes do
			if interfaces then
				write "interface {c} "
			else
				write "class {c} "
			end
			if c.supers.is_empty then
				write "\t: Root"
			else for s in [c.supers.first] do
				write "\t: {s}"
			end
			if interfaces then
				write "\{\}"
				write "class X{c} : {c}"
			end
			write "\{"
			write "\tpublic int Id() \{ return {c.id}; \}"
			write "\}"
		end

		write "static void Main(string[] args) \{"
		write "\tfor(int i = 0; i < {loops}; i++) \{"
		write "\t\tfor(int j = 0; j < {loops}; j++) \{"
		write "\t\t\tInterface<{paramsF.join(",")}> klass = (Interface<{paramsF.join(",")}>)new Klass<{paramsL.join(",")}>();"
		write "\t\t\tSystem.Console.WriteLine(klass is Interface<{paramsM.join(",")}>);"
		write "\t\t}"
		write "\t\}"
		write "\}"
		write "\}"
		file.close
	end

	fun writescala(dir: String, name: String, interfaces: Bool)
	do
		dir = "{dir}/scala"
		dir.mkdir
		file = new OFStream.open("{dir}/{name}.scala")

		var cl = ""
		write "object {name} \{"
		write "class Root\n\t\{ def id: Int = 0 \}"

		var outs = new Array[String]
		for ft in fts do outs.add("+{ft}")

		write "class Klass[{outs.join(",")}] extends Root\n\t\{ override def id: Int = 0 \}"
		for c in classes do
			if interfaces then
				write "trait {c} "
			else
				write "class {c} "
			end
			if c.supers.is_empty then
				write "\textends Root"
			else for s in [c.supers.first] do
				write "\textends {s}"
			end
			if interfaces then
				write "\{\}"
				write "class X{c} extends {c}"
			end
			write "\{"
			write "\toverride def id: Int = {c.id}"
			write "\}"
		end

		write "def main(args: Array[String]) = \{"
		write "\tfor (i <- 0 to {loops}) \{"
		write "\t\tfor (j <- 0 to {loops}) \{"
		outs = new Array[String]
		if interfaces then
			for i in [0..outs.length[ do outs[i] = "X{outs[i]}"
		end
		write "\t\t\tvar klass:Klass[{paramsF.join(",")}] = new Klass[{paramsL.join(",")}]()"
		write "\t\t\tprintln(klass.isInstanceOf[Klass[{paramsM.join(",")}]])"
		write "\t\t\}"
		write "\t\}"
		write "\}"
		write "\}"

		file.close
	end

	fun writecpp(dir: String, name: String)
	do
		dir = "{dir}/cpp"
		dir.mkdir
		file = new OFStream.open("{dir}/{name}.cpp")

		write "#include <iostream>"
		write "#include <stdlib.h>"
		write "class Root\n\t\{ public: virtual int id() \{ return 0;\} \};"

		var outs = new Array[String]
		for ft in fts do outs.add("class {ft}")

		write "template<{outs.join(",")}>"
		write "class Klass\n\t\{ public: virtual int id() \{ return 0;\} \};"
		for c in classes do
			write "class {c} "
			if c.supers.is_empty then
				write "\t: public virtual Root"
			else for s in [c.supers.first] do
				write "\t: public virtual {s}"
			end
			write "\{"
			write "\tpublic: virtual int id() \{ return {c.id}; \}"
			write "\};"
		end

		write "int main(int argc, char **argv) \{"
		write "\tfor(int i = 0; i < {loops}; i++) \{"
		write "\t\tfor(int j = 0; j < {loops}; j++) \{"
		write "\t\t\tKlass<{paramsF.join(",")}>* klass = new Klass<{paramsF.join(",")}>();"
		write "\t\t\tKlass<{paramsM.join(",")}>* to = dynamic_cast<Klass<{paramsM.join(",")}>*>(klass);"
		write "\t\tif(to != 0) \{ std::cout << \"true\" << std::endl; \} else \{ std::cout << \"false\" << std::endl; \}"
		write "\t\t}"
		write "\t\}"
		write "\}"
		file.close
	end

	fun writee(dir: String, name: String, se: Bool)
	do
		if se then
			dir = "{dir}/se/{name}"
		else
			dir = "{dir}/es/{name}"
		end
		dir.mkdir
		file = new OFStream.open("{dir}/root.e")

		var istk = ""
		if se then istk = " is"
		write "class ROOT"
		write "feature id: INTEGER {istk} do Result := 0 end"
		write "end"
		file.close

		file = new OFStream.open("{dir}/klass.e")
		write "class KLASS[{fts.join(",")}]"
		write "feature id: INTEGER {istk} do Result := 0 end"
		write "end"
		file.close

		for c in classes do
			file = new OFStream.open("{dir}/{c}.e")
			write "class {c} "
			if c.supers.is_empty then
				write "\tinherit ROOT"
			else for s in [c.supers.first] do
				write "\tinherit {s}"
			end
			write "\t\tredefine id end"
			write "feature"
			write "\tid: INTEGER {istk} do Result := {c.id} end"
			write "end"
			file.close
		end

		file = new OFStream.open("{dir}/app{name}.e")
		write "class APP{name.to_upper}"
		if se then
			write "insert ARGUMENTS"
		end
		write "create make"
		write "feature"

		if se then
			write "\tmake{istk}"
		else
			write "\tmake(args: ARRAY[STRING]){istk}"
		end
		write "\t\tlocal"
		write "\t\t\ta: KLASS[{paramsF.join(",")}]"
		write "\t\t\tto: KLASS[{paramsM.join(",")}]"
		write "\t\t\tx: INTEGER"
		write "\t\t\ty: INTEGER"
		write "\t\tdo"
		write "\t\t\tfrom x := 0 until x>={loops} loop"
		write "\t\t\t\tfrom y := 0 until y>={loops} loop"
		write "\t\t\t\t\tcreate \{KLASS[{paramsL.join(",")}]\} a"
		write "\t\t\t\t\tto ?= a"
		write "\t\t\t\t\tprint((to /= Void).out)"
		write "\t\t\t\t\tprint(\"%N\")"
		write "\t\t\t\t\ty := y + 1"
		write "\t\t\t\tend"
		write "\t\t\t\tx := x + 1"
		write "\t\t\tend"
		write "\t\tend"
		write "end"
		file.close
	end

	var count = false
end

var g = new Generator
var outdir = args.first
var name = args[1]
var use_interfaces = true
if args.length > 2 then g.dept = args[2].to_i
if args.length > 3 then g.width = args[3].to_i
if args.length > 4 then use_interfaces = false

g.genhier

g.writenit(outdir, name)
g.writejava(outdir, name, use_interfaces)
g.writecsharp(outdir, name, use_interfaces)
g.writescala(outdir, name, use_interfaces)
g.writecpp(outdir, name)
g.writee(outdir, "{name}_se", true)
g.writee(outdir, name, false)
