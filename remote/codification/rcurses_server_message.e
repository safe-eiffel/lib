indexing
	description: "Objects that encode/decode a curses server message"
    cluster: 	"ecurses, spec, remote_access"
    status: 	"See notice at do end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	RCURSES_SERVER_MESSAGE

inherit
	RCURSES_MESSAGE
	
create
	make, make_from_string

feature  -- Initialization

	make (result_list: DS_LINKED_LIST[ANY]) is
			-- Initialize with `result_list'.
		require
			result_list_exists: result_list /= Void
		local
			i: INTEGER
		do
			from
				result_list.start
				create results.make (1, result_list.count)
				i := results.lower
			until
				result_list.off
			loop
				results.put (result_list.item_for_iteration.out, i)
				result_list.forth
				i := i + 1
			end
		end

	make_from_string (a_string: STRING) is
			-- Initialize message from the encoded string representation.
		local
			start_pos,end_pos: INTEGER
			token: STRING
			results_count: INTEGER
			result_length: INTEGER
			i: INTEGER
		do			
			--|Extract results count
			start_pos := 1
			end_pos := a_string.index_of (separator, start_pos)
			if end_pos = 0 then
				end_pos := a_string.count
			else
				end_pos := end_pos -1
			end
			token := a_string.substring (start_pos, end_pos)
			results_count := token.to_integer
			
			from
				create results.make (1, results_count)
				i := 1
			until
				i > results_count
			loop
				--|Extract result_length
	
				start_pos := end_pos + 2 
				end_pos := a_string.index_of (separator, start_pos) - 1
				token := a_string.substring (start_pos, end_pos)
				result_length := token.to_integer

				--| Extract result
				start_pos := end_pos + 2 
				end_pos := start_pos + result_length - 1
				token := a_string.substring (start_pos, end_pos)
				results.put (token, i)
				
				i := i + 1		
			end					
		end


feature -- Access

	results: ARRAY[STRING]
			-- Returned results.

feature -- Conversion

	to_string: STRING is
			-- Encode message in a string.
		local
			i: INTEGER
			s: STRING
		do
			from
				create Result.make (70)
				result.append_string (results.count.out)
				i := results.lower		
			until
				i > results.upper
			loop
				Result.append_character (separator)				
				s := results.item(i)
				Result.append_string (s.count.out)
				Result.append_character (separator)
				Result.append_string (s)
				i := i + 1
			end
		ensure then
			-- (result_1, .. result_n) is encoded as "results.count results.item(1).count results.item(1) ... results.item(n).count results.item(n)
		end

	trace_output: STRING is
			-- Output for trace.
		local
			i: INTEGER
			s: STRING
		do
			from
				create Result.make (70)
				result.append_string ("(")
				i := results.lower		
			until
				i > results.upper
			loop
				s := results.item(i)
				Result.append_string (s)
				i := i + 1
				if i <= results.upper then
					Result.append_string (", ")
				end
			end
			Result.append_string (")")
		end

		
invariant
	results_not_void: results /= Void
	
end -- class RCURSES_SERVER_MESSAGE

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
