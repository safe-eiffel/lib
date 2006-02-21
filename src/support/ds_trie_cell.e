indexing
	description: "Objects that..."

	usage: ""
	quality: ""
	refactoring: ""

	status: "see notice at end of class";
	date: "$Date$";
	revision: "$Revision$";
	author: ""

class DS_TRIE_CELL [G]

inherit
	ANY
		redefine
			out
		end
		
create 

	make, make_root
	
feature {NONE} -- Initialization

	make (a_key : CHARACTER) is
			-- make cell with `a_key' and `an_item'.
		do
			key := a_key
			create subkeys.make (5)
		end

	make_root is		
		do
			is_root := True
			create subkeys.make (5)
		end
		
feature -- Access

	key : CHARACTER
	
	item : G
	
	found_item : like Current
	
feature -- Measurement

feature -- Comparison

feature -- Status report

	found : BOOLEAN

	is_root : BOOLEAN
	
	is_set : BOOLEAN
		
feature -- Element change

	set_item (an_item : G) is
		do
			item := an_item
			is_set := True
		ensure
			item_set: item = an_item
		end
		
feature -- Basic operations

	search (string : STRING; index_start : INTEGER) is
			-- Search for suffix of `string' starting at `index_start'.
		require
			string_not_void: string /= Void
			index_start_within_bounds: index_start >= 1 and index_start <= string.count
			index_start_consistent: index_start > 1 implies string.item (index_start - 1) = key
		do
			found_item := Void
			found := False
			subkeys.search (string.item (index_start))
			if subkeys.found then
				if index_start = string.count then
					found_item := subkeys.found_item
					found := found_item.is_set
				else
					subkeys.found_item.search (string, index_start + 1)
					found := subkeys.found_item.found and then subkeys.found_item.found_item.is_set
					if found then
						found_item := subkeys.found_item.found_item
					end
				end
			end
		end

	search_key (string : STRING; index_start : INTEGER) is
			-- Search for suffix of `string' starting at `index_start'.
		require
			string_not_void: string /= Void
			index_start_within_bounds: index_start >= 1 and index_start <= string.count
			index_start_consistent: index_start > 1 implies string.item (index_start - 1) = key
		do
			found_item := Void
			found := False
			subkeys.search (string.item (index_start))
			if subkeys.found then
				if index_start = string.count then
					found_item := subkeys.found_item
					found := True
				else
					subkeys.found_item.search (string, index_start + 1)
					found := subkeys.found_item.found
					if found then
						found_item := subkeys.found_item.found_item
					end
				end
			end
		end
		
	insert (an_item : G; string : STRING; index_start : INTEGER) is		
			-- insert for suffix of `string' starting at `index_start'.
		require
			string_not_void: string /= Void
			index_start_within_bounds: index_start >= 1 and index_start <= string.count
			index_start_consistent: index_start > 1 implies string.item (index_start - 1) = key
		local
			cell : like Current
			c : like key
		do
			c := string.item (index_start)
			subkeys.search (c)
			if not subkeys.found then
				create cell.make (c)
				subkeys.force (cell, c)
			else
				cell := subkeys.found_item
			end
			if index_start < string.count then
				cell.insert (an_item, string, index_start + 1)
			else
				cell.set_item (an_item)
			end
		end

feature -- Conversion

	out : STRING is		
		do
			if is_root then
				Result := out_level (1)
			end
		end
		
feature {DS_TRIE_CELL, DS_TRIE} -- Implementation

	out_level (n : INTEGER) : STRING is
		do
			from
				create Result.make (10)
				create indent_string.make_filled (' ',n)
				Result.append_string (indent_string) 
				Result.append_string ("key   : ") 
				Result.append_character (key) 
				Result.append_character ('%N')
				Result.append_string (indent_string) 
				if not is_root then
					Result.append_string ("item  : ") 
					if item /= Void then
						Result.append_string (item.out) 
					else
						Result.append_string ("Void")
					end
				else
					Result.append_string ("*root*")
				end
				Result.append_character ('%N')
				subkeys.start
			until
				subkeys.off
			loop
				Result.append_string (subkeys.item_for_iteration.out_level (n+1))
				Result.append_character ('%N')
				subkeys.forth
			end
		end
	
feature {NONE} -- Implementation

	indent_string : STRING
	
	subkeys : DS_HASH_TABLE[DS_TRIE_CELL[G], CHARACTER]
	
end
