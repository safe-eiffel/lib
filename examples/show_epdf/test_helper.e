indexing
	description: "Objects that implement helper operations for tests."
	author: "Paul G. Crismer"
	licencing: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_HELPER


feature {NONE} -- Implementation

	show_title_xy (x, y : DOUBLE; title : STRING; d : PDF_DOCUMENT; p : PDF_PAGE) is
		require
			not p.is_text_mode
		do
			p.begin_text
			p.move_text_origin (x, y)
			show_title (title, d, p)
			p.end_text
		ensure
			not p.is_text_mode
		end
		
	show_title (s : STRING; d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		local
			old_leading, old_font_size : DOUBLE
			old_font : PDF_FONT
		do
			old_leading := p.text_leading			
			old_font := p.current_font
			old_font_size := p.current_font_size
			d.find_font ("Helvetica", d.Encoding_standard)
			p.set_text_leading (20)
			p.put_new_line
			p.set_font (d.last_font, 18)
			-- indent left
			p.move_text_origin (-25,0)
			p.put_string (s)
			-- indent right + move down 1/3 inch
			p.move_text_origin (25,-24)
			p.set_text_leading (old_leading)
			p.set_font (old_font, old_font_size)
		end

	put_space_after (p : PDF_PAGE) is
		do
			-- move down a quarter inch
			p.move_text_origin (0, -18)
		end


	show_control_point (p : PDF_PAGE; x, y : DOUBLE) is
		do
			box_centered (p, x, y, 3)
		end
		
	box_centered (p: PDF_PAGE; x, y, w : DOUBLE) is
			-- draws a box, centered at x,y and of width y
		do
			p.gsave
			p.rectangle (x-(w/2), y-(w/2), w, w)
			p.fill
			p.stroke
			p.grestore
		end

	center_label (x, y : DOUBLE; label : STRING; p : PDF_PAGE) is
			-- 
		do
			p.begin_text
			p.move_text_origin (x - p.string_width (label)/2, y)
			p.put_string (label)
			p.end_text			
		end

	show_star (x, y , r: DOUBLE; p : PDF_PAGE) is
			-- 
		do
			put_star (x, y, r, p)
			p.fill_then_stroke
		end

	put_star (x, y, r : DOUBLE; p : PDF_PAGE) is
			-- 
		local
			d4pi_5, d2pi_5, x_4pi_5, y_4pi_5, x_2pi_5, y_2pi_5 : DOUBLE
			math : EPDF_MATH
		do
			-- star radius
			-- calculate star points
			!!math
			d4pi_5 := 4 * p.math.Pi / 5
			d2pi_5 := 2 * p.math.Pi / 5
			x_4pi_5 := math.cosine (d4pi_5)
			y_4pi_5 := math.sine (d4pi_5)
			x_2pi_5 := math.cosine (d2pi_5)
			y_2pi_5 := math.sine (d2pi_5)
			-- draw star
			p.move (x+r, y)
			p.lineto (x + r*x_4pi_5, y + r * y_4pi_5)
			p.lineto (x + r*x_2pi_5, y - r * y_2pi_5)
			p.lineto (x + r*x_2pi_5, y + r * y_2pi_5)
			p.lineto (x + r*x_4pi_5, y - r * y_4pi_5)
			p.close_path
		end
		
invariant
	invariant_clause: True -- Your invariant here

end -- class TEST_HELPER
--
-- Copyright: 2001, Paul G. Crismer, <pgcrism@pi.be>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
