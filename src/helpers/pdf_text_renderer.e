indexing

	description: "Objects that render and measure text"
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class
	PDF_TEXT_RENDERER

feature -- Initialization

feature -- Access

feature -- Measurement

	tx (c : CHARACTER; font : PDF_FONT; font_size, character_spacing, word_spacing, position_adjustment, horizontal_scaling : DOUBLE) : DOUBLE is
			-- character horizontal displacement
			-- position_adjustment is used with TJ
		require
			font_set: font /= Void
		do
			Result := ((font.wx (c.code) - position_adjustment) / 1000) * font_size + character_spacing
			if c = ' ' then
				Result := Result + word_spacing
			end
			Result := Result * (horizontal_scaling / 100)
		end

	text_width (txt : STRING; font : PDF_FONT; font_size, character_spacing, word_spacing, horizontal_scaling : DOUBLE) : DOUBLE is
			-- 
		local
			i_begin, i_end : INTEGER
			current_width, current_char_width : DOUBLE
			is_word : BOOLEAN
		do
			from
				i_begin := 1
				i_end := i_begin
				current_width := 0
			until
				i_end > txt.count
			loop
				current_char_width := tx (txt.item (i_end), font, font_size, character_spacing, word_spacing, 0.0, horizontal_scaling)
				current_width := current_width + current_char_width
				i_end := i_end + 1
			end
			Result := current_width
		end
		
	text_width_stream (txt : STRING; p : PDF_PAGE) : DOUBLE is
			-- 
		do
			Result := text_width (txt, p.current_font, p.current_font_size, p.character_spacing, p.word_spacing, p.horizontal_scaling)
		end
		
	ty (c : CHARACTER; font : PDF_FONT; font_size, character_spacing, word_spacing, position_adjustment : DOUBLE; horizontal_scaling : INTEGER) : DOUBLE is
			-- character vertical displacement
			-- position_adjustment is used with TJ
		require
			font_set: font /= Void
		do
			Result := ((font.wy (c.code) - position_adjustment) / 1000) * font_size + character_spacing
			if c = ' ' then
				Result := Result + word_spacing
			end
		end

	tx_page (c : CHARACTER; p : PDF_PAGE; position_adjustment : DOUBLE) : DOUBLE is
			-- 
		do
			Result := tx (c, p.current_font, p.current_font_size, p.character_spacing, p.word_spacing, position_adjustment, p.horizontal_scaling)
		end
		
feature -- Basic operations

	put_text (txt : STRING; page : PDF_PAGE; width : DOUBLE) is
			-- put text 'txt' on 'page', beginning at current line position
			-- and writing lines no longer than 'width'
			-- if width is reached, a new line is printed
			
		require
			txt /= Void
		local
			i_begin, i_end : INTEGER
			current_char_width, current_width : DOUBLE
			lines, words : INTEGER
		do
			from
				i_begin := 1
				lines := 1
			until
				i_begin > txt.count or else i_end > txt.count
			loop
				if lines > 1 then
					--skip spaces
					from
						
					until
						i_begin > txt.count or else txt.item (i_begin) /= ' '
					loop
						i_begin := i_begin + 1
					end
				end
				from
					current_width := 0
					i_end := i_begin
				until
					i_end > txt.count or else current_width > width
				loop
					current_char_width := tx_page (txt.item (i_end), page, 0.0)
					current_width := current_width + current_char_width
					i_end := i_end + 1
				end
				-- i_end always an index too far wrt 
				i_end := i_end - 1
				if current_width > width then
					-- one character too far
					i_end := i_end - 1
				end
				if lines = 1 then
					page.current_stream.put_string (txt.substring (i_begin, i_end))
				else
					page.current_stream.put_new_line_string (txt.substring (i_begin, i_end))
				end
				
				i_begin := i_end + 1
				lines := lines + 1
			end			
		end

	string_width (string : STRING; page : PDF_PAGE) : DOUBLE is
			-- 
		require
			string /= Void
			page /= Void
		do
			Result := text_width_stream (string, page)
		end
		
feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end -- class PDF_TEXT_RENDERER
--
-- Copyright: 2001, 2003 Paul G. Crismer, <pgcrism@users.sf.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
