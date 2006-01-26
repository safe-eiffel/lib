indexing
	description: "Text portions of same characteristics : font, color."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	FO_INLINE

inherit

	FO_TEXTABLE
		redefine
			out
		end
		
create
	make_with_font, make_inherit

feature {NONE} -- Initialization

	make_with_font (new_content : STRING; new_font : FO_FONT) is
			-- 
		require
			new_content_not_void: new_content /= Void
		do
			text := new_content
			font := new_font
			create background_color.make_rgb (255, 255, 255)
			create foreground_color.make_rgb (0, 0, 0)
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
		
	
--	paragraphs : DS_LIST[STRING]

	splitted (a_width : FO_MEASUREMENT) : DS_LIST[FO_INLINE] is
		require
			a_width_not_void: a_width /= Void
			a_width_positive: a_width.sign = 1
		local
			index, first, last : INTEGER
			current_width : FO_MEASUREMENT
			inline, remaining : FO_INLINE
			done : BOOLEAN
		do
--			from
				create {DS_LINKED_LIST[FO_INLINE]}Result.make
				index := 1
--			until
--				index > text.count
--			loop
				from
					create current_width.points (0.0)
					done := False
					first := index
				until
					index > text.count or else done
				loop
					current_width := current_width + font.character_width (text.item (index))
					if current_width <= a_width then
						index := index + 1
					else
						last := index - 1
						done := True
						if last > first then
							create inline.make_inherit (text.substring (first, last), Current)
							Result.put_last (inline)
						end
					end
				end
				if inline /= Void and then index <= text.count then
					create remaining.make_inherit (text.substring (index, text.count), Current)
					Result.put_last (remaining)
				end
--			end
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
			Result := font.string_width (text)
		end
	
	height : FO_MEASUREMENT is
		do
			Result := font.size
		end

	count : INTEGER is	
		do
			Result := text.count
		end
		
	character_width (c : CHARACTER) : FO_MEASUREMENT is	
		do
			Result := font.character_width (c)
		ensure
			character_width_not_void: Result /= Void
			character_width_not_negative: Result.sign >= 0
		end
		
	string_width (s : STRING) : FO_MEASUREMENT is
		require
			s_not_void: s /= Void
		do
			Result := font.string_width (s)
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
	
feature -- Status setting

feature -- Cursor movement

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
		
feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

	out : STRING is
		do
			create Result.make_from_string (text)
		end
		
feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

--	pre_render (region : FO_RECTANGLE) is
--		local
--			split : ST_SPLITTER
--			separators : STRING
--		do
--			create split.make
--			create separators.make (1)
--			separators.append_character (c_new_line)
--			split.set_separators (separators)
--			paragraphs := split.split_greedy (text)
--			precursor (region)
--		ensure then
--			paragraphs_set: paragraphs /= Void
--			paragraphs_count: paragraphs.count = text.occurrences (c_new_line) + 1
--		end
		
	render_start (document : FO_DOCUMENT; region : FO_RECTANGLE) is
		local
			pdf : PDF_DOCUMENT
			page : PDF_PAGE
		do
			pre_render (region)
			pdf := document.pdf_document
			page := document.current_page
			
			pdf.find_font (font.name, font.encoding)
			if pdf.last_font /= Void then
				page.set_font (pdf.last_font, font.size.as_points)
			end
			--| background color?
			page.set_rgb_color (foreground_color.red/255,foreground_color.green/255,foreground_color.blue/255)
			page.put_string (text)
			last_rendered_region := region
			is_render_off := True
			is_render_inside := False
		end

end -- class FO_INLINE
