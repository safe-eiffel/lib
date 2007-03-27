indexing

	description:

		"Text portions of same characteristics : font, color."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_INLINE

inherit

	FO_TEXTABLE
		redefine
			out
		end

	FO_SHARED_FONT_FACTORY
		undefine
			is_equal, out
		end

create
	make, make_with_font, make_inherit

feature {NONE} -- Initialization

	make (new_content : STRING) is
			-- Make with default font.
		require
			new_content_not_void: new_content /= Void
		do
			make_with_font (new_content, font_factory.default_font)
		end

	make_with_font (new_content : STRING; new_font : FO_FONT) is
			--
		require
			new_content_not_void: new_content /= Void
		do
			text := new_content
			font := new_font
			create background_color.make_rgb (255, 255, 255)
			create foreground_color.make_rgb (0, 0, 0)
			create character_spacing.points (0)
			create word_spacing.points (0)
			create stretch.points (100)
		ensure
			text_set: text = new_content
		end

	make_inherit (new_content : STRING; renderable : FO_TEXTABLE) is
			-- make with `new_content', inheriting graphic attributes from `renderable'.
		require
			new_content_exists: new_content /= Void
			renderable_not_void: renderable /= Void
		do
			text := new_content
			font := renderable.font
			foreground_color := renderable.foreground_color
			background_color := renderable.background_color
			character_spacing := renderable.character_spacing
			word_spacing := renderable.word_spacing
			stretch := renderable.stretch
		ensure
			same_font: font = renderable.font
			same_foreground_color: foreground_color = renderable.foreground_color
			same_background_color: background_color = renderable.background_color
		end

feature -- Access

	text : STRING

	item (index : INTEGER) : CHARACTER is
		require
			index_positive: index >= 1
			index_not_greater_text_count: index <= count
		do
			Result := text.item (index)
		ensure
			definition: Result = text.item (index)
		end

	substring (i_begin, i_end : INTEGER) : FO_INLINE is
			-- Inline with text substring [i_begin..i_end].
		require
			i_begin_positive: i_begin >= 1
			i_end_positive: i_end >= 1
			i_end_not_less_i_begin: i_end >= i_begin
			i_end_not_greater_text_count: i_end <= text.count
		do
			create Result.make_inherit (text.substring (i_begin, i_end), Current)
		ensure
			substring_not_void: Result /= Void
			same_rendering: True
			text_substring: Result.text.is_equal (text.substring (i_begin, i_end))
		end

feature -- Measurement

	width : FO_MEASUREMENT is
			-- Width of Current relative to `font'.
		do
			Result := font.string_width (text, character_spacing, word_spacing, stretch)
		end

	height : FO_MEASUREMENT is
		require else
			font_not_void: font /= Void
		do
			Result := font.size
		ensure then
			definition: Result.is_equal (font.size)
		end

	count : INTEGER is
		do
			Result := text.count
		end

	character_width (c : CHARACTER) : FO_MEASUREMENT is
		do
			Result := font.character_width (c, character_spacing, word_spacing, stretch)
		ensure
			character_width_not_void: Result /= Void
			character_width_not_negative: Result.sign >= 0
		end

	string_width (s : STRING) : FO_MEASUREMENT is
		require
			s_not_void: s /= Void
		do
			Result := font.string_width (s, character_spacing, word_spacing, stretch)
		ensure
			string_width_not_void: Result /= Void
			string_width_not_negative: Result.sign >= 0
		end

feature -- Status report

	same_renderable (other : like Current) : BOOLEAN is
		do
			Result := is_equal (other)
		ensure
			same_font: Result implies font.is_equal (other.font)
			same_foreground: Result implies  foreground_color.is_equal (other.foreground_color)
			same_background: Result implies  background_color.is_equal (other.background_color)
		end

	is_page_break_before : BOOLEAN is do end
	is_keep_with_next : BOOLEAN is do  end


feature -- Element change

	set_text (new_text: STRING) is
		require
			new_text_exists: new_text /= Void
		do
			text := clone (new_text)
		ensure
			text_assigned: text.is_equal (new_text)
		end

	append (other : like Current) is
		require
			other_not_void: other /= Void
			same_renderable: same_renderable (other)
		do
			text.append_string (other.text)
		end

	append_string (s : STRING) is
			-- Append `s' to `text'.
		require
			s_not_void: s /= Void
		do
			text.append_string (s)
		ensure
			text_appended: text.substring (text.count - s.count+1, text.count).is_equal (s)
		end

	append_integer (i : INTEGER) is
			-- Append `i' to `text'.
		do
			text.append_integer (i)
		end

	append_character (c : CHARACTER) is
			-- Append `c' to `text'.
		do
			text.append_character (c)
		end

feature -- Conversion

	out : STRING is
		do
			create Result.make_from_string (text)
		end

feature {FO_DOCUMENT, FO_RENDERABLE} -- Basic operations

	render_start (document : FO_DOCUMENT; region : FO_RECTANGLE) is
		local
			pdf : PDF_DOCUMENT
			page : PDF_PAGE
			x_baseline, y_baseline : FO_MEASUREMENT
			fontbbox : FO_RECTANGLE
		do
			pre_render (region)
			pdf := document.pdf_document
			page := document.current_page
			create x_baseline.points (page.text_x)
			create y_baseline.points (page.text_y)
			fontbbox := font.bounding_box
			create last_rendered_region.set (x_baseline,
				y_baseline + fontbbox.bottom,
				x_baseline + width,
				y_baseline + font.cap_height)

			pdf.find_font (font.name, font.encoding)
			if pdf.last_font /= Void then
				page.set_font (pdf.last_font, font.size.as_points)
			end
			--| background color?
			if background_color /= Void then
				if background_color.red < 255 or background_color.green < 255 or background_color.blue < 255 then
					if page.is_text_mode then
						page.end_text
					end
					page.gsave
					page.set_rgb_color (background_color.red /255, background_color.green/255, background_color.blue /255)
					page.rectangle (last_rendered_region.left.as_points, last_rendered_region.bottom.as_points, last_rendered_region.width.as_points, last_rendered_region.height.as_points)
					page.fill
					page.grestore
					page.begin_text
					page.move_text_origin (x_baseline.as_points, y_baseline.as_points)
				end
			end
			--| foreground color
			page.set_rgb_color (foreground_color.red/255,foreground_color.green/255,foreground_color.blue/255)

			page.set_horizontal_scaling (stretch.as_points)
			page.set_character_spacing (character_spacing.as_points)
			page.set_word_spacing (word_spacing.as_points)

			page.put_string (text)
			set_render_after
		end

invariant
	word_spacing_not_void: word_spacing /= Void
	character_spacing_not_void: character_spacing /= Void

end
