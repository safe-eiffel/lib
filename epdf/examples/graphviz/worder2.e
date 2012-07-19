indexing
	description: "Objects that iterate over a string, word by word. %
		% Substrings enclosed by double quotes are considered as words. %
		% Double quotes enclosing a word are suppressed."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	WORDER2

inherit
	WORDER
		redefine
			is_separator, forth_loop_init, forth_loop_action, get_substring
		end


create
	make

feature -- Status report

	quoted : BOOLEAN

	is_separator (index : INTEGER) : BOOLEAN is
			-- 
		do
			if quoted then
				Result := False
			else
				Result := Precursor (index)
			end
		end
		
feature {NONE} -- Implementation

	forth_loop_init is
		do
			Precursor
--			if current_word_end <= string.count and then string.item (current_word_end) = '"' then
--				quoted := True
--			end
		end
		
	forth_loop_action is
		do
			if string.item (current_word_end) = '"' then
				quoted := not quoted
			end
		end
		
	get_substring (s: STRING; b, e : INTEGER) : STRING is
		do
			if s.item (b) = '"' and s.item (e) = '"' then
				Result := s.substring (b+1, e-1)
			else
				Result :=s.substring (b,e)
			end
		end
invariant
	invariant_clause: -- Your invariant here

end -- class WORDER2
--
-- Copyright: 2001, Paul G. Crismer, <pgcrism@planetinternet.be>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
