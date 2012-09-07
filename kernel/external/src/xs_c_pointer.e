note
	description: "C allocated pointer : contains a reference to something else."
	author: "Paul G. Crismer"

	library: "XS_C : eXternal Support C"

	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	XS_C_POINTER

inherit
	XS_C_MEMORY

create
	make

feature -- Initialization

	make
		do
			handle := c_memory_allocate (item_size)
		end

feature -- Access

	item : POINTER
			-- item
		do
			Result := c_memory_get_pointer (handle)
		end

	as_integer : INTEGER
		do
			Result := c_memory_get_int32 (handle)
		end

feature -- Measurement

	item_size : INTEGER
		external "C inline"
		alias
			"return (sizeof(EIF_POINTER));"
		end

feature -- Element change

	put (value : POINTER)
			-- put `value'
		do
			c_memory_put_pointer (handle, value)
		end

invariant
	handle_not_default_pointer: handle /= default_pointer

end -- class XS_C_POINTER
--
-- Copyright: 2003-2012, Paul G. Crismer, <pgcrism@users.sourceforge.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
