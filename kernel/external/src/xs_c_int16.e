note
	description: "C allocated 16 bits integer (short)."
	author: "Paul G. Crismer"

	library: "XS_C : eXternal Support C"

	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	XS_C_INT16

inherit
	XS_C_ITEM[INTEGER]

create
	make

feature -- Access

	item : INTEGER
			-- item
		do
			Result := c_memory_get_int16 (handle)
		end

feature -- Measurement

	item_size : INTEGER do Result := 2 end

	minimum_value : INTEGER = -32768
	maximum_value : INTEGER = 32767

feature -- Element change

	put (value : INTEGER)
			-- put `value'
		do
			c_memory_put_int16 (handle, value)
		end

invariant
	handle_not_default_pointer: handle /= default_pointer

end -- class XS_C_INT16

--
-- Copyright: 2003, Paul G. Crismer, <pgcrism@users.sourceforge.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
