indexing
	description: "Graphviz node."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	GRAPHVIZ_NODE

inherit
	GRAPHVIZ_FIGURE
	
creation
	make

feature -- Initialization

	make (sname : STRING; ax, ay, awidth, aheight : DOUBLE; slabel, sline, sshape : STRING; scolor : GRAPHVIZ_COLOR) is
		require
			sname /= Void
		do
			name := sname
			x := ax 
			y := ay 
			width := awidth 
			height := aheight 
			label := slabel
			line := sline
			shape := sshape
			color := scolor
		end

feature -- Access

	name : STRING
	x :	DOUBLE
	y :	DOUBLE
	width :	DOUBLE
	height :DOUBLE
	label :	STRING
	line :	STRING
	shape :	STRING
	color :	GRAPHVIZ_COLOR

feature -- Basic operations

	draw_pdf (p : PDF_PAGE) is
		local
			label_width : DOUBLE
			m : PDF_TRANSFORMATION_MATRIX
		do
			p.gsave
			if color /= void then
				color.draw_pdf (p)
			else
				p.set_gray_stroke (0)
			end
			p.gsave
			if shape.is_equal ("circle") then
				p.circle (x, y, width/2)
				p.stroke
			elseif shape.is_equal ("doublecircle") then
				p.circle (x, y, width/2)
				p.circle (x, y, (width/2)-5)
				p.stroke
			elseif shape.is_equal ("ellipse")  then
				p.ellipse (x-width/2, y-height/2, width, height)
				p.stroke
			elseif shape.is_equal ("plaintext") then
			else
				p.rectangle (x-width/2, y-height/2, width, height)
				p.stroke
			end
			p.grestore
			label_width := p.string_width (label)
--			!!m.set (1, 0, 0, 1,x+label_width/2, y-p.text_leading/2)
			!!m.set (1, 0, 0, 1,x-label_width/2, y)
			p.begin_text
			p.set_text_matrix (m)
			p.put_string (label)
			p.end_text
			p.grestore
		end
		
feature {NONE} -- Implementation
		
invariant
	invariant_clause: -- Your invariant here

end -- class GRAPHVIZ_NODE
--
-- Copyright: 2001, Paul G. Crismer, <pgcrism@planetinternet.be>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
