indexing

	description: "Objects that can be serialized in PDF Format"
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."
	
deferred class

	PDF_SERIALIZABLE
			
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
	
end -- class PDF_SERIALIZABLE
		