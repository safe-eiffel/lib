indexing

	description: "Dictionary object."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."
	
class
	PDF_DICTIONARY_OBJECT

inherit
	PDF_OBJECT
		redefine
			make
		end
		
	PDF_DICTIONARY
		rename
			make as make_dictionary
		undefine
			indirect_reference
		redefine
			to_pdf
		end

creation
	make

feature -- Initialization

	make (a_number : INTEGER) is
			-- 
		do
			Precursor (a_number)
			make_dictionary
		end

feature -- Conversion

	to_pdf : STRING is
			-- 
		do
			!!Result.make (0)
			Result.append_string (object_header)
			Result.append_string (Precursor)
			Result.append_string (object_footer)
		end
		
end -- class PDF_DICTIONARY_OBJECT
