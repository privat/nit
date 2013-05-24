#This file is part of NIT ( http://www.nitlanguage.org ).
#
# Copyright 2013 Stefan Lage <lagestfan@gmail.com> 
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

module quadtree

# Introduce to quadtree structure 
abstract class AbstractQuadtree[E]

	readable var _parent: nullable AbstractQuadtree[E]
	readable var _x: Int
	readable var _y: Int
	readable var _width: Int
	readable var _height: Int
	readable var _level: Int
	readable var _maxLevel: Int
	readable var _items: List[E]
	var nw: nullable AbstractQuadtree[E]
	var ne: nullable AbstractQuadtree[E]
	var sw: nullable AbstractQuadtree[E]
	var se: nullable AbstractQuadtree[E]

	init 
	do 
		_x = 0
		_y = 0
		_width = 0
		_height = 0
		_level = 0
		_maxLevel = 0
		_items = new List[E]
	end

	# Insert an item in the right part of the collection
	fun addItem(item: E)
	do
		var quad = getNode(item)
		quad.items.add(item)
	end
	
	# Uptade the position of an item
	fun updatePosition(item: E)
	do
		items.remove(item)
		addItem(item)
	end

	# Remove an item contained in the list
	fun remove(item: E) do items.remove(item)

	fun clear
	do
		if level == maxLevel then 
			items.clear
		else
			nw.clear
			ne.clear
			sw.clear
			se.clear
		end	
		if not items.is_empty then items.clear
	end
	
	# Get the right node where the item must be inserted
	fun getNode(item: E): nullable AbstractQuadtree[E]
	do
		# Get QuadTree where is localised 'sp'
		var quad = findNode(item)
		for i in [0..maxLevel]
		do
			if quad != null then 
				var quad2 = quad.findNode(item)
				if quad2 != null then quad = quad2
			end
			if quad.level == maxLevel  or (quad.level == maxLevel-1 and quad == self)  then break
		end
		return quad.as(not null)
	end

	# Need to be redef
	# Return the node where is stock an item
	fun findNode(item: E): nullable AbstractQuadtree[E] do return null

	# Retrieve the list of items whose are in the same node than an item 
	fun retrieve(item: E): List[E]	
	do
		var index = findNode(item).as(not null)
		var list: List[E] = new List[E]
		if index.items.length > 0 then
			for i in index.items
			do
				if i != item then list.add(i)
			end
		end
		if index.level < maxLevel then
			if index.nw != null then
				list = index.retrieve(item)
			end
		end
		return list
	end
end
