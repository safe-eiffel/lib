indexing
	description: 
	
		"Objects that show PDF line drawing attributes"

	author: 	"Paul G. Crismer"
	licencing: 	"See notice at end of class"
	date: 		"$Date$"
	revision: 	"$Revision$"

class
	TEST_LINE_ATTRIBUTES

inherit
	TEST_HELPER
	
feature -- Initialization

	do_test (d : PDF_DOCUMENT) is
			-- 
		local
			p : PDF_PAGE
		do
			p := d.last_page
			d.find_font ("Helvetica", d.Encoding_standard)
			p.set_font (d.last_font, 10)
			p.translate (0, p.mediabox.ury-200)
			test_line_width (d, p)
			p.translate (0, -150)
			test_line_cap (d, p)
			p.translate (0, -150)
			test_line_join (d, p)
			p.translate (0, -150)
			test_dash (d, p)
			p.translate (0, -150)
		end

	test_line_width (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		local
			index : INTEGER
			widths : ARRAY[DOUBLE]
		do
			-- show title
			show_title_xy (100, 130,"Line width", d, p)
			p.begin_text
			p.set_text_leading (12)
			p.move_text_origin (180, 90)
			-- show labels
			widths := <<1,2,3,4, 6, 8, 10>>
			from
				index := widths.lower
			until
				index > widths.upper
			loop
				p.put_string( (widths.item (index)).truncated_to_integer.out)
				p.put_new_line
				index := index + 1
			end
			p.end_text
			-- show lines
			p.gsave
			p.move (200, 102 + 5 ) 
				-- 102 = 90 + 12 
				-- +5 which is half the text size of the label
			from
				index := widths.lower
			until
				index > widths.upper
			loop
				p.set_line_width (widths.item(index))
				p.move (200, p.current_y - 12)
				p.lineto (400, p.current_y)
				p.stroke
				index := index + 1
			end
			p.grestore
		end
		
	test_line_cap (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		do
			p.gsave
			-- show title
			show_title_xy (100, 130, "Line cap", d, p)
			-- show labels
			p.begin_text
			p.set_font (d.last_font, 10)
			p.move_text_origin (120, 80)
			p.put_string ("Butt cap")
			p.move_text_origin (150, 0)
			p.put_string ("Round cap")
			p.move_text_origin (150, 0)
			p.put_string ("Projecting square cap")
			p.end_text
			p.begin_text
			p.move_text_origin (100, 10)
			p.put_string ("White squares show begin- and end-points.  This allows to see the line projection beyond the points.")
			p.end_text
			p.grestore
			-- show caps
			p.gsave
			p.set_line_width (12)
--
----	Butt_cap : INTEGER is 0
----			-- Butt cap. The stroke is squared off at the endpoint of
----			-- the path. There is no projection beyond the end of
----			-- the path.
--
			p.set_line_cap (p.Butt_cap)
			p.translate (120, 10)
			show_cap (p)
----
----	Round_cap : INTEGER is 1
----			-- Round cap. A semicircular arc with a diameter equal
----			-- to the line width is drawn around the endpoint and
----			-- filled in.
--
			p.set_line_cap (p.Round_cap)
			p.translate (150, 0)
			show_cap (p)
--
----
----	Projecting_square_cap : INTEGER is 2
----			-- Projecting square cap. The stroke continues beyond
----			-- the endpoint of the path for a distance equal to half
----			-- the line width and is then squared off.

			p.set_line_cap (p.Projecting_square_cap)
			p.translate (150, 0)
			show_cap (p)
			p.grestore
		end

	test_line_join (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		do
			p.gsave
			-- show title
			show_title_xy (100, 130, "Line join", d, p)
			-- show labels
			p.begin_text
			p.set_font (d.last_font, 10)
			p.move_text_origin (120, 80)
			p.put_string ("Miter join")
			p.move_text_origin (150, 0)
			p.put_string ("Round join")
			p.move_text_origin (150, 0)
			p.put_string ("Bevel join")
			p.end_text
			p.grestore
			-- show caps

--	Miter_join : INTEGER is 0
--			-- Miter join. The outer edges of the strokes for the two
--			-- segments are extended until they meet at an angle, as
--			-- in a picture frame. If the segments meet at too sharp
--			-- an angle (as defined by the miter limit parameter—
--			-- see “Miter Limit,”), a bevel join is used instead.
--
			p.gsave
			p.set_line_width (15)
			p.set_line_join (p.Miter_join)
			p.translate (120, 10)
			show_join (p)

--	Round_join : INTEGER is 1
--			-- Round join. A circle with a diameter equal to the line
--			-- width is drawn around the point where the two
--			-- segments meet and is filled in, producing a rounded
--			-- corner.
--			-- Note: If path segments shorter than half the line width
--			-- meet at a sharp angle, an unintended “wrong side” of
--			-- the circle may appear.
--

			p.set_line_join (p.Round_join)
			p.translate (150, 0)
			show_join (p)
			
--	Bevel_join : INTEGER is 2
--			-- Bevel join. The two segments are finished with butt
--			-- caps (see “Line Cap Style” on page 139) and the
--			-- resulting notch beyond the ends of the segments is
--			-- filled with a triangle.	

			p.set_line_join (p.Bevel_join)
			p.translate (150, 0)
			show_join (p)
			p.grestore
		end

	test_dash (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		do
			-- show title
			show_title_xy (100,130,"Line dash", d, p)
			-- set text attributes for next labels
			p.set_font (d.last_font, 10)
			p.set_line_width (1)
			p.translate (0, 80)
			-- show different dash patterns
			p.set_line_solid
			show_dash (p, "line_solid -  No dash; solid, unbroken lines")
			p.translate (0, - 20)
			p.set_line_dash (<<3>>,0)
			show_dash (p, "[3] 0 - 3 units on, 3 units off, …")
			p.translate (0, - 20)
			p.set_line_dash (<<2>>, 1)
			show_dash (p, "[2] 1 - 1 on, 2 off, 2 on, 2 off, …")
			p.translate (0, - 20)
			p.set_line_dash (<<2, 1>>, 0)
			show_dash (p, "[2 1] 0 - 2 on, 1 off, 2 on, 1 off, …")
			p.translate (0, - 20)
			p.set_line_dash (<<3, 5>>, 6)
			show_dash (p, "[3 5] 6 - 2 off, 3 on, 5 off, 3 on, 5 off, …")
			p.translate (0, - 20)
			p.set_line_dash (<<2,3>>,11)
			show_dash (p, "[2 3] 11 - 1 on, 3 off, 2 on, 3 off, 2 on, …")
		end
		
feature {NONE} -- Implementation

	show_dash (p : PDF_PAGE; comment : STRING) is
			-- 
		do
			p.gsave
			-- scale 10 times so that pattern is verrry visible
			p.scale (10,10)
			p.move (10, 1)
			p.lineto (29,1)
			p.stroke
			p.grestore
			-- show comment
			p.begin_text
			p.move_text_origin (300, 6)
			p.put_string (comment)
			p.end_text		
		end

	show_join (p : PDF_PAGE) is
			-- 
		do
			p.gsave
			-- draw lines
			p.move (0, 0)
			p.lineto (60, 60)
			p.lineto (120, 0)
			p.stroke
			-- show control point
			p.set_gray (1)
			show_control_point (p, 60,60)
			p.grestore			
		end
	
	show_cap (p : PDF_PAGE) is
			-- 
		do
			p.gsave
			-- draw lines
			p.move (0, 50)
			p.lineto (130, 50)
			p.stroke
			-- show control points
			p.set_gray (1)
			show_control_point (p, 0, 50)
			show_control_point (p, 130, 50)
			p.grestore
		end
		
invariant
	invariant_clause: True -- Your invariant here

end -- class TEST_LINE_ATTRIBUTES
--
-- Copyright: 2001, 2003 Paul G. Crismer, <pgcrism@users.sf.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
