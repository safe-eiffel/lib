note
	description: "Types xsd:dateTime"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	XSD_DATE_TIME

inherit
	XSD_DATE
		rename
			is_valid as is_valid_date,
			regex as date_regex,
			formatted as date_formatted,
			regex_string as date_regex_string
			
		undefine
			fi2
		end
		
	XSD_TIME
		rename
			is_valid as is_valid_time,
			regex as time_regex,
			formatted as time_formatted,
			regex_string as time_regex_string
		end
		
feature -- Access
	
feature -- Measurement

feature -- Status report

	is_valid (text : STRING) : BOOLEAN
			-- Is `text' representing a valid dateTime ?
		do
			Result := is_valid_date (date_part (text)) and then is_valid_time (time_part (text))
		end
		
feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

	to_date_time (text : STRING) : DT_DATE_TIME
			-- DT_DATE_TIME object obtained from `text'.
		require
			text_not_void: text /= Void
			valid_text: is_valid (text)
		local
			l_date : DT_DATE
			l_time : DT_TIME
		do
			l_date := to_date (date_part (text))
			l_time := to_time (time_part (text))
			create Result.make_from_date_time (l_date, l_time)
		ensure
			result_not_void: Result /= Void
		end

	formatted (dt : DT_DATE_TIME) : STRING
			-- String object obtained by formatting `dt' accordingly to ISO 8601.
		require
			dt_not_void: dt /= Void
		do
			Result := date_formatted (dt.date)
			Result.append_character (date_time_separator)
			Result.append_string (time_formatted (dt.time))
		end
		
feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	date_time_separator : CHARACTER = 'T'
	
	date_literal_length : INTEGER = 10
	
	date_part (s : STRING) : STRING
		require
			s_not_void: s /= Void
		do
			Result := s.substring (1, date_literal_length)
		end
		
	time_part (s : STRING) : STRING
		require
			s_not_void: s /= Void
		do
			Result := s.substring (date_literal_length + 2, s.count)
		end
		
end -- class XSD_DATE_TIME
