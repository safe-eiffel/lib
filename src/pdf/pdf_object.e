indexing

	description:"PDF Object. (PDFReference 3.2)."
	author: 	"Paul G. Crismer"
	licence: 	"Release under the Eiffel Forum licence.  See file 'forum.txt'."
	
deferred class

	PDF_OBJECT

inherit

	PDF_SERIALIZABLE
		redefine
			indirect_reference
		end
	
feature {NONE} -- Initialization

	make (a_number : INTEGER) is
			-- make object referenced as `a_number'
		require
			number_positive: a_number >= 0
		do
			number := a_number
		ensure
			number_set: number = a_number
		end
		
feature -- Access

	number : INTEGER
		-- PDF object number
		
	generation : INTEGER
		-- generation number : new = 0; updated > 0

feature {NONE} -- Access

	object_header : STRING is
		do
			create Result.make (0)
			Result.append_string (object_identification)
			Result.append_string (" obj%N")
		end

	object_footer : STRING is
		once
			Result := "endobj%N%N"
		end
		
	begin_dictionary : STRING is
		once
			Result := "<< "
		end
		
	end_dictionary : STRING is
		once
			Result := " >>%N"
		end
		
feature {NONE} -- Implementation
	
	object_identification : STRING is
		do
			create Result.make (0)
			Result.append_string (number.out)
			Result.append_string (" ")
			Result.append_string (generation.out)
		end			
	
	dictionary_entry (name : PDF_NAME; value : STRING) : STRING is
		require
			name_exists: name /= Void
			value_exists: value /= Void
		do
			create Result.make (0)
			Result.append_string (name.to_pdf)
			Result.append_character (' ')
			Result.append_string (value)
			Result.append_character ('%N')			
		end

	pdf_string (s: STRING) : STRING is
			-- 
		require
			s_exists: s /= Void
		do
			create Result.make (s.count + 2)
			Result.append_character ('(')
			Result.append_string (s)
			Result.append_character (')')
		end

	pdf_date (dt : DT_DATE_TIME) : STRING is
			-- put `dt'
		require
			dt_exists: dt /= Void
		do
				--| (D:YYYYMMDDHHmmSSOHH'mm')
				--| where
			create Result.make (25)
			Result.append_string ("(D:")
			string_append_integer_4 (dt.year, Result)
				--| YYYY is the year
			string_append_integer_2 (dt.month, Result)
				--| MM is the month
			string_append_integer_2 (dt.day, Result)
				--| DD is the day (01–31)
			string_append_integer_2 (dt.hour, Result)
				--| HH is the hour (00–23)
			string_append_integer_2 (dt.minute, Result)
				--| mm is the minute (00–59)
			string_append_integer_2 (dt.second, Result)
				--| SS is the second (00–59)
			Result.append_string ("Z00'00')")
				--| O is the relationship of local time to Universal Time (UT), denoted by one of
				--| the characters +, -, or Z (see below)
				--| HH followed by ' is the absolute value of the offset from UT in hours (00–23)
				--| mm followed by ' is the absolute value of the offset from UT in minutes (00–59)
		end

	string_append_integer_2 (i : INTEGER; string : STRING) is
			-- 
		require
			i_valid: i >= 0 and i <= 100
			string_exists: string /= Void
		do
			if i < 10 then
				string.append_character ('0')
			end
			string.append_string (i.out)
		end
		
	string_append_integer_4 (i : INTEGER; string : STRING) is
			-- 
		require
			i_valid: i >= 0 and then i <= 10000
			string_exists: string /= Void
		do
			if i < 10 then
				string.append_string ("000")
			elseif i < 100 then
				string.append_string ("00")
			elseif i < 1000 then
				string.append_character ('0')
			end
			string.append_string (i.out)
		end
		
feature -- Conversion

	indirect_reference : STRING is
			-- Indirect reference to Current
		do
			create Result.make(0)
			Result.append_string (object_identification)
			Result.append_string (" R")
		end

invariant

	non_negative_number: number >= 0
	
end -- class PDF_OBJECT
		