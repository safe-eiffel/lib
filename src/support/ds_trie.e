indexing

	description:

		"Trie (aka. reTRIEval) data structures."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class DS_TRIE [G]

inherit

	DS_TABLE [G, STRING]
		redefine
			out
		end

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

	item, infix "@" (key: STRING): G is
			-- Item associated with `key'.
		do
			root.search_key (key, 1)
			Result := root.found_item.item
		end

	found_item : G
			-- Found item of last `search'.

feature -- Measurement

	count: INTEGER
			-- Number of items.

	occurrences (v: STRING): INTEGER is
			-- Occurrences of `v'
		do
			if has (v) then
				Result := 1
			end
		ensure
			at_most_one_occurrence: Result <= 1
		end


feature -- Status report

	valid_key (key : STRING): BOOLEAN is
			-- Is `key' a valid key?
		do
			Result := (key /= Void)
		ensure then
			definition: Result = (key /= Void)
		end

	has (key: STRING): BOOLEAN is
			-- Has the trey an element associated with `key'?
		do
			root.search_key (key, 1)
			Result := root.found and then root.found_item.is_set
		end

	found : BOOLEAN
			-- Has the last search operation succeeded?

	found_key : BOOLEAN
			-- Has the key of the last search operation been found ?

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

	put (v: G; key: STRING) is
			-- Put element `v' associated with `key'.
		do
			if not has (key) then
				root.insert (v, key, 1)
				count := count + 1
			end
		end

	put_new (v: G; key: STRING) is
			-- Put new element `v' associated with `key'.
		do
			root.insert (v, key, 1)
			count := count + 1
		end

	remove (key: STRING) is
			-- FIXME: Not supported
		do
		end

	search (key : STRING) is
			-- Search for an item associated to `key'.
		require
			key_not_void: key /= Void
		do
			root.search_key (key, 1)
			found := root.found and then root.found_item.is_set
			if found then
				found_item := root.found_item.item
			else
				found_item := Void
			end
		end

	replace (v: G; key: STRING) is
			-- Replace current item at `key' by `v'.
		do
			root.search_key (key, 1)
			root.found_item.set_item (v)
		end


	copy (other: like Current) is
			-- FIXME: Not supported
		do

		end


	wipe_out is
			-- Remove all items.
		do
			make_default
		end

	search_key (key : STRING) is
			-- Search for key `k'.
			-- A key may exist in a trie without an associated item.
		require
			key_not_void: key /= Void
		local
			default_value : G
		do
			found_item := default_value
			root.search_key (key, 1)
			found_key := root.found
			if found_key then
				found_item := root.found_item.item
			end
		ensure
			found_item: (found_key and has (key)) implies found_item = item (key)
		end

feature {NONE} -- Implementation

	root : DS_TRIE_CELL[G]

end
