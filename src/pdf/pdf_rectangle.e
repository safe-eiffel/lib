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
			make_constant (595, 842)
		ensure
			size_set:  llx = 0 and lly = 0 and  urx=595 and ury = 842
			constant: is_constant
		end
		
	make_letter is
			-- make 'letter' size rectangle, in points (1/72 inch)
		do
			make_constant (612, 792)
		ensure
			size_set:  llx = 0 and lly = 0 and  urx=595 and ury = 842
			constant: is_constant
		end
	
	make_note is
			-- make 'note' size rectangle, in points (1/72 inch)
		do
			make_constant (540, 720)
		ensure
			size_set:  llx = 0 and lly = 0 and  urx=540 and ury = 720
			constant: is_constant
		end

	make_legal is
			-- make 'legal' size rectangle, in points (1/72 inch)
		do
			make_constant (612, 1008)
		ensure
			size_set:  llx=0 and lly=0 and  urx=612 and ury=1008
			constant: is_constant
		end
		
	make_a0 is
			-- make 'a0' size rectangle, in points (1/72 inch)
		do
			make_constant (2380, 3368)
		ensure
			size_set:  llx=0 and lly=0 and  urx=2380 and ury=3368
			constant: is_constant
		end
		
	make_a1 is
			-- make 'a1' size rectangle, in points (1/72 inch)
		do
			make_constant (1684, 2380)
		ensure
			size_set:  llx=0 and lly=0 and  urx=1684 and ury=2380
			constant: is_constant
		end
		
	make_a2 is
			-- make 'a2' size rectangle, in points (1/72 inch)
		do
			make_constant (1190, 1684)
		ensure
			size_set:  llx=0 and lly=0 and  urx=1190 and ury=1684
			constant: is_constant
		end
		
	make_a3 is
			-- make 'a3' size rectangle, in points (1/72 inch)
		do
			make_constant (842, 1190)
		ensure
			size_set:  llx=0 and lly=0 and  urx=842 and ury=1190
			constant: is_constant
		end
	
	make_a5 is
			-- make 'a5' size rectangle, in points (1/72 inch)
		do
			make_constant (421, 595)
		ensure
			size_set:  llx=0 and lly=0 and  urx=421 and ury=595
			constant: is_constant
		end
		
	make_a6 is
			-- make 'a6' size rectangle, in points (1/72 inch)
		do
			make_constant (297, 421)
		ensure
			size_set:  llx=0 and lly=0 and  urx=297 and ury=421
			constant: is_constant
		end
		
	make_a7 is
			-- make 'a7' size rectangle, in points (1/72 inch)
		do
			make_constant (210, 297)
		ensure
			size_set:  llx=0 and lly=0 and  urx=210 and ury=297
			constant: is_constant
		end
		
	make_a8 is
			-- make 'a8' size rectangle, in points (1/72 inch)
		do
			make_constant (148, 210)
		ensure
			size_set:  llx=0 and lly=0 and  urx=148 and ury=210
			constant: is_constant
		end

	make_a9  is
			-- make 'a9' size rectangle, in points (1/72 inch)
		do
			make_constant (105, 148)
		ensure
			size_set:  llx=0 and lly=0 and  urx=105 and ury=148
			constant: is_constant
		end
		

	make_a10  is
			-- make 'a10' size rectangle, in points (1/72 inch)
		do
			make_constant (74, 105)
		ensure
			size_set:  llx=0 and lly=0 and  urx=74 and ury=105
			constant: is_constant
		end

	make_b0  is
			-- make 'b0' size rectangle, in points (1/72 inch)
		do
			make_constant (2836, 4008)
		ensure
			size_set:  llx=0 and lly=0 and  urx=2836 and ury=4008
			constant: is_constant
		end

	make_b1  is
			-- make 'b1' size rectangle, in points (1/72 inch)
		do
			make_constant (2004, 2836)
		ensure
			size_set:  llx=0 and lly=0 and  urx=2004 and ury=2836
			constant: is_constant
		end

	make_b2  is
			-- make 'b2' size rectangle, in points (1/72 inch)
		do
			make_constant (1418, 2004)
		ensure
			size_set:  llx=0 and lly=0 and  urx=1418 and ury=2004
			constant: is_constant
		end
		
	make_b3  is
			-- make 'b3' size rectangle, in points (1/72 inch)
		do
			make_constant (1002, 1418)
		ensure
			size_set:  llx=0 and lly=0 and  urx=1002 and ury=1418
			constant: is_constant
		end
		
	make_b4  is
			-- make 'b4' size rectangle, in points (1/72 inch)
		do
			make_constant (709, 1002)
		ensure
			size_set:  llx=0 and lly=0 and  urx=709 and ury=1002
			constant: is_constant
		end
		
	make_b5  is
			-- make 'b ' size rectangle, in points (1/72 inch)
		do
			make_constant (501, 709)
		ensure
			size_set:  llx=0 and lly=0 and  urx=501 and ury=709
			constant: is_constant
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

feature {NONE} -- Implementation

	make_constant (a_width, a_height : INTEGER) is
			-- make with constant a_width, a_height
		do
			make
			set (0, 0, a_width, a_height)
			is_constant := True
		end
		
end -- class PDF_RECTANGLE
