indexing
	description: "Objects that..."

	usage: ""
	quality: ""
	refactoring: ""

	status: "see notice at end of class";
	date: "$Date$";
	revision: "$Revision$";
	author: ""

class FO_TEX_HYPHEN_FILE

inherit
	KL_TEXT_INPUT_FILE
		redefine
			open_read
		end
		
create
	make
	
feature {NONE} -- Initialization

feature -- Access

	last_pattern : STRING
	
	last_hyph : STRING
	
feature -- Measurement

feature -- Comparison

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

	open_read is
		local
			done : BOOLEAN
		do
			Precursor
			if is_open_read then
				from
					
				until
					end_of_input or else done
				loop
					read_word
					if not end_of_input and then last_string.is_equal ("\patterns{") then
						done := True
					end			
				end
				if end_of_input then
					close
				end
			end
			create last_pattern.make (10)
			create last_hyph.make (10)
		end
		
	read_pattern is
		do
			from
				read_word
			until
				end_of_input or else (last_string.count > 0 and then last_string.item(1)/='%%')
			loop
				read_line
				if not end_of_input then
					read_word
				end
			end
			if last_string.is_equal("}") then
				end_of_file := True
			end
			if not end_of_file and then last_string.count > 0 then
				analyze_pattern
			end
		end
		
feature -- Obsolete

feature -- Inapplicable

feature -- Constants

feature {NONE} -- Implementation

	patterns_regex: RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("\patterns{")
		end
		
	analyze_pattern is
		local
			pattern_index : INTEGER
			i : INTEGER
			c : CHARACTER
			c1, c2 : CHARACTER
			k, n : CHARACTER
		do
			from
				last_pattern.wipe_out
				last_hyph.wipe_out
				i := 1
				pattern_index := 1
				n := '0'
			until
				i > last_string.count
			loop
				c := last_string.item (i)
				inspect c
				when '0'..'9' then
					n := c
					i := i + 1
				when '\' then
					c1 := last_string.item (i + 1)
					c2 := last_string.item (i + 2)
					k := translate_character (c1,c2)
					i := i + 3
				else
					k := c
					i := i + 1
				end
				if k /= '%U' then
					last_pattern.append_character (k)
					last_hyph.append_character (n)
					k := '%U'
					n := '0'
				end
			end
			last_hyph.append_character (n)
		ensure
			one_more:last_hyph.count-last_pattern.count = 1
		end

	translate_character (c1,c2 : CHARACTER) : CHARACTER is		
		do
			inspect c1
			when ''' then
				inspect c2
				when 'a' then
					Result := 'á'
				when 'e' then
					Result := 'é'
				when 'i' then
					Result := 'í'
				when 'o' then
					Result := 'ó'
				when 'u' then
					Result := 'ú'
				else
					
				end
			when '`' then
				inspect c2
				when 'a' then
					Result := 'à'
				when 'e' then
					Result := 'è'
				when 'i' then
					Result := 'ì'
				when 'o' then
					Result := 'ò'
				when 'u' then
					Result := 'ù'
				else
					
				end
			when '^' then
				inspect c2
				when 'a' then
					Result := 'â'
				when 'e' then
					Result := 'ê'
				when 'i' then
					Result := 'î'
				when 'o' then
					Result := 'ô'
				when 'u' then
					Result := 'û'
				else
					
				end
			when '¨' then
				inspect c2
				when 'a' then
					Result := 'ä'
				when 'e' then
					Result := 'ë'
				when 'i' then
					Result := 'ï'
				when 'o' then
					Result := 'ö'
				when 'u' then
					Result := 'ü'
				else
					
				end
			when 'o' then
				inspect c2
				when 'e'  then
					Result := 'œ'
				else
					
				end
			else
				
			end
		end
		
end

