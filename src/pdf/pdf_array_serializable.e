indexing

	description: "PDF Array of PDF_SERIALIZABLE objects"
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class
	PDF_ARRAY_SERIALIZABLE [G->PDF_SERIALIZABLE]

inherit

	PDF_ARRAY [G]
			redefine
				to_pdf_item
			end
			
creation
	
	make

feature {NONE} -- Implementation

	to_pdf_item (n : INTEGER) : STRING is
		do
			Result := (item (n)).indirect_reference
		end

invariant
	invariant_clause: True -- Your invariant here

end -- class PDF_ARRAY_SERIALIZABLE
