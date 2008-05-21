indexing
	description: "Objects that encode/decode a curses remote feature call"
    cluster: 	"ecurses, spec, remote_access"
    status: 	"See notice at do end of class"
    date: 		"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	RCURSES_CLIENT_MESSAGE

inherit
	RCURSES_MESSAGE
	
create
	make, make_from_string
	
feature {NONE} -- Initialization

	make(a_feature_identifier: INTEGER; arguments_array: ARRAY[ANY]) is
			-- Initialize message for `a_feature_identifier' and `arguments'
		require
			arguments_array_exists: arguments_array /= Void
		local
			i: INTEGER
		do
			feature_identifier := a_feature_identifier
			
			from
				i := arguments_array.lower
				create arguments.make (arguments_array.lower, arguments_array.upper)
			until
				i > arguments_array.upper
			loop
				arguments.put (arguments_array.item (i).out, i)
				i := i + 1
			end
		ensure
			feature_identifier_copied: feature_identifier = a_feature_identifier
			-- for each arguments_array.item(i) it holds that the string representation is in arguments.item(i)
		end

	make_from_string (a_string: STRING) is
			-- Initialize message from the encoded string representation.
		local
			start_pos,end_pos: INTEGER
			token: STRING
			arguments_count: INTEGER
			argument_length: INTEGER
			i: INTEGER
		do
			--| Extract feature_identifier
			start_pos := 1
			end_pos := a_string.index_of (separator, start_pos) - 1
			token := a_string.substring (start_pos, end_pos)
			feature_identifier := token.to_integer
			
			--|Extract arguments count
			start_pos := end_pos + 2 
			end_pos := a_string.index_of (separator, start_pos)
			if end_pos = 0 then
				end_pos := a_string.count
			else
				end_pos := end_pos -1
			end
			token := a_string.substring (start_pos, end_pos)
			arguments_count := token.to_integer
			
			from
				create arguments.make (1, arguments_count)
				i := 1
			until
				i > arguments_count
			loop
				--|Extract argument_length
	
				start_pos := end_pos + 2 
				end_pos := a_string.index_of (separator, start_pos) - 1
				token := a_string.substring (start_pos, end_pos)
				argument_length := token.to_integer

				--| Extract argument
				start_pos := end_pos + 2 
				end_pos := start_pos + argument_length - 1
				token := a_string.substring (start_pos, end_pos)
				arguments.put (token, i)
				
				i := i + 1		
			end					
		end

		
feature -- Access

	feature_identifier: INTEGER
			-- Identifier of called feature.

	arguments: ARRAY[STRING]
			-- Arguments for feature call.
			
feature -- Conversion

	to_string: STRING is
			-- Encode message in a string.
		local
			i: INTEGER
			s: STRING
		do
			from
				create Result.make (70)
				Result.append_string (feature_identifier.out)
				result.append_character (separator)
				result.append_string (arguments.count.out)
				i := arguments.lower		
			until
				i > arguments.upper
			loop
				Result.append_character (separator)				
				s := arguments.item(i)
				Result.append_string (s.count.out)
				Result.append_character (separator)
				Result.append_string (s)
				i := i + 1
			end
		ensure then
			-- featurename (arg1, .. argn) is encoded as "featurename arguments.count arguments.item(1).out.count arguments.item(1).out ... arguments.item(n).out.count arguments.item(n).out
		end

	trace_output: STRING is
			-- Output for trace.
		local
			i: INTEGER
			s: STRING
			dictionnary: RCURSES_DICTIONNARY
		do
			from
				create dictionnary
				create Result.make (70)
				dictionnary.search (feature_identifier)
				if dictionnary.found then
					Result.append_string (dictionnary.found_item)
				else
					Result.append_string (feature_identifier.out)
				end
				result.append_string (" (")
				i := arguments.lower		
			until
				i > arguments.upper
			loop				
				s := arguments.item(i)
				Result.append_string (s)
				i := i + 1
				if i <= arguments.upper then
					Result.append_string (", ")
				end
			end
			Result.append_string (")")
		end

feature {NONE} -- Implementation
	

invariant
	arguments_not_void: arguments /= Void
	
end -- class RCURSES_CLIENT_MESSAGE

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
