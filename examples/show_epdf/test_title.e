indexing
	description: 
		
		"Objects that show the title page for PDeiFfel"

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
			w, wf : DOUBLE
			s1, s2 : DOUBLE
		do
			s1 := 80
			s2 := 44
			p := d.last_page
			d.find_font ("Helvetica-Bold", d.Encoding_standard)
			p.set_horizontal_scaling (75)
			p.begin_text
			p.set_font (d.last_font, s1)
			w := p.string_width ("PDF")
			wf := p.string_width ("F")
			p.set_font (d.last_font, s2)
			w := w + p.string_width ("eifel")
			w := w - (wf*4/7)
			p.move_text_origin ((p.mediabox.urx-w)/2, p.mediabox.ury/2)
			p.set_text_leading (60)
			p.set_font (d.last_font, s1)
			p.set_gray (0.75)
			p.put_string ("PD")
			p.set_gray (0)
			p.set_font (d.last_font, s2)
			p.put_string ("ei")
			p.set_gray (0.75)
			p.set_font (d.last_font, s1)
			p.put_string ("F")
			p.set_gray (0)
			p.set_font (d.last_font, s2)
			p.move_text_origin (p.text_x-p.line_x-(wf*4/7),0)
			p.put_string ("fel")
			p.end_text
			d.find_font ("Times-Roman", d.Encoding_standard)
			p.set_horizontal_scaling (100)
			p.set_font (d.last_font, 24)
			center_label (p.mediabox.urx/2, (p.mediabox.ury/2)-70, "A simple Eiffel library", p)
			center_label (p.mediabox.urx/2, (p.mediabox.ury/2)-100, "for PDF document creation", p)
			center_label (p.mediabox.urx/2, (p.mediabox.ury/2)-150, "by Paul G. Crismer", p)
		end
		
feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end -- class TEST_TITLE
--
-- Copyright: 2001, Paul G. Crismer, <pgcrism@pi.be>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
