indexing
	description: "Objects that test font capabilities of ePDF"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_FONTS

inherit 
	TEST_HELPER
	
feature -- Basic operations

	do_test (d : PDF_DOCUMENT) is
			-- perform test
		local
			p : PDF_PAGE
			old_leading : DOUBLE
			destination : PDF_DESTINATION
			outline_chapter : PDF_OUTLINE_ITEM
		do
			p := d.last_page
			-- move to top of page
			d.find_font ("Helvetica", d.Encoding_standard)
			p.begin_text
			old_leading := p.text_leading
			p.set_font (d.last_font, 12)
			p.set_text_leading (14)
			p.move_text_origin (100, p.mediabox.ury - 100)
			outline_chapter := d.last_outline_item
			create {PDF_DESTINATION_XY_ZOOM}destination.make (p, p.text_x, p.text_y, 0)
			d.create_outline_item_with_destination ("Names", destination)
			outline_chapter.put_last (d.last_outline_item)
			test_font_names (d, p)
			create {PDF_DESTINATION_XY_ZOOM}destination.make (p, p.text_x, p.text_y, 0)
			d.create_outline_item_with_destination ("Sizes", destination)
			outline_chapter.put_last (d.last_outline_item)
			test_sizes (d,p)
			create {PDF_DESTINATION_XY_ZOOM}destination.make (p, p.text_x, p.text_y, 0)
			d.create_outline_item_with_destination ("Render modes", destination)
			outline_chapter.put_last (d.last_outline_item)
			test_render_modes (d,p)
			p.set_text_leading (old_leading)
			p.end_text
		end

	test_font_names (d : PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		local
			i : INTEGER
		do
			show_title ("Font names", d, p)
			p.set_text_leading (16)
			from
				i := font_names.lower
			until
				i > font_names.upper
			loop
				test_font_name (i, d, p)
				i := i + 1
			end
			put_space_after (p)
		end
		
	test_font_name (i : INTEGER; d: PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		do
			d.find_font (font_names.item (i), d.Encoding_standard)
			if d.last_font /= Void then
				p.set_font (d.last_font, 14)
				p.put_string ("This is font ")
				p.put_string (font_names.item (i))
				p.put_new_line
			end
		end

	test_render_modes (document : PDF_DOCUMENT; page : PDF_PAGE) is
			-- 
		do
			show_title ("Render modes", document, page)
			page.set_font (document.last_font, 24)
			page.set_text_leading (26)
			page.put_string ("Default render mode")
			page.set_text_render_mode (document.last_page.Text_render_stroke)
			page.put_new_line_string ("Stroke render mode")
			page.set_text_render_mode (page.Text_render_fill)
			page.put_new_line_string ("Fill render mode")
			page.set_text_render_mode (page.Text_render_fill_then_stroke)
			page.put_new_line_string ("Fill then stroke mode")
			put_space_after (page)
		end
	
	test_sizes (d: PDF_DOCUMENT; p : PDF_PAGE) is
			-- 
		local
			i : INTEGER
			old_leading : DOUBLE
		do
			show_title ("Font sizes", d, p)	
			old_leading := p.text_leading
			p.set_text_leading (12)
			from
				i := 2
			until
				i > 64
			loop
				if i > 12 then
					p.set_text_leading (i+2)
				end
				if i > 2 then 
					p.put_new_line
				end
				p.set_font (d.last_font, 10)
				p.put_string ("Size : ")
				p.put_string (i.out)
				p.set_font (d.last_font, i)
				p.put_string ("    The lazy dog jumps over the quick brown fox...")
				i := i * 2
			end
			p.set_text_leading (old_leading)
			put_space_after (p)
		end
		
		
feature {NONE} -- Implementation

	font_names : ARRAY[STRING] is
			-- 
		once
			Result := <<
				"Courier",
				"Helvetica",
				"Times-Roman",
				"Symbol",
				"Courier-Bold",
				"Helvetica-Bold",
				"Times-Bold",
				"ZapfDingbats",
				"Courier-Oblique",
				"Helvetica-Oblique",
				"Times-Italic",
				"Courier-BoldOblique",
				"Helvetica-BoldOblique",
				"Times-BoldItalic"
			 >>
		end

invariant
	invariant_clause: True -- Your invariant here

	
end -- class TEST_FONTS
--
-- Copyright: 2001, 2003 Paul G. Crismer, <pgcrism@users.sf.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
