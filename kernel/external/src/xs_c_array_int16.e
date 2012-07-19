note
	description: "C allocated arrays of 16 bits integer (short)."
	author: "Paul G. Crismer"

	library: "XS_C : eXternal Support C"

	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	XS_C_ARRAY_INT16

inherit
	XS_C_ARRAY [INTEGER]

create
	make

feature -- Access

	item (index : INTEGER) : INTEGER
			-- item at `index'
		local
			item_ptr : POINTER
		do
			item_ptr := item_pointer (index)
			Result := c_memory_get_int16 (item_ptr)
		end

feature -- Measurement

	item_size : INTEGER do Result := 2 end

feature -- Element change

	put (value : INTEGER; index : INTEGER)
			-- put `value' at `index'
		local
			item_ptr : POINTER
		do
			item_ptr := item_pointer (index)
			c_memory_put_int16 (item_ptr, value)
		end

end -- class XS_C_ARRAY_INT16

--
-- Copyright: 2003, Paul G. Crismer, <pgcrism@users.sourceforge.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
