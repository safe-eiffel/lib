indexing
	description: "PDF Rectangle"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_RECTANGLE

	-- Replace ANY below by the name of parent class if any (adding more parents
	-- if necessary); otherwise you can remove inheritance clause altogether.
inherit
	
	PDF_ARRAY[INTEGER]
		rename
			make as make_pdf_array
		end
		
creation
		make, make_a4, make_letter

feature -- Initialization

		make is
				-- 
			do
				make_pdf_array(1, 4)
			end
			
		make_a4 is
				-- 
			do
				make
				set (0, 0, 595, 842)
				is_constant := True
			end
			
		make_letter is
				-- 
			do
				make
				set (0, 0, 612, 792)
				is_constant := True
			end
			
feature -- Access

	llx : INTEGER is
			-- lower left
		do
			Result := item (1)
		end
		
	lly : INTEGER is
			-- lower left x
		do
			Result := item (2)
		end
			
	urx : INTEGER is
			-- upper right x
		do
			Result := item (3)
		end
			
	ury : INTEGER is
			-- upper right y
		do
			Result := item (4)
		end

feature -- Status report

	is_constant : BOOLEAN
			-- is this rectangle constant ?
			
feature -- Element change

	set (a_llx, a_lly, a_urx, a_ury : INTEGER) is
			-- set rectangle points
		require
			modifiable: not is_constant
		do
			put (a_llx, 1)
			put (a_lly, 2)
			put (a_urx, 3)
			put (a_ury, 4)
		ensure
			llx = a_llx
			lly = a_lly
			urx = a_urx
			ury = a_ury
		end
		
feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end -- class PDF_RECTANGLE
