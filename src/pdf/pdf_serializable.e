indexing

	description: "Objects that can be serialized in PDF Format"
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."
	
deferred class

	PDF_SERIALIZABLE
			
feature {PDF_SERIALIZABLE} -- Access

	number : INTEGER is deferred end
	
feature {PDF_OBJECT, PDF_CONVERSION_ACCESS, PDF_SERIALIZABLE} -- Conversion

	to_pdf : STRING is
			-- convert to PDF format
		deferred
		end
	
	indirect_reference : STRING is
			-- indirect reference
			-- only for PDF objects
		do
			Result := to_pdf
		end
	
	put_pdf (medium : PDF_OUTPUT_MEDIUM) is
			-- put document to `medium'

		require
			medium_exists: medium /= Void
		do
			medium.put_string (to_pdf)			
		end
	
feature {NONE} -- Implementation

	to_pdf_using_put_pdf : STRING is 
			-- Current converted to PDF using `put_pdf'
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

end -- class PDF_SERIALIZABLE
		