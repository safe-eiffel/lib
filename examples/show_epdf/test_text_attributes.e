indexing
	description: "Objects that show the usage of text attributes"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_TEXT_ATTRIBUTES

inherit
	TEST_HELPER
	
feature -- Basic operations

	do_test (d : PDF_DOCUMENT) is
			-- perform test
		local
			p : PDF_PAGE
			old_leading : DOUBLE
		do
			p := d.last_page
			-- move to top of page
			p.begin_text
			old_leading := p.text_leading
			p.set_text_leading (14)
			p.set_font (d.last_font, 12)
			p.move_text_origin (100, p.mediabox.ury - 100)
			test_next_line (d, p)
			test_move_text_origin (d, p)
			test_text_rise (d, p)
			test_character_spacing (d, p)
			test_word_spacing (d, p)
			test_horizontal_scaling (d, p)
			p.set_text_leading (old_leading)
			p.end_text
		end
		
	test_next_line (d : PDF_DOCUMENT; p : PDF_PAGE) is
			--
		do
			show_title ("Text leading", d, p)
			p.set_text_leading (14.5)
			p.put_string ("Text leading is the space separating one line from the next.")
			p.put_new_line_string ("A 'put_new_line' moves the next line origin down : Y = Y - text_leading")
			p.put_new_line_string ("Currently, text_leading is 14.5, while the font is 12 point high")
			p.put_new_line_string ("The line after is with text leading 20")
			p.set_text_leading  (20)
			p.put_new_line_string ("The line after is with text leadingg 12 (the font size)")
			p.set_text_leading (12)
			p.put_new_line_string ("Last line for this test")
			p.set_text_leading (14.5)
			put_space_after (p)
		end
		
	test_text_rise (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		local
			old_font, italic_font : PDF_FONT
			old_leading, old_font_size, italic_size : DOUBLE
		do
			show_title ("Text rise", d, p)
			old_leading := p.text_leading
			p.set_text_leading (p.current_font_size + 5)
			p.put_string ("Test text rise : ")
			p.put_string ("normal")
			p.set_text_rise (4)
			p.put_string ("rise 4")
			p.set_text_rise (-4)
			p.put_string ("rise -4")
			p.set_text_rise (0)
			p.put_new_line
			old_font := p.current_font
			old_font_size := p.current_font_size
			d.find_font ("Helvetica-Oblique", d.Encoding_winansi)
			italic_font := d.last_font
			italic_size := old_font_size * 0.75
			p.put_string ("Using text rise for")
			p.set_font (italic_font, italic_size)
			p.set_text_rise (p.current_font_size / 4)
			p.put_string("superscript")
			p.set_text_rise (0)
			p.set_font (old_font, old_font_size)
			p.put_string (" or for")
			p.set_font (italic_font, italic_size)
			p.set_text_rise (-p.current_font_size / 4)
			p.put_string("subscript")
			p.set_text_rise (0)
			p.set_font (old_font, old_font_size)
			p.put_string (" is very interesting!")
			p.set_text_leading (old_leading)
			put_space_after (p)
		end
		
	test_character_spacing (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		do
			show_title ("Character spacing", d, p)
			p.put_string ("Default character spacing")
			p.set_character_spacing (5)
			p.put_new_line_string ("Character spacing is 5")
			p.set_character_spacing (0)
			put_space_after (p)
		end
		
	test_word_spacing (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		do
			show_title ("Word spacing", d, p)
			p.put_string ("Default word spacing")
			p.set_word_spacing (3)
			p.put_new_line_string ("Word spacing is 3")
			p.set_word_spacing (12)
			p.put_new_line_string ("Word spacing is 12")
			p.set_word_spacing (0)
			put_space_after (p)
		end
		
	test_horizontal_scaling (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		do
			show_title ("Horizontal scaling", d, p)
			p.put_string ("Horizontal scaling = 100")
			p.set_horizontal_scaling (150)
			p.put_new_line_string ("Horizontal scaling = 150")
			p.set_horizontal_scaling (75)
			p.put_new_line_string ("Horizontal scaling = 75")
			p.set_horizontal_scaling (100)
			put_space_after (p)
		end

	test_move_text_origin (d : PDF_DOCUMENT; p : PDF_PAGE) is
		do
			show_title ("Move text origin", d, p)
			p.set_font (d.last_font, 12)
			p.set_text_leading (14.5)
			p.put_string ("1.'move_text_origin' is an operation relative to the current position")
			p.put_new_line_string ("The coordinate system uses 'point' (1/72 inch) as logical unit")
			p.put_new_line_string ("Coordinate (0,0) is the lower left corner on the page.")
			p.put_new_line_string (" Positive X goes to the right; Positive Y goes up.")
			p.move_text_origin (36,-36)
			p.put_string ("Text origin has been moved by (.5,-.5) inch - X right, Y down.")
			p.put_new_line_string ("This has an effect for the next lines.")
			p.move_text_origin (-36,-36)
			p.put_string ("Text origin has been moved back by (.5,.5) inch.")
			put_space_after (p)
		end

invariant
	invariant_clause: True -- Your invariant here

end -- class TEST_TEXT_ATTRIBUTES
--
-- Copyright: 2001, 2003 Paul G. Crismer, <pgcrism@users.sf.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
