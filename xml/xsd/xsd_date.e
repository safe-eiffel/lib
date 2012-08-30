note
	description	: "Types xsd:date."

	library: "-"
	
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	XSD_DATE
	
feature -- Access
	
feature -- Measurement

feature -- Status report

	is_valid (text : STRING) : BOOLEAN
			-- Is `text' representing a valid date ?
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

	to_date (text : STRING) : DT_DATE
			-- DT_DATE instance created from `text'.
		require
			text_not_void: text /= Void
			valid_text: is_valid (text)
		local
			l_year : STRING
			l_month : STRING
			l_day : STRING
		do
			Regex.match (text)
			l_year := Regex.captured_substring (1)
			l_month := Regex.captured_substring (2)
			l_day := Regex.captured_substring (3)
			create Result.make (l_year.to_integer, l_month.to_integer, l_day.to_integer)
		ensure
			result_not_void: Result /= Void
		end
		
feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	formatted (d : DT_DATE) : STRING
			-- String object obtained by formatting `d' according to ISO 8601 rules.
		require
			d_not_void: d /= Void
		do
			create Result.make (10)
			Result.append_string (fi4.formatted (d.year))
			Result.append_character ('-')
			Result.append_string (fi2.formatted (d.month))
			Result.append_character ('-')
			Result.append_string (fi2.formatted (d.day))		
		end
		
feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	regex : RX_PCRE_REGULAR_EXPRESSION
			-- regular expression conforming to xsd:date simple format : no timezone
		once
			create Result.make
			Result.compile (regex_string)
		end
		
	regex_string : STRING = "([0-9][0-9][0-9][0-9])\-([0-9][0-9])\-([0-9][0-9])"
	
	fi2 : FORMAT_INTEGER
			-- 
		once
			create Result.make (2)
			Result.zero_fill
		end
	
	fi4 : FORMAT_INTEGER
			-- 
		once
			create Result.make (4)
			Result.zero_fill
		end
		
end -- class XSD_DATE
