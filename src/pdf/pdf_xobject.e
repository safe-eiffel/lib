indexing
	description: "Objects that represent XObjects"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PDF_XOBJECT

inherit
	PDF_OBJECT
		redefine
			put_pdf
		end

	
feature -- Conversion

	put_pdf (medium : PDF_OUTPUT_MEDIUM) is

		do			
			medium.put_string (object_header)
			put_pdf_content (medium)
			medium.put_string (object_footer)
		end

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	to_pdf : STRING is 
			-- Current converted to PDF
			-- `put_pdf' is preferred since it is more resource savvy.
		local
			buffer : KL_STRING_OUTPUT_STREAM
			medium : PDF_OUTPUT_MEDIUM
		do
			create Result.make (1_000)
			create buffer.make (Result)
			create medium.make (buffer)
			put_pdf (medium)
			Result := buffer.string
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	put_pdf_content (medium : PDF_OUTPUT_MEDIUM) is
		deferred
		end
		
invariant
	invariant_clause: True -- Your invariant here

end -- class PDF_XOBJECT
