indexing
	description: "Objects iterates over a string, word by word."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	WORDER

inherit
	ANY
		rename
		export
		undefine
		redefine
		select
		end

creation
	make

feature -- Initialization

	make (s : STRING) is
			-- 
		require
			s /= Void
		do
			string := s
		ensure
			string_aliased: string =s
		end
		
feature -- Access

	string : STRING
	
	current_word_begin : INTEGER
	current_word_end : INTEGER
	
	last_word : STRING
	
feature -- Status report

	off : BOOLEAN
	
	is_separator (index : INTEGER) : BOOLEAN is
			-- 
		require
			index > 0 and index <= string.count
		do
			inspect string.item (index)
			when ' ', '%T', '%N' then
				Result := True
			else
				Result := False
			end
		end
	
feature -- Cursor movement

	start is
			-- 
		do
			current_word_begin := 1
			current_word_end := 0
			forth
		end
		
	forth is
			-- 			
		local
			end_of_word : BOOLEAN
		do
			from
				forth_loop_init
			until
				current_word_end > string.count or is_separator (current_word_end)			
			loop
				forth_loop_action
				current_word_end := current_word_end + 1
			end
			if current_word_end > string.count then
				off := True
			end
			last_word := get_substring (string, current_word_begin, current_word_end - 1)
		end

	skip_separators is
			-- 
		local
			done : BOOLEAN
		do
			from
			until
				current_word_begin > string.count or else done
			loop
				if is_separator (current_word_begin) then
					current_word_begin := current_word_begin + 1
				else
					done := True
				end
			end
		ensure
			current_word_begin <= string.count implies not is_separator (current_word_begin) 
		end
		
feature {NONE} -- Implementation

	forth_loop_init is
		do
			current_word_begin := current_word_end + 1
			skip_separators
			current_word_end := current_word_begin				
		end
		
	forth_loop_action is
		do
		end
	
	get_substring (s: STRING; b, e : INTEGER) : STRING is
		do
			Result :=s.substring (b,e)
		end
		
invariant
	invariant_clause: -- Your invariant here

end -- class WORDER
--
-- Copyright: 2001, Paul G. Crismer, <pgcrism@planetinternet.be>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
