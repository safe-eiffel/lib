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
			--
		require
			number_positive: a_number >= 0
		do
			number := a_number
		ensure
			number_set: number = a_number
		end
		
feature -- Access

	number : INTEGER
		-- object number
		
	generation : INTEGER
		-- generation number : new = 0; updated > 0

feature {NONE} -- Access

	object_header : STRING is
		do
			!!Result.make (0)
			Result.append (object_identification)
			Result.append (" obj%N")
		end

	object_footer : STRING is
		once
			Result := "endobj%N%N"
		end
		
	begin_dictionary : STRING is
		once
			Result := "<<%N"
		end
		
	end_dictionary : STRING is
		once
			Result := ">>%N"
		end
		
feature {NONE} -- Implementation
	
	object_identification : STRING is
		do
			!!Result.make (0)
			Result.append (number.out)
			Result.append (" ")
			Result.append (generation.out)
		end			
	
	dictionary_entry (name : PDF_NAME; value : STRING) : STRING is
		require
			name_exists: name /= Void
			value_exists: value /= Void
		do
			!!Result.make (0)
			Result.append (name.to_pdf)
			Result.append_character (' ')
			Result.append (value)
			Result.append_character ('%N')			
		end
		
feature -- Conversion

	indirect_reference : STRING is
		do
			!!Result.make(0)
			Result.append (object_identification)
			Result.append (" R")
		end

invariant

	non_negative_number: number >= 0
	
end -- class PDF_OBJECT
		