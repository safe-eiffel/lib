indexing
	description: "Objects that..."

	usage: ""
	quality: ""
	refactoring: ""

	status: "see notice at end of class";
	date: "$Date$";
	revision: "$Revision$";
	author: ""

class DS_TRIE [G]

inherit
	
	DS_TABLE [G, STRING]
		redefine
			out
		end

	DS_SEARCHABLE [STRING]
		undefine
			is_empty, out
		end
		
create		
	
	make
	
feature {NONE} -- Initialization

	make_default is
		do
			create root.make_root
		end
		
	make is
		do
			make_default
		end
		

feature -- Access
		
	item, infix "@" (k: STRING): G is
		do
			root.search (k, 1)
			Result := root.found_item.item
		end

	found_item : G
			
feature -- Measurement

	count: INTEGER

	occurrences (v: STRING): INTEGER is
		do
			
		end
		

feature -- Status report

	valid_key (k: STRING): BOOLEAN is
		do
			Result := (k /= Void)
		end
		
	has (k: STRING): BOOLEAN is
		do
			root.search (k, 1)
			Result := root.found
		end

	found : BOOLEAN
			
feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			
		end
		
feature -- Conversion

	out : STRING is
		do
			Result := root.out
		end
		
feature -- Basic operations

	put (v: G; k: STRING) is
		do
			if k.is_equal ("j") then
				do_nothing
			end
			if not has (k) then
				root.insert (v, k, 1)
				count := count + 1
			end
		end
		
	put_new (v: G; k: STRING) is
		do
			root.insert (v, k, 1)
			count := count + 1
		end
		
	remove (k: STRING) is
		do
			
		end
		
	search (k : STRING) is
		require
			k_not_void: k /= Void
		do
			root.search (k, 1)
			found := root.found
			if found then
				found_item := root.found_item.item
			else
				found_item := Void
			end
		end
		
	replace (v: G; k: STRING) is
		do
			
		end
		

	copy (other: like Current) is
		do
			
		end
		

	wipe_out is
		do
			
		end

	search_key (k : STRING) is		
		require
			k_not_void: k /= Void
		do
			root.search_key (k, 1)
			found := root.found
			if found then
				found_item := root.found_item.item
			end
		end
		
feature {NONE} -- Implementation

	root : DS_TRIE_CELL[G]
	
end
