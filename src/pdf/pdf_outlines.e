indexing
	description: "Outlines node object."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class
	PDF_OUTLINES

inherit
	PDF_OBJECT

creation
	
	make

feature -- Initialization

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature {PDF_OBJECT} -- Conversion

	to_pdf : STRING is
			-- 
		do
			
		end


feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations


feature {NONE} -- Implementation

invariant
	invariant_clause: -- Your invariant here

end -- class PDF_OUTLINES
