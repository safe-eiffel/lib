indexing

	description: "PDF array as a PDF_OBJECT (needs a number)."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class

	PDF_ARRAY_OBJECT[G]

inherit

	PDF_OBJECT
		rename
			make as make_pdf_object
		undefine
			is_equal, copy
		end

	PDF_ARRAY[G]
		rename
			make as pdf_array_make
		redefine
			to_pdf
		end


creation
	make

feature {NONE} -- Initialization

	make (a_number : INTEGER; a_lower, an_upper : INTEGER) is
			-- make object `a_number', with bounds within [a_lower..an_upper]
		do
			make_pdf_object (a_number)
			make_array (a_lower, an_upper)
		end

feature -- Conversion

	to_pdf : STRING is
		do
			create Result.make (0)
			Result.append_string (object_header)
			Result.append_string (Precursor)
			Result.append_string (object_footer)
		end

end -- class PDF_ARRAY_OBJECT
