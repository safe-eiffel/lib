indexing
	description: "Message that can be encoded/decoded"
    cluster: 	"ecurses, spec, remote_access"
    status: 	"See notice at do end of class"
    date: 		"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

deferred class
	RCURSES_MESSAGE

feature -- Conversion

	to_string: STRING is
			-- Encode message in a string.
		deferred
		end

	make_from_string (a_string: STRING) is
			-- Initialize with encoded string representation.
		require
			string_exists: a_string /= Void
		deferred
		end

feature {NONE} -- Implementation

	separator: CHARACTER is ' '
			-- Used separator in encoding scheme.
			
end -- class RCURSES_MESSAGE

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
