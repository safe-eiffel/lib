indexing
	description: 
	
		"Objects that show text clipping modes."

	author: 	"Paul G. Crismer"
	licencing: 	"See notice at end of class"
	date: 		"$Date$"
	revision: 	"$Revision$"

class
	TEST_TEXT_CLIP

inherit 
	TEST_HELPER
	
feature -- Basic operations

	do_test (d : PDF_DOCUMENT) is
			-- perform test
		local
			p : PDF_PAGE
			ytranslation : DOUBLE
		do
			d.find_font ("Helvetica", d.Encoding_standard)
			p := d.last_page
			ytranslation := p.mediabox.ury-250
			test_clip (d, p, ytranslation)
			test_stroke_n_clip (d, p, ytranslation-150)
			test_fill_n_clip (d,p, ytranslation-300)
			test_fill_then_stroke_n_clip (d,p, ytranslation-450)
		end
		
	test_clip (d : PDF_DOCUMENT; p : PDF_PAGE; yt : DOUBLE) is
			-- 
		do
			p.gsave
			p.translate (100, yt)
			do_test_clipping (d, p, "Render mode - clip (only)", p.Text_render_clip)
			p.grestore
		end
		
	test_stroke_n_clip (d : PDF_DOCUMENT; p : PDF_PAGE; yt : DOUBLE) is
		do
			p.gsave
			p.translate (100, yt)
			do_test_clipping (d, p, "Render mode - fill and clip", p.Text_render_fill_n_clip)
			p.grestore
		end

	test_fill_n_clip (d : PDF_DOCUMENT; p : PDF_PAGE; yt : DOUBLE) is
		do
			p.gsave
			p.translate (100, yt)
			do_test_clipping (d, p, "Render mode - stroke and clip", p.Text_render_stroke_n_clip)
			p.grestore
		end

	test_fill_then_stroke_n_clip (d : PDF_DOCUMENT; p : PDF_PAGE; yt : DOUBLE) is
		do
			p.gsave
			p.translate (100, yt)
			do_test_clipping (d, p, "Render mode - fill then stroke and clip", p.Text_render_fill_then_stroke_n_clip)
			p.grestore
		end
		
	do_test_clipping (d : PDF_DOCUMENT; p : PDF_PAGE; title : STRING; mode : INTEGER) is
			-- 
		local
			i : INTEGER
		do
			p.gsave
			-- clipping text
			p.begin_text
			p.set_font (d.last_font, 18)
			-- print title
			p.move_text_origin (0, 130)
			p.set_text_render_mode (p.Text_render_fill)
			p.put_string (title)
			p.end_text
			-- create clipping region
			p.grestore
			p.gsave
			p.set_text_render_mode (mode)
			p.begin_text
			p.set_gray (0.80)
			p.set_font (d.last_font, 170)
			p.move_text_origin (150, 36)
			p.set_horizontal_scaling (300)
			p.put_string ("a")
			p.end_text
			-- write inside clipping region
			p.begin_text
			p.set_text_render_mode (p.Text_render_fill)
			p.set_text_leading (9)
			p.set_font (d.last_font, 8)
			p.set_horizontal_scaling (100)
			p.move_text_origin (150, 120)
			p.set_gray (0) -- black
			from
				i := 1
			until 
				i > 15
			loop
				p.put_string (title)
				p.put_string (title)
				p.put_string (title)
				p.move_text_origin (0,-p.text_leading)
--				p.put_new_line
-- T* does not work after multiple gsave, grestore
				i := i + 1
			end
			p.end_text
			p.grestore
		end
		
end -- class TEST_TEXT_CLIP
--
-- Copyright: 2001, Paul G. Crismer, <pgcrism@pi.be>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
