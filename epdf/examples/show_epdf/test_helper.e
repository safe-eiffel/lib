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
			-- Put `title' on page `p' of document `d', at coordinates (`x', `y')
		require
			d_attached: d /= Void
			p_attached: p /= Void
			p_not_in_text_mode: not p.is_text_mode
			title_not_void: title /= Void
		do
			p.begin_text
			p.move_text_origin (x, y)
			show_title (title, d, p)
			p.end_text
		ensure
			not p.is_text_mode
		end

	show_title (s : STRING; d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- Put title `s' on page `p' of document `d' at current text coordinates.
		require
			s_not_void: s /= Void
			d_not_void: d /= Void
			p_not_void: p /= Void
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
			-- Move down a quarter inch
		require
			p_not_void: p /= Void
		do
			-- move down a quarter inch
			p.move_text_origin (0, -18)
		end


	show_control_point (p : PDF_PAGE; x, y : DOUBLE) is
			-- Draw a control point (small box, 3 points large) on `p', centered at (`x',`y').
		require
			p_not_void: p /= Void
		do
			p.gsave
			p.set_line_width (0)
			box_centered (p, x, y, 3)
			p.grestore
		end

	box_centered (p: PDF_PAGE; x, y, w : DOUBLE) is
			-- draws a box, centered at (`x',`'y') and of width `y'
		require
			p_not_void: p /= Void
		do
			p.gsave
			p.rectangle (x-(w/2), y-(w/2), w, w)
			p.fill_then_stroke
			p.grestore
		end

	center_label (x, y : DOUBLE; label : STRING; p : PDF_PAGE) is
			-- Draw `label' centered at (`x',`y') on page `p'
		require
			p_not_void: p /= Void
			label_not_void: label /= Void
		do
			p.begin_text
			p.move_text_origin (x - p.string_width (label)/2, y)
			p.put_string (label)
			p.end_text
		end

	show_star (x, y , r: DOUBLE; p : PDF_PAGE) is
			-- Show a star, centered at (`x', `y') with radius `r'.
			-- Filled and stroked.
		require
			p_not_void: p /= Void
		do
			put_star (x, y, r, p)
			p.fill_then_stroke
		end

	put_star (x, y, r : DOUBLE; p : PDF_PAGE) is
			-- Draw a star in a new path, centered at (`x', `y') with radius `r'.
		require
			p_not_void: p /= Void
		local
			d4pi_5, d2pi_5, x_4pi_5, y_4pi_5, x_2pi_5, y_2pi_5 : DOUBLE
			math : EPDF_MATH
		do
			-- star radius
			-- calculate star points
			create math
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

end -- class TEST_HELPER
--
-- Copyright: 2001, 2003 Paul G. Crismer, <pgcrism@users.sf.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
