indexing
	description: "Objects that show the different line drawing operations"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_LINES

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
			test_line (d, p)
			p.translate (0, -150)
			test_rectangle (d, p)
			p.translate (0, -150)
			test_bezier_1 (d, p)
			p.translate (0, -150)
			test_bezier_2 (d, p)
			p.translate (0, -150)
			test_bezier_3 (d, p)
		end
		
	test_rectangle (d : PDF_DOCUMENT;p : PDF_PAGE) is
			-- 
		do
			p.begin_text
			p.move_text_origin (100, 130)
			show_title ("rectangle ", d, p)
			p.end_text
			p.rectangle ( 300, 50, 200, 90)
			p.stroke
		end
	
	test_line (d : PDF_DOCUMENT;p : PDF_PAGE) is
			-- 
		do
			p.begin_text
			p.move_text_origin (100, 130)
			show_title ("lineto ", d, p)
			p.end_text
			p.move (300, 50)
			p.lineto (500, 50)
			p.move (280, 50)
			p.lineto (400, 120)
			p.move (240, 110)
			p.lineto (320, 25)
			p.stroke
		end
		
	test_bezier_1 (d : PDF_DOCUMENT;p : PDF_PAGE) is
			-- 
		do
			p.begin_text
			p.move_text_origin (100, 130)
			show_title ("bezier_1 ", d, p)
			p.end_text
			p.move (300, 50)
			p.bezier_1(320, 150, 480, -50, 500,50)
			p.stroke
			-- display control point
			p.gsave
			p.set_line_dash (<<1, 5, 3, 5>>,1)
			p.move (300, 50)
			p.lineto (320, 150)
			p.stroke
			show_control_point (p, 320, 150)
			p.move (500, 50)
			p.lineto (480, -50)
			p.stroke
			show_control_point (p, 480, -50)
			p.grestore
		end

	test_bezier_2 (d : PDF_DOCUMENT;p : PDF_PAGE) is
			-- 
		do
			p.begin_text
			p.move_text_origin (100, 130)
			show_title ("bezier_2 ", d, p)
			p.end_text
			p.move (300, 50)
			p.bezier_2 (320, 150, 500, 50)
			p.stroke
			-- display control point
			p.gsave
			p.set_line_dash (<<1, 5, 3, 5>>,1)
			p.move (300, 50)
			p.lineto (320, 150)
			p.stroke
			show_control_point (p, 320, 150)
			p.grestore
		end
	
	test_bezier_3 (d : PDF_DOCUMENT;p : PDF_PAGE) is
			-- 
		do
			p.begin_text
			p.move_text_origin (100, 130)
			show_title ("bezier_3 ", d, p)
			p.end_text
			p.gsave
			p.translate (0, 50)
			p.move (300,50)
			p.bezier_3(480,-50, 500,50)
			p.stroke
			-- display control point
			p.gsave
			p.set_line_dash (<<1, 5, 3, 5>>,1)
			p.move (500, 50)
			p.lineto (480, -50)
			p.stroke
			show_control_point (p, 480, -50)
			p.grestore
			p.grestore
		end

end -- class TEST_LINES
--
-- Copyright: 2001, 2003 Paul G. Crismer, <pgcrism@users.sf.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
