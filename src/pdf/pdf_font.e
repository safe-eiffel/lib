indexing

	description: "PDF font objects."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

deferred class

	PDF_FONT

inherit

	PDF_OBJECT
		
feature -- Access

	type : PDF_NAME is
			-- Type name
		once
			!!Result.make ("Font")
		end
		
	subtype : PDF_NAME is
			-- Subtype name
		deferred
		end
		
	basefont : PDF_NAME is
			-- BaseFont name
		deferred
		end
		
	firstchar : INTEGER is
			-- FirstChar * first character code defined in font widths array
		deferred
		end
		
	lastchar : INTEGER is
			-- LastChar * last character code defined in font widths array
		deferred
		end
		
	widths : PDF_ARRAY[INTEGER] is
			-- Widths *  indirect reference to 
		deferred
		end
		
	encoding : PDF_CHARACTER_ENCODING is
			-- supported encoding
		deferred
		end

	wx (code : INTEGER) : INTEGER is
			-- width in 'x' direction of character 'code'
		do
			if code >= widths.lower and code <= widths.upper then
				Result := widths.item (code)
			else
				Result := 1000
			end
		end
		
	wy (code : INTEGER) : INTEGER is
			-- width in 'y' direction of character 'code'
			-- Result = 1000 since latin characters are only supported
		do
			Result := 1000
		end


	horizontal_displacement (c : CHARACTER; a_font_size, a_character_spacing, a_word_spacing, a_position_adjustment, a_horizontal_scaling : DOUBLE) : DOUBLE is
			-- character horizontal displacement
			-- position_adjustment is used with TJ
		do
			Result := ((wx (c.code) - a_position_adjustment) / 1000) * a_font_size + a_character_spacing
			if c = ' ' then
				Result := Result + a_word_spacing
			end
			Result := Result * (a_horizontal_scaling / 100)
		end

	vertical_displacement (c : CHARACTER; a_font_size, a_character_spacing, a_word_spacing, a_position_adjustment : DOUBLE; a_horizontal_scaling : INTEGER) : DOUBLE is
			-- character vertical displacement
			-- position_adjustment is used with TJ
		do
			Result := ((wy (c.code) - a_position_adjustment) / 1000) * a_font_size + a_character_spacing
			if c = ' ' then
				Result := Result + a_word_spacing
			end
		end

	string_width (string : STRING; a_font_size, a_character_spacing, a_word_spacing, a_horizontal_scaling : DOUBLE) : DOUBLE is
			-- string width for current font
		local
			i_begin, i_end : INTEGER
			current_width, current_char_width : DOUBLE
		do
			from
				i_begin := 1
				i_end := i_begin
				current_width := 0
			until
				i_end > string.count
			loop
				current_char_width := horizontal_displacement (string.item (i_end), a_font_size, a_character_spacing, a_word_spacing, 0.0, a_horizontal_scaling)
				current_width := current_width + current_char_width
				i_end := i_end + 1
			end
			Result := current_width
		end
		
invariant
	type_set: type /= Void
	subtype_set: subtype /= Void
	basefont_set: basefont /= Void
	encoding_set: encoding /= Void
	widths_set: widths /= Void
	
end -- class PDF_FONT
