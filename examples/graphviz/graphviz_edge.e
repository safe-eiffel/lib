indexing
	description: "Graphviz edge."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	GRAPHVIZ_EDGE

inherit
	GRAPHVIZ_FIGURE


creation
	make

feature -- Initialization

	make (stail, shead : STRING; aax, aay : ARRAY[DOUBLE]; slabel : STRING;  alx, aly : DOUBLE; aline : STRING; acolor : GRAPHVIZ_COLOR) is
		require
			stail /= Void
			shead /= Void
			aax /= Void
			aay /= Void
		do
			tail := stail
			head := shead
			bezier_x := aax
			bezier_y := aay
			label := slabel
			label_x := alx 
			label_y := aly 
			line := aline
			color := acolor
		end

feature -- Access

	tail :	STRING
	head :	STRING
	bezier_x : ARRAY[DOUBLE]
	bezier_y : ARRAY [DOUBLE]
	label : STRING
	label_x : DOUBLE
	label_y : DOUBLE
	line : STRING
	color : GRAPHVIZ_COLOR

feature -- Basic operations

	draw_pdf (p : PDF_PAGE) is
		local
			label_width : DOUBLE
			m : PDF_TRANSFORMATION_MATRIX
			bcount : INTEGER
			bindex : INTEGER
			edge, a0, a1, a2 : LINE_SEGMENT
			math : EPDF_MATH
			slope_sign : INTEGER
		do
			bcount := bezier_x.count
			if not equal (line, "invis") then
				p.gsave
				if color /= Void then
					color.draw_pdf (p)
				else
					p.set_gray_stroke (0)
				end
				p.move (bezier_x.item (1), bezier_y.item (1))
				--draw bezier lines
				p.bezier_1 (bezier_x.item (2), bezier_y.item (2),
					bezier_x.item (3), bezier_y.item (3),
					bezier_x.item (4), bezier_y.item (4)
					)
				bindex := 5
				from
				until
					bindex > bcount or else bindex+2 > bcount
				loop
					p.bezier_1 (bezier_x.item (bindex), bezier_y.item (bindex),
					bezier_x.item (bindex+1), bezier_y.item (bindex+1),
					bezier_x.item (bindex+2), bezier_y.item (bindex+2))
					bindex := bindex + 3
				end
				p.stroke
				!!edge.make_2_points (bezier_x.item (bcount-1), bezier_y.item (bcount - 1),
									bezier_x.item (bcount), bezier_y.item (bcount))
				!!a0.make_polar (arrow_length, edge.theta)
				!!a1.make_polar (arrow_length/4, edge.theta + p.math.Pi /2)
				!!a2.make_polar (arrow_length/4, edge.theta - p.math.Pi /2)
				
				p.gsave
				if color /= Void then
					p.set_rgb_color (color.r, color.g, color.b)
				else
					p.set_gray (0)
				end
				p.move (edge.p1x + a0.p1x * edge.upside_down, edge.p1y + a0.p1y * edge.upside_down)
				p.lineto (edge.p1x + a1.p1x, edge.p1y + a1.p1y)
				p.lineto (edge.p1x + a2.p1x, edge.p1y + a2.p1y)
				p.close_path
				p.fill_then_stroke
				p.grestore
				p.grestore
			end
			--
			if label /= Void then
				label_width := p.string_width (label)
				!!m.set (1, 0, 0, 1, label_x-label_width /2, label_y)
				p.begin_text
				p.set_text_matrix (m)
				p.put_string (label)
				p.end_text
			end
		end
		
feature {NONE} -- Implementation

	arrow_length : DOUBLE is 7.0
	
invariant
	invariant_clause: -- Your invariant here
			-- draw arrow
			--
--			!!math
--			x1 := bezier_x.item (bezier_x.count)
--			x0 := bezier_x.item (bezier_x.count-1)
--			y1 := bezier_y.item (bezier_y.count)
--			y0 := bezier_y.item (bezier_y.count-1)
--			slope_sign := (x0-x1).sign
--			if (x0 - x1).abs < 0.0000001 then
--				-- slope is infinite
--				inspect (y0-y1).sign
--				when 1 then
--					theta := p.math.Pi /2
--				when -1 then
--					theta := - p.math.Pi / 2
--				else
--					theta := 0
--				end
--				theta := theta * slope_sign
--			else
--				theta := math.arc_tangent ((y0-y1)/(x0-x1))
--			end
--			ax0 := x1 - arrow_length * math.cosine (theta) * slope_sign
--			ay0 := y1 - arrow_length * math.sine (theta) * slope_sign
--			ax1 := x1 + (arrow_length / 4) * math.cosine (theta + p.math.Pi / 2) * slope_sign
--			ay1 := y1 + (arrow_length / 4) * math.sine (theta + p.math.Pi / 2) * slope_sign
--			ax2 := x1 + (arrow_length / 4) * math.cosine (theta - p.math.Pi / 2) * slope_sign
--			ay2 := y1 + (arrow_length / 4) * math.sine (theta - p.math.Pi / 2) * slope_sign

--			p.gsave
--			p.move (ax0, ay0)
--			p.lineto (ax1, ay1)
--			p.lineto (ax2, ay2)
--			p.close_path
--			p.set_gray (0)
--			p.fill_then_stroke
--			p.grestore

end -- class GRAPHVIZ_EDGE
--
-- Copyright: 2001, Paul G. Crismer, <pgcrism@planetinternet.be>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
