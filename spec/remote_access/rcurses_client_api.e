indexing
	description: "CLIENT API for remote curses calls"
    cluster: 	"ecurses, spec"
    interface: 	"mixin"
    status: 	"See notice at end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	RCURSES_CLIENT_API

feature -- Access

	remote_curses: RCURSES_CLIENT is
		once
			!!Result.make
		end

feature -- Conversion

	new_pointer_for_identifier (an_identifier: STRING): POINTER is
			-- Create  a new pointer from `an_identifier'.
		do
			search_next_index
			identifiers.force (an_identifier, next_index)
			pointers.force (next_index ,an_identifier)
			Result := rcurses_integer_to_pointer (next_index)
		end

	pointer_from_identifier (an_identifier: STRING): POINTER is
			-- Obtain a pointer from `an_identifier'.
		local
			index: INTEGER
		do
			index := pointers.item (an_identifier)
			Result := rcurses_integer_to_pointer (index)
		end

	identifier_from_pointer (a_pointer: POINTER): STRING is
			-- Obtain the indentifier corresponding to `a_pointer'.
		local
			index: INTEGER
		do
			index := rcurses_pointer_to_integer (a_pointer)
			Result := identifiers.item (index)
		end
		
	release_identifier (a_pointer: POINTER) is
			-- Release identifier
		local
			index: INTEGER
		do
			index := rcurses_pointer_to_integer (a_pointer)
			pointers.remove (identifiers.item (index))
			identifiers.remove (index)		
		end
		

feature {NONE} -- Implementation

	identifiers: HASH_TABLE [STRING, INTEGER] is
			-- Table of indentifiers indexed by integers
			-- Used to hold (avoid garbage collection) pointer identifiers
		once
			!!Result.make (1000)
		end

	pointers: HASH_TABLE [INTEGER, STRING] is
			-- Table of integer (pointers) indexed by string identifiers
		once
			!!Result.make (1000)
		end

	next_index: INTEGER

	search_next_index is
			-- Search the next free index.
	 	do
			from
				next_index := next_index + 1	
			until
				not identifiers.has(next_index)
			loop
				next_index := next_index + 1				
			end
		end
		
	rcurses_integer_to_pointer (an_integer: INTEGER): POINTER is
		external "C" 
		end
		
	rcurses_pointer_to_integer (a_pointer: POINTER): INTEGER is
		external "C"
		end
	
end -- class RCURSES_CLIENT_API

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
