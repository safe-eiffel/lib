indexing
	description: "PDF Rectangle"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_RECTANGLE

inherit
	
	PDF_ARRAY[DOUBLE]
		rename
			make as make_pdf_array
		export 
			{NONE} all;
			{ANY} to_pdf
		end
		
creation
		make, make_a4, make_letter, set

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
				constant: is_constant
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
				constant: is_constant
				ll_corner: llx = 0 and lly = 0
				ur_corner: urx=595 and ury = 842
			end
			
feature -- Access

	llx : DOUBLE is
			-- lower left
		do
			Result := item (1)
		end
		
	lly : DOUBLE is
			-- lower left x
		do
			Result := item (2)
		end
			
	urx : DOUBLE is
			-- upper right x
		do
			Result := item (3)
		end
			
	ury : DOUBLE is
			-- upper right y
		do
			Result := item (4)
		end

feature -- Measurement
	
	width : DOUBLE is 
		do 
			Result := urx - llx 
		ensure
			definition: Result = urx - llx
		end
	
	height : DOUBLE is 
		do 
			Result := ury - lly 
		ensure
			definition: Result = ury - lly
		end
	
feature -- Status report

	is_constant : BOOLEAN
			-- is this rectangle constant ?

	has_point (x, y : DOUBLE) : BOOLEAN is
			-- has Current the point at (x,y) ?
		do
			Result := (x >= llx and x <= urx) and then (y >= lly and y <= ury)
		end

	contains (other : PDF_RECTANGLE) : BOOLEAN is
			-- does Current contain `other'?
		do
			Result := llx <= other.llx
			Result := Result and then lly <= other.lly
			Result := Result and then urx >= other.urx
			Result := Result and then ury >= other.ury
		ensure
			definition_left: Result implies llx <= other.llx
			definition_bottom: Result implies lly <= other.lly
			definition_right: Result implies urx >= other.urx
			definition_top: Result implies ury >= other.ury
		end
		
feature -- Element change

	set (a_llx, a_lly, a_urx, a_ury : DOUBLE) is
			-- set rectangle points
		require
			modifiable: not is_constant
			lower_x_smaller_upper_x: a_llx < a_urx
			lower_y_smaller_upper_y: a_lly < a_ury
		do
			put (a_llx, 1)
			put (a_lly, 2)
			put (a_urx, 3)
			put (a_ury, 4)
		ensure
			llx_set: llx = a_llx
			lly_set: lly = a_lly
			urx_set: urx = a_urx
			ury_set: ury = a_ury
		end

invariant
	
	x_constraint: llx < urx
	y_constraint: lly < ury
	
end -- class PDF_RECTANGLE
