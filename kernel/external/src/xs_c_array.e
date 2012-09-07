note
	description: "C allocated arrays of `item_size' bytes items."
	author: "Paul G. Crismer"

	library: "XS_C : eXternal Support C"

	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

deferred class
	XS_C_ARRAY [G -> attached ANY]

inherit
	XS_C_MEMORY

feature {NONE} -- Initialization

	make (a_capacity : INTEGER)
			-- create for `a_capacity' elements
		require
			valid_capacity: a_capacity > 0
		do
			handle := c_memory_allocate (a_capacity * item_size)
			capacity := a_capacity
		ensure
			capacity_set: capacity = a_capacity
		end

feature -- Access

	item (index : INTEGER) : G
			-- item at `index'
		require
			valid_index: index >= lower and index <= upper

		deferred
		end

feature -- Measurement

	capacity : INTEGER
			-- capacity of array

	count : INTEGER
			-- number of elements
		do
			Result := capacity
		end

	item_size : INTEGER
			-- size in bytes of an item
		deferred
		ensure
			positive_size: Result > 0
		end

	lower : INTEGER = 1
			-- lower index

	upper : INTEGER
			-- upper index
		do
			Result := capacity
		ensure
			definition: Result = capacity
		end

feature -- Element change

	put (value : G; index : INTEGER)
			-- put `value' at `index'
		require
			valid_index: index >= lower and index <= upper
		deferred
		ensure
			item_set: item (index).is_equal (value)
		end

feature {NONE} -- Implementation

	item_pointer (index : INTEGER) : POINTER
			-- pointer of `index'-th item
		do
			Result := c_memory_pointer_plus (handle, (index - 1) * item_size)
		end
invariant
	valid: is_valid

end -- class XS_C_ARRAY
--
-- Copyright: 2003-2012, Paul G. Crismer, <pgcrism@users.sourceforge.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
