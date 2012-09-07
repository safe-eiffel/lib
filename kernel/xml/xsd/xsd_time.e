note
	description	: "Types xsd:time."

	library: "-"
	
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	XSD_TIME
	
feature -- Access
	
feature -- Measurement

feature -- Status report

	is_valid (text : STRING) : BOOLEAN
			-- is `text' representing a valid date ?
		do
			if Regex.matches (text) then
				Result := True
			end
		end
		
feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

	to_time (text : STRING) : DT_TIME
			-- DT_TIME object obtained from `text'.
		require
			text_not_void: text /= Void
			valid_text: is_valid (text)
		local
			l_hour : STRING
			l_minute : STRING
			l_second : STRING
			l_centiseconds : STRING
			milliseconds : INTEGER
		do
			Regex.match (text)
			l_hour := Regex.captured_substring (1)
			l_minute := Regex.captured_substring (2)
			l_second := Regex.captured_substring (3)
			if regex.match_count >= 5 then
				l_centiseconds := Regex.captured_substring (5)
				milliseconds := l_centiseconds.to_integer
				from
					
				until
					milliseconds <= 999
				loop
					milliseconds := milliseconds // 10
				end
			else
			end
			create Result.make_precise (l_hour.to_integer, l_minute.to_integer, l_second.to_integer, milliseconds)
		ensure
			result_not_void: Result /= Void
		end

	formatted (t : DT_TIME) : STRING
			-- String object obtained by formatting `t' accordingly to ISO 8601.
		require
			t_not_void: t /= Void
		do
			create Result.make (12)
			Result.append_string (fi2.formatted (t.hour))
			Result.append_character (':')
			Result.append_string (fi2.formatted (t.minute))
			Result.append_character (':')
			Result.append_string (fi2.formatted (t.second))
			Result.append_character ('.')
			Result.append_string (fi3.formatted (t.millisecond))			
		end
		
feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	regex : RX_PCRE_REGULAR_EXPRESSION
			-- regular expression conforming to xsd:time simple format : no deviation from UTC
		once
			create Result.make
			Result.compile (regex_string)
		end

	regex_string : STRING = "(\d{1,2}):(\d{2}):(\d{2})(\.(\d{1,}))?"
	
	fi2 : FORMAT_INTEGER
			-- 
		once 
			create Result.make (2)
			Result.zero_fill
		end
	
	fi3 : FORMAT_INTEGER
			-- 
		once
			create Result.make (3)
			Result.zero_fill
		end
		
end -- class XSD_TIME
