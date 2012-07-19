indexing
	description: 
		
		"Objects that show the title page for ePDF"

	author: 	"Paul G. Crismer"
	licencing: 	"See notice at end of class"
	date: 		"$Date$"
	revision: 	"$Revision$"

class
	TEST_TITLE

inherit
	TEST_HELPER

feature -- Basic operations

	do_test (d : PDF_DOCUMENT) is
			-- 
		local
			p : PDF_PAGE
			w : DOUBLE
			s1, s2 : DOUBLE
		do
			s1 := 80
			s2 := 44
			p := d.last_page
			d.find_font ("Helvetica-Bold", d.Encoding_standard)
			p.set_horizontal_scaling (75)
			p.begin_text
			p.set_font (d.last_font, s1)
			w := p.string_width (" ePDF")
			p.move_text_origin ((p.mediabox.urx-w)/2, p.mediabox.ury/2)
			p.set_text_leading (60)
			p.set_font (d.last_font, s1)
			p.set_rgb_color (0.1, 0., 1.0)
			p.put_string ("e")
			p.set_rgb_color (1.0, 0., 0.1)
			p.put_string ("PDF")
			p.end_text
			d.find_font ("Times-Roman", d.Encoding_standard)
			p.set_horizontal_scaling (100)
			p.set_font (d.last_font, 24)
			p.set_gray (0)
			center_label (p.mediabox.urx/2, (p.mediabox.ury/2)-70, "A simple Eiffel library", p)
			center_label (p.mediabox.urx/2, (p.mediabox.ury/2)-100, "for PDF document creation", p)
			center_label (p.mediabox.urx/2, (p.mediabox.ury/2)-150, "by Paul G. Crismer", p)
		end

feature {NONE} -- Implementation

end -- class TEST_TITLE
--
-- Copyright: 2001, 2003 Paul G. Crismer, <pgcrism@users.sf.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
