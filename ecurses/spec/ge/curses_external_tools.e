indexing
	description: "Tools for Eiffel/External (to C) communication"
	author: "Paul G. Crismer, Eric Fafchamps"
	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

expanded class
	CURSES_EXTERNAL_TOOLS

feature -- Initialization

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	string_to_pointer (s : STRING) : POINTER is
			-- pointer to "C" version of 's'
		require
			good_string: s /= Void
		local
			a : ANY
		do
			a := s.to_c
			Result := pointer($a)
		end

	pointer_to_string (p : POINTER) : STRING is
		require
			good_pointer: p /= default_pointer
		do
			create Result.make (0)
			Result.from_c (p)
		end

	pointer (ptr : POINTER) : POINTER is
		do
			Result := ptr
		end

invariant
	invariant_clause: -- Your invariant here

end -- class CURSES_EXTERNAL_TOOLS
--
-- Copyright: 2000, Paul G. Crismer, <pgcrism@attglobal.net> ; Eric Fafchamps, <eric.fafchamps@win.be>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--

