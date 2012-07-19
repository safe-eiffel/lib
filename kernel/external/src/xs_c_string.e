note
	description: "C allocated strings"
	author: "Paul G. Crismer"

	library: "XS_C : eXternal Support C"

	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	XS_C_STRING

inherit
	XS_C_MEMORY
		redefine
			dispose, is_equal
		end

	XS_C_EXTERNAL_TOOLS
		undefine
			dispose, is_equal
		end

	KL_IMPORTED_INTEGER_ROUTINES
		undefine
			is_equal
		end

	KL_IMPORTED_ANY_ROUTINES
		undefine
			is_equal
		end

create
	make, make_from_string, make_shared_from_pointer, make_from_pointer, set_empty

feature {NONE} -- Initialization

	make (a_capacity : INTEGER)
			-- make for `a_capacity' characters
		require
			a_capacity_positive: a_capacity >= 0
		do
			if a_capacity > 0 then
				handle := c_memory_allocate (a_capacity + 1)
			else
				make_shared_from_pointer (empty_string.handle, 0)
			end
			capacity := a_capacity
			internal_count := -1
		ensure
			capacity_set: capacity = a_capacity
			internal_count_minus_1: internal_count = -1
			shared_when_empty: (a_capacity = 0) implies (Current = empty_string or else (is_shared and then handle = empty_string.handle))
		end

	make_from_string (s : STRING)
			-- make from `s'
		require
			s_not_void: s /= Void
			s_string_type: is_string_type (s)
		do
			make (s.count)
			if not is_shared then
				from_string (s)
			end
		ensure
			capacity_set: capacity = s.count
			shared_when_empty: (s.count = 0) implies (is_shared and then handle = empty_string.handle)
			is_copy: as_string.is_equal (s)
		end

	make_from_pointer (p : POINTER; a_capacity : INTEGER)
			-- make from externally allocated pointer and manage it
		require
			p_not_default: p /= default_pointer
			a_capacity_positive: a_capacity >= 0
		do
			handle := p
			capacity := a_capacity
			internal_count := -1
		ensure
			handle_set: handle = p
			capacity_set: capacity = a_capacity
			internal_count_set: internal_count = -1
		end

feature -- Initialization

	make_shared_from_pointer (p : POINTER; a_capacity : INTEGER)
			-- have access to `p' as a string, sharing pointer
		require
			p_not_default: p /= default_pointer
			a_capacity_positive: a_capacity >= 0
		do
			handle := p
			capacity := a_capacity
			internal_count := -1 -- external_string_length (handle)
			is_shared := True
		ensure
			handle_set: handle = p
			capacity_set: capacity = a_capacity
			is_shared: is_shared
		end

feature -- Access

	capacity : INTEGER
			-- string capacity

	count : INTEGER
			-- Count of characters in string.
			do
				if internal_count >= 0 then
					Result := internal_count
				else
					Result := external_string_length (handle)
				end
			end

	item (c : INTEGER) : CHARACTER
		require
			c_within_limits: c >= 1 and c <= capacity
			valid: is_valid
		do
			Result := INTEGER_.to_character (c_memory_get_uint8 (c_memory_pointer_plus (handle, c - 1)))
		end

	item_integer (c: INTEGER) : INTEGER
		require
			c_within_limits: c >= 1 and c <= capacity
			valid: is_valid
		do
			Result := c_memory_get_uint8 (c_memory_pointer_plus (handle, c - 1))
		end

	substring (i_start, i_end : INTEGER) : STRING
			-- substring made of characters [i_start..i_end]
		require
			i_start_ok: i_start > 0 and i_start <= i_end
			i_end_ok: i_end > 0 and i_end <= capacity
		local
			index : INTEGER
		do
			create Result.make (i_end - i_start + 1)
			from
				index := i_start
			until
				index > i_end
			loop
				Result.append_character (item (index))
				index := index + 1
			end
		end

	copy_substring_to (i_start, i_end : INTEGER; string : STRING)
			-- copy substring [i_start..i_end] to string
		require
			i_start_ok: i_start > 0 and i_start <= i_end
			i_end_ok: i_end > 0 and i_end <= capacity
			string_exists: string /= Void
		do
			string.wipe_out
			append_substring_to (i_start, i_end, string)
		ensure
			string_set: string.is_equal (substring (i_start, i_end))
		end

	append_substring_to (i_start, i_end : INTEGER; string : STRING)
			-- append substring [i_start..i_end] to string
		require
			i_start_ok: i_start > 0 and i_start <= i_end
			i_end_ok: i_end > 0 and i_end <= capacity
			string_exists: string /= Void
		local
			index : INTEGER
		do
			from
				index := i_start
			until
				index > i_end
			loop
				string.append_character (item (index))
				index := index + 1
			end
		ensure
			string_set: string.substring (old (string.count) + 1, string.count).is_equal (substring (i_start, i_end))
		end

feature -- Status report

	is_shared : BOOLEAN
		-- is the handle of this string shared with other objects ?

	is_released : BOOLEAN

	is_empty : BOOLEAN
			-- Is this an empty C string ?
		do
			Result := count = 0
		end

	equal_string (s : STRING) : BOOLEAN
			-- Are the strings equal ?
		require
			s_not_void: s /= Void
		do
			if s.count > 0 then
				Result := substring (1, s.count).is_equal (s)
			else
				Result := True
			end
		ensure
			definition: s.count > 0 implies Result = substring (1, s.count).is_equal (s)
			definition_empty: s.count = 0 implies Result = True
		end

	is_string_type (s : STRING) : BOOLEAN
			-- Is `s' of type STRING ?
		require
			s_not_void: s /= Void
		local
			t : STRING
		do
			create t.make (0)
			Result := ANY_.same_types (t, s)
		end

feature -- Element change

	wipe_out
		do
			put ('%U', 1)
			internal_count := 0
		ensure
			is_empty: is_empty
		end

	put (c : CHARACTER; index : INTEGER)
			-- put `c' at `index'
		require
			valid_index: index >= 1 and index <= capacity
		do
			c_memory_put_uint8 (c_memory_pointer_plus (handle, index - 1), c.code)
			if internal_count >= 0 and internal_count < index then
				internal_count := index
			end
		ensure
			item_set: item (index) = c
			count_set: internal_count >= 0 implies count >= index
		end

feature -- Conversion

	as_string : STRING
			-- Current converted to a STRING
		require
			valid: is_valid
		local
			l_count : INTEGER
		do
			l_count := count
			if l_count >= 0 then
				if l_count > 0 then
					Result := substring (1, count)
				else
					create Result.make_empty
				end
			else
				Result := pointer_to_string (handle)
			end
		end

feature -- Constants

	empty_string : XS_C_STRING
			-- empty string
		once
			create Result.set_empty
		end

feature -- Comparison

	is_equal (other : like Current) : BOOLEAN
			-- is 'other' equal to current ?
		do
			if other = Current or else handle = other.handle then
				Result := True
			else
				if is_valid and other.is_valid then
					Result := as_string.is_equal (other.as_string)
				end
			end
		end

feature -- Element change

	from_string (s : STRING)
			-- Copy `s' into Current
		require
			s_not_void: s /= Void
			enough_capacity: capacity >= s.count
		local
			index : INTEGER
		do
			from
				index := 1
			until
				index > s.count
			loop
				c_memory_put_uint8 (c_memory_pointer_plus (handle, index-1), s.item (index).code)
				index := index + 1
			end
			c_memory_put_uint8 (c_memory_pointer_plus (handle, s.count), 0)
			internal_count := s.count
		ensure
			equal_strings: equal_string (s)
			internal_count_set: internal_count = s.count
			count_set: count = s.count
		end

	from_substring (s : STRING; i_start, i_end : INTEGER)
			-- Copy `s' into Current
		require
			s_not_void: s /= Void
			enough_capacity: capacity >= i_end - i_start + 1
			i_start_within_bounds: i_start >= 1 and i_start <= s.count
			i_end_within_bounds: i_end >= i_start and i_end <= s.count
		local
			index : INTEGER
			offset : INTEGER
		do
			from
				index := i_start
				offset := 0
			until
				index > i_end
			loop
				c_memory_put_uint8 (c_memory_pointer_plus (handle, offset), s.item (index).code)
				index := index + 1
				offset := offset + 1
			end
			c_memory_put_uint8 (c_memory_pointer_plus (handle, offset), 0)
			internal_count := i_end - i_start + 1
		ensure
			equal_strings: equal_string (s.substring(i_start, i_end))
			internal_count_set: internal_count = i_end - i_start + 1
		end

	dispose
			--
		do
			if not is_shared and handle /= default_pointer then
				Precursor {XS_C_MEMORY}
			end
		end

	release
		require
			handle_valide: handle /= default_pointer
			not_shared: not is_shared
		do
			if not is_shared then
				c_memory_free (handle)
				is_released := True
				handle := default_pointer
			end
		end

feature -- Basic operations

	copy_to (s : STRING)
			-- copy 'Current' to `s'
		local
			length : INTEGER
		do
			s.wipe_out
			length := count
			if length > 0 then
				copy_substring_to (1, length, s)
			end
		ensure
			s_equal_as_string: as_string.is_equal (s)
		end

feature {NONE} -- Implementation

	set_empty
		do
			if empty_string /= Void then
				make_shared_from_pointer (empty_string.handle, 0)
			else
				handle := c_memory_allocate ( 1)
				c_memory_put_int8 (handle, 0)
			end
		end

	external_string_length (a_handle : POINTER) : INTEGER
		local
			index : INTEGER
		do
			from
				index := 0
			until
				index = capacity or else c_memory_get_uint8 (c_memory_pointer_plus (a_handle, index)) = 0
			loop
				index := index + 1
			end
			Result := index
		end

	internal_count : INTEGER
			-- Count obtained from an internal Eiffel String.

invariant
	is_valid_or_released: is_valid or else is_released

end -- class XS_C_STRING
--
-- Copyright: 2003-now, Paul G. Crismer, <pgcrism@users.sourceforge.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
