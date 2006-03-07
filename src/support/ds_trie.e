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

--	DS_SEARCHABLE [STRING]
--		undefine
--			is_empty, out
--		end
		
create		
	
	make
	
feature {NONE} -- Initialization

	make_default is
		do
			create root.make_root
			count := 0
		end
		
	make is
		do
			make_default
		end
		

feature -- Access
		
	item, infix "@" (k: STRING): G is
		do
			root.search_key (k, 1)
			Result := root.found_item.item
		end

	found_item : G
			-- Found item of last `search'.
			
feature -- Measurement

	count: INTEGER
			-- Number of items.

	occurrences (v: STRING): INTEGER is
		do
			if has (v) then
				Result := 1
			end
		ensure then
			at_most_one_occurrence: Result <= 1
		end
		

feature -- Status report

	valid_key (k: STRING): BOOLEAN is
		do
			Result := (k /= Void)
		ensure then
			definition: Result = (k /= Void)
		end
		
	has (k: STRING): BOOLEAN is
		do
			root.search_key (k, 1)
			Result := root.found and then root.found_item.is_set
		end

	found : BOOLEAN
	
	found_key : BOOLEAN
			
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
			-- Search for an item associated to key `k'.
		require
			k_not_void: k /= Void
		do
			root.search_key (k, 1)
			found := root.found and then root.found_item.is_set			
			if found then
				found_item := root.found_item.item
			else
				found_item := Void
			end
		end
		
	replace (v: G; k: STRING) is
		do
			root.search_key (k, 1)
			root.found_item.set_item (v)
		end
		

	copy (other: like Current) is
		do
	
		end
		

	wipe_out is
		do
			make_default
		end

	search_key (k : STRING) is	
			-- Search for key `k'.  
			-- A key may exist in a trie without an associated item.
		require
			k_not_void: k /= Void
		local
			default_value : G
		do
			found_item := default_value
			root.search_key (k, 1)
			found_key := root.found
			if found_key then
				found_item := root.found_item.item
			end
		ensure
			found_item: (found_key and has (k)) implies found_item = item (k)
		end
		
feature {NONE} -- Implementation

	root : DS_TRIE_CELL[G]
	
end
