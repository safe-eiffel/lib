indexing
	description: "PDF Rectangle"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_RECTANGLE

inherit
	
	PDF_ARRAY[INTEGER]
		rename
			make as make_pdf_array
		export 
			{NONE} all;
			{ANY} to_pdf
		end
		
creation
		make, make_a4, make_letter

feature -- Initialization

		make is
				-- Make an 'empty' rectangle
			do
				make_pdf_array(1, 4)
			ensure
				empty : llx = 0 and lly = 0 and urx = 0 and ury = 0
			end
			
		make_a4 is
				-- make 'a4' size rectangle, in points (1/72 inch)
			do
				make
				set (0, 0, 595, 842)
				is_constant := True
			ensure
				ll_corner: llx = 0 and lly = 0
				ur_corner: urx=595 and ury = 842
			end
			
		make_letter is
				-- make 'letter' size rectangle, in points (1/72 inch)
			do
				make
				set (0, 0, 612, 792)
				is_constant := True
			ensure
				ll_corner: llx = 0 and lly = 0
				ur_corner: urx=595 and ury = 842
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

feature -- Measurement
	
	width : INTEGER is do Result := urx - llx end
	
	height : INTEGER is do Result := ury - lly end
	
feature -- Status report

	is_constant : BOOLEAN
			-- is this rectangle constant ?

	has_point (x, y : INTEGER) : BOOLEAN is
			-- has Current the point at (x,y) ?
		do
			Result := (x >= llx and x <= urx) and then (y >= lly and y <= ury)
		end
		
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

end -- class PDF_RECTANGLE
