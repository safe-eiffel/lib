note
	description: 
	
		"Objects that iterate over DS_LINEAR[DS_PAIR[SRT_TUPLE, G]] collections; if the collection is sorted, break hierarchy can be checked."

	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	DS_HIERARCHICAL_CURSOR [G]

inherit
	DS_LIST_CURSOR[DS_PAIR[SRT_TUPLE,G]]
		redefine
			go_to,
			is_equal,
			copy,
			item,
			off,
			same_position,
			set_next_cursor,
			valid_cursor,
			is_first,
			after, before,
			start,
			forth,
			search_forth,
			go_after
		end
	
create

	make
	
feature {NONE} -- Initialization

	make (a_container : DS_LIST[like item];a_comparator : KL_PAIR_FIRST_TUPLE_COMPARATOR[G])
		require
			a_container_not_void: a_container /= Void
-- a_sorter : DS_SORTER[like item]; 			a_sorter_not_void: a_sorter /= Void
			a_comparator_not_void: a_comparator /= Void
--			same_comparators: a_sorter.comparator = a_comparator
--			a_container_sorted: a_container.sorted (sorter)
		do
			container := a_container
			internal_cursor := container.new_cursor
			comparator := a_comparator
		end

feature -- Access

	item: DS_PAIR [SRT_TUPLE, G]
			-- Item at cursor position
		do
			Result := internal_cursor.item
		end

	container: DS_LIST [like item]
			-- Data structure traversed

	comparator : KL_PAIR_FIRST_TUPLE_COMPARATOR[G]
			-- Comparator for hierarchical break detection
			
--	last_key : SRT_TUPLE is
--		do
--			Result := last_item.first
--		end

--	last_value : G is
--		do
--			Result := last_item.second
--		end
		
	last_item : like item
	
	key : SRT_TUPLE
		require
			not_off: not off
		do
			Result := item.first
		ensure
			key_not_void: Result /= Void
		end
		
	value : G
		require
			not_off: not off
		do
			Result := item.second
		ensure
			value_not_void: Result /= Void
		end
		
	break_index : INTEGER
	
feature -- Status report

	is_breaked : BOOLEAN
		require
			not_off: not off
		local
			less : BOOLEAN
		do
			if last_item /= Void then
				less := comparator.less_than (last_item, item)
				break_index := comparator.last_break_index
			else
				-- first element
				break_index := 1
			end
			Result := break_index <= key.count
		ensure
			result_definition: Result = (break_index >= 1 and break_index <= key.count)
			first: last_item = Void implies break_index = 1
		end
		
	is_first: BOOLEAN
			-- Is cursor on first item?
		do
			Result := internal_cursor.is_first
		end

	after: BOOLEAN
			-- Is there no valid position to right of cursor?
		do
			Result := internal_cursor.after
		end

	before : BOOLEAN
		do
			Result := internal_cursor.before
		end
		
	off: BOOLEAN
			-- Is there no item at cursor position?
		do
			Result := internal_cursor.off
		end

	same_position (other: like Current): BOOLEAN
			-- Is current cursor at same position as `other'?
		do
			Result := internal_cursor.same_position (other.internal_cursor)
		end

	valid_cursor (other: like Current): BOOLEAN
			-- Is `other' a valid cursor according
			-- to current traversal strategy?
		do
			Result := internal_cursor.valid_cursor (other.internal_cursor)
		end

feature -- Element change

	replace (v : like item)
		do
			internal_cursor.replace (v)
		end
		
feature -- Cursor movement

	go_to (other: like Current)
			-- Move cursor to `other''s position.
		do
			last_item := item
			internal_cursor.go_to (other.internal_cursor)
		end

	start
			-- Move cursor to first position.
		do
			internal_cursor.start
		end

	forth
			-- Move cursor to next position.
		do
			last_item := item
			internal_cursor.forth
		end

	search_forth (v: like item)
			-- Move to first position at or after current
			-- position where `item' and `v' are equal.
			-- (Use `equality_tester''s criterion from `container'
			-- if not void, use `=' criterion otherwise.)
			-- Move `after' if not found.
		do
			last_item := item
			internal_cursor.search_forth (v)
		end

	go_after
			-- Move cursor to `after' position.
		do
			internal_cursor.go_after
		end

feature -- Duplication

	copy (other: like Current)
			-- Copy `other' to current cursor.
		do
			if container /= Void and then not off then
				container.remove_traversing_cursor (internal_cursor)
			end
			standard_copy (other)
			next_cursor := Void
			if not off then
				container.add_traversing_cursor (internal_cursor)
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Are `other' and current cursor at the same position?
		do
			if same_type (other) then
				Result := same_position (other)
			end
		end

feature {DS_TRAVERSABLE} -- Implementation

	set_next_cursor (a_cursor: like next_cursor)
			-- Set `next_cursor' to `a_cursor'.
		do
			next_cursor := a_cursor
		end

feature {DS_HIERARCHICAL_CURSOR} -- Implementation

	internal_cursor : DS_LIST_CURSOR[like item]

invariant
	
	internal_cursor_not_void: internal_cursor /= Void
	after_constraint: after implies off
	
end -- class DS_HIERARCHICAL_CURSOR
