indexing
	description: "Objects that test user space transformations"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_MATRIX

inherit
	TEST_HELPER

feature -- Basic operations

	do_test (d : PDF_DOCUMENT) is
		local
			p : PDF_PAGE
		do
			p := d.last_page
			d.find_font ("Helvetica", d.Encoding_standard)
			p.set_font (d.last_font, 10)
			p.translate (100, p.mediabox.ury - 250)
			test_xformations (d, p)
			p.translate (0, -200)
			test_clipping (d, p)
		end

	test_xformations (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		do
			p.gsave
			show_title_xy (100, 130, "User space transformations", d, p)
			center_label (50, 0, "scale (1, 2)", p)
			center_label (170, 0, "rotate (Pi/8)",p)
			center_label (290, 0, "translate (25,25)",p)
			center_label (410, 0, "skew (Pi/16, Pi/8)", p)
			p.translate (0, 15) -- do not draw on labels...
			-- scale
			p.gsave
			show_initial_axes (p)
			p.scale(1,2)
			show_new_axes (p)
			show_n (p)
			p.grestore
			-- rotate Pi/4
			p.translate (120, 0)
			p.gsave
			show_initial_axes (p)
			p.rotate (p.math.Pi / 8)
			show_new_axes (p)
			show_n (p)
			p.grestore
			-- translate 25,25
			p.translate (120, 0)
			p.gsave
			show_initial_axes (p)
			p.translate(25,25)
			show_new_axes (p)
			show_n (p)
			p.grestore
			-- skew Pi/16, Pi/8
			p.translate (120, 0)
			p.gsave
			show_initial_axes (p)
			p.skew (p.math.Pi/16, p.math.Pi/8)
			show_new_axes (p)
			show_n (p)
			p.grestore
			p.grestore
		end
		
	test_clipping (d : PDF_DOCUMENT; p : PDF_PAGE) is
		do
			p.gsave
			show_title_xy (100, 180, "Clipping operations", d, p)
			p.set_font (p.current_font, 10)
			center_label (80, 0, "no clip",p)
			center_label (230, 0, "clip", p)
			center_label (380, 0, "clip then stroke", p)
			-- no clip
			draw_lines (p)
			-- clip
			p.translate (150, 0)
			p.gsave
			put_star (75, 75, 70, p)
			p.clip
			p.end_path
			draw_lines (p)
			p.grestore
			-- clip then stroke
			p.translate (150, 0)
			p.gsave
			put_star (75, 75, 70, p)
			p.clip
			p.stroke
			draw_lines (p)
			p.grestore
			p.grestore
		end

	draw_lines (p : PDF_PAGE) is
			-- 
		local
			index : INTEGER
		do
			p.gsave
			p.translate (0, 12)
			from
				index := 1
			until
				index > 11
			loop
				p.set_line_width (index)
				p.move (0, 0)
				p.lineto (150, 0)
				p.stroke
				p.translate (0, 12)
				index := index + 1
			end
			p.grestore
		end
		
	show_initial_axes (p : PDF_PAGE) is
		do
			p.gsave
			p.set_line_dash (<<3, 5>>,0)
			p.set_rgb_color_stroke (1, 0, 0)
			show_axes (p)
			p.grestore
		end
		
	show_new_axes (p : PDF_PAGE) is
			-- 
		do
			p.gsave
			p.set_line_dash (<<2, 2, 1, 2>>,0)
			show_axes (p)
			p.grestore
		end
		
	show_axes (p : PDF_PAGE) is
			-- 
		do
			p.gsave
			-- draw coordinate axes
			-- y
			p.move (0, -5)
			p.lineto (0, 50)
			-- x
			p.move (-5, 0)
			p.lineto (50, 0)
			p.stroke
			p.grestore
		end		

	show_n (p : PDF_PAGE) is
			-- 
		do
			p.gsave
			p.set_font (p.current_font, 65)
			p.set_text_render_mode (p.Text_render_stroke)
			p.begin_text
			p.put_string ("n")
			p.end_text
			p.grestore
		end
		
feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end -- class TEST_MATRIX
--
-- Copyright: 2001, 2003 Paul G. Crismer, <pgcrism@users.sf.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
