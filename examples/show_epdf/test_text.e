indexing
	description: 
		
		"Objects that show 'put_text'."

	author: 	"Paul G. Crismer"
	licencing: 	"See notice at end of class"
	date: 		"$Date$"
	revision: 	"$Revision$"

class
	TEST_TEXT

inherit
	TEST_HELPER
	

feature -- Basic operations

	do_test (d : PDF_DOCUMENT) is
			-- 
		local
			p : PDF_PAGE
		do
			p := d.last_page
			d.find_font ("Helvetica", d.Encoding_standard)
			p.set_font (d.last_font, 10)
			test_renderer (d, p)
		end
		
	test_renderer (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		do
			show_title_xy (100, p.mediabox.ury-100, "Simple text drawing operator : put_text", d,p)
			p.rectangle (100, 100, 200, p.mediabox.ury-250)
			p.stroke
			p.begin_text
			d.find_font ("Helvetica", d.Encoding_winansi)
			p.set_font (d.last_font, 24)
			p.set_text_leading (26.5)
			p.move_text_origin (100, p.mediabox.ury-150-p.text_leading)
			p.put_text ("ePDF is an Eiffel Library that allows the creation of simple PDF %
			% documents. It supports various graphics operations, text operations and provides some smart %
			% operations like 'put_text'.  %%Put_text%% allows you to write text within a box, but without %
			% any word wrapping.%NUnsupported are images, XObjects, patterns, document encoding and encryption.", 200)
			p.end_text
			p.set_line_dash (<<3>>, 1)
			p.rectangle (350, 100, 200,  p.mediabox.ury-250)
			p.stroke
			p.set_font (d.last_font, 10)
			p.set_text_leading (11.5)
			p.begin_text
			p.move_text_origin (350, p.mediabox.ury-150-p.text_leading)
			p.put_text ("ePDF is an Eiffel Library that allows the creation of simple PDF %
			% documents. It supports various graphics operations, text operations and provides some smart %
			% operations like 'put_text'.  %%Put_text%% allows you to write text within a box, but without %
			% any word wrapping.%NUnsupported are images, XObjects, patterns, document encoding and encryption.", 200)

			p.set_word_spacing (3)
			p.move_text_origin (0, -p.text_leading*2)
			p.put_text ("ePDF is an Eiffel Library that allows the creation of simple PDF %
			% documents. It supports various graphics operations, text operations and provides some smart %
			% operations like 'put_text'.  %%Put_text%% allows you to write text within a box, but without %
			% any word wrapping.%NUnsupported are images, XObjects, patterns, document encoding and encryption.", 200)

			p.set_character_spacing (1)
			p.move_text_origin (0, -p.text_leading*2)
			p.put_text ("ePDF is an Eiffel Library that allows the creation of simple PDF %
			% documents. It supports various graphics operations, text operations and provides some smart %
			% operations like 'put_text'.  %%Put_text%% allows you to write text within a box, but without %
			% any word wrapping.%NUnsupported are images, XObjects, patterns, document encoding and encryption.", 200)

			p.set_horizontal_scaling (200)
			p.move_text_origin (0, -p.text_leading*2)
			p.put_text ("ePDF is an Eiffel Library that allows the creation of simple PDF %
			% documents. It supports various graphics operations, text operations and provides some smart %
			% operations like 'put_text'.  %%Put_text%% allows you to write text within a box, but without %
			% any word wrapping.%NUnsupported are images, XObjects, patterns, document encoding and encryption.", 200)
			p.end_text
			
		end
		
feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end -- class TEST_TEXT
--
-- Copyright: 2001, 2003 Paul G. Crismer, <pgcrism@users.sf.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
