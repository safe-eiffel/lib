indexing

	description: 
	
		"Blocks : rectangular sections filled with text"

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_BLOCK

inherit
	FO_MARGIN_ABLE
		undefine
			is_equal
		redefine
			out
		end

	FO_RENDERABLE
		redefine
			pre_render, is_equal, out,
			render_forth, is_renderable
		end
		
	FO_COLOR_ABLE
		undefine
			is_equal, out
		end

	FO_BORDER_ABLE
		undefine		
			is_equal, out
		end

	FO_SHARED_DEFAULTS
		undefine		
			is_equal, out
		end
		
creation
	make, make_right, make_center, make_default

feature {NONE} -- Initialization

	make_default is
			-- Make with default margins and default inline.
		local
			inline : FO_INLINE
		do
			make (shared_defaults.block_margins)
			create inline.make ("")
			append (inline)
		end
		
	make (new_margins : FO_MARGINS) is
			-- Make with `new_margins' with left justification.
		require
			new_margins: new_margins /= Void
		do
			margins := new_margins
			create background_color.make_rgb (255,255,255)
			create foreground_color.make_rgb (0,0,0)
			create {DS_LINKED_LIST[FO_INLINE]}inlines.make
			create max_font_width.points (0)
			make_borders_none
			create text_leading.points (0)
		ensure
			margins_set: margins = new_margins
			is_left_justified: is_left_justified
			leading_zero: text_leading.is_zero
		end

	make_right (new_margins : FO_MARGINS) is
			-- Make with `new_margins' with right justification.
		require
			new_margins: new_margins /= Void
		do
			make (new_margins)
			justification := justify_right
		ensure
			margins_set: margins = new_margins
			is_right_justified: is_right_justified
			leading_zero: text_leading.is_zero
		end
		
	make_center (new_margins : FO_MARGINS) is
			-- Make with `new_margins' with center justification.
		require
			new_margins: new_margins /= Void
		do
			make (new_margins)
			justification := justify_center
		ensure
			leading_zero: text_leading.is_zero
			margins_set: margins = new_margins
			is_center_justified: is_center_justified
		end
		
feature -- Access

	justification : INTEGER
			-- Justification mode.
	
	last_inline : FO_INLINE is
		do
			if not inlines.is_empty then
				Result := inlines.last
			end
		end

	text_leading : FO_MEASUREMENT
			-- Space between two lines of text.
			-- Zero means 'the height of each individual line'.
		
feature {NONE} -- Access

	lines : DS_LIST [FO_LINE]
			-- Pre rendered lines.
		
feature -- Constants

	justify_left : INTEGER is 0
	justify_right: INTEGER is 1
	justify_center : INTEGER is 2
		
feature -- Measurement

	inner_line_width : FO_MEASUREMENT
			-- Width of pre-rendered lines.
	
	width : FO_MEASUREMENT is
			-- Total width
		require
			inner_line_width_not_void: inner_line_width /= Void
		do
			Result := inner_line_width + margins.left + margins.right
		ensure
			width_not_void: Result /= Void
			width_definition: Result.is_equal (inner_line_width +  margins.left + margins.right)
		end
		
	height : FO_MEASUREMENT is
			-- Height of whole block, including margins.
		do
			create Result.points (0)
			from
				lines.start
			until
				lines.off
			loop
				Result := Result + text_leading.max (lines.item_for_iteration.height)
				lines.forth
			end
			Result := Result + margins.top + margins.bottom
		end
	
	max_font_width : FO_MEASUREMENT	
			-- Maximum font width.
	
feature -- Status report

	is_left_justified : BOOLEAN is
		do
			Result := justification = justify_left
		end

	is_right_justified : BOOLEAN is
		do
			Result := justification = justify_right
		end
		
	is_center_justified : BOOLEAN is
		do
			Result := justification = justify_center
		end
	
	has (an_inline : FO_INLINE) : BOOLEAN is
			-- Has Current `an_inline'?
		require
			an_inline_exists: an_inline /= Void
		do
			Result := inlines.has (an_inline)
		end

	is_word_wrap : BOOLEAN
			-- Must words be wrapped?
			
	is_renderable (region: FO_RECTANGLE) : BOOLEAN is
			-- Is Current renderable in `region'?
		do
			Result := margins.content_region (region).width > max_font_width
		ensure then
			definition: Result = (margins.content_region (region).width > max_font_width)
		end

	is_page_break_before : BOOLEAN

	is_keep_with_next : BOOLEAN
			
feature -- Status setting

	enable_word_wrap is
			-- Enable wrapping of words.
		do
			is_word_wrap := True
		ensure
			is_word_wrap: is_word_wrap
		end
		
	disable_word_wrap is
			-- Disable wrapping of words.
		do
			is_word_wrap := False
		end

	enable_keep_with_next is
			-- Enable wrapping of words.
		do
			is_keep_with_next := True
		ensure
			is_keep_with_next: is_keep_with_next
		end
		
	disable_keep_with_next is
			-- Disable wrapping of words.
		do
			is_keep_with_next := False
		end

	enable_page_break_before is
			-- Start block on new page.
		do
			is_page_break_before := True
		end
		
	center_justify is		
			-- Center text.
		do
			justification := justify_center
		ensure
			is_center_justified: is_center_justified
		end
		
	right_justify is
			-- Justify text to the right. 
		do
			justification := justify_right
		ensure
			is_right_justified: is_right_justified
		end
		
	left_justify is
			-- Justify text to the left.
		do
			justification := justify_left
		ensure
			is_left_justified: is_left_justified
		end
		
feature -- Cursor movement

feature -- Element change

	set_text_leading (new_leading: FO_MEASUREMENT) is
			-- Set `text_leading' to `new_leading'.
		require
			new_leading_not_void: new_leading /= Void
		do
			text_leading := new_leading
		ensure
			text_leading_set: text_leading = new_leading
		end

	append (new_inline : FO_INLINE) is
			-- Append `new_inline'
		require
			new_inline_not_void: new_inline /= Void
		local
			font_b_box_width : FO_MEASUREMENT
			em_size : FO_MEASUREMENT
		do
			create em_size.points (new_inline.font.em_size)
			font_b_box_width := new_inline.font.bounding_box.width -- / em_size * new_inline.font.size
			inlines.put_last (new_inline)
			max_font_width := max_font_width.max (font_b_box_width)
		ensure
			has_inline: has (new_inline)
			last_inline_set: last_inline = new_inline
		end

	append_string (string : STRING) is		
			-- Append `string' in last inline.
		require
			string_not_void: string /= Void
			last_inline_not_void: last_inline /= Void
		do
			inlines.last.append_string (string)
		end
		
	append_character (character : CHARACTER) is
			-- Append `character' in last inline.
		require
			last_inline_not_void: last_inline /= Void
		do
			inlines.last.append_character (character)
		end
		
feature -- Conversion

	out : STRING is
		do
			Create Result.make (0)
			from
				inlines.start
			until
				inlines.off
			loop
				Result.append_string (inlines.item_for_iteration.out)
				Result.append_character ('%N')
				inlines.forth
			end
		end
		
feature -- Constants

	c_new_line : CHARACTER is '%N'

feature {FO_DOCUMENT, FO_RENDERABLE} -- Basic operations

	pre_render (region: FO_RECTANGLE) is
		local
			line : FO_LINE
			current_inline : FO_INLINE
			line_width : FO_MEASUREMENT
			s : STRING
			actual_region : FO_RECTANGLE
		do	
			last_region := region
			actual_region := margins.content_region (region)
			inner_line_width := actual_region.width	
			from	
				create word_cursor.make (inlines)
				word_cursor.start
				create {DS_LINKED_LIST[FO_LINE]}lines.make
			until
				word_cursor.off
			loop
				create line.make_justified (actual_region.width, text_leading, Current, justification)
				from
					create line_width.points (0)
				until
					word_cursor.off or else line_width + word_cursor.item_width > actual_region.width
				loop
					if word_cursor.item_text.item (1) = c_new_line then
						create s.make (1)
						create current_inline.make_inherit (s, inlines.first)
						debug ("fo_show_paragraph_marks")
							show_paragraph_mark (current_inline)
						end	
						line.add_inline (current_inline)
						lines.put_last (line)
						create line.make_justified (actual_region.width, text_leading, Current, justification)
						create line_width.points (0)
					else
						word_cursor.append_item (line)
					end
					line_width := line_width + word_cursor.item_width
					word_cursor.forth
				end
				if word_cursor.item_width > actual_region.width then
					word_cursor.keep_head_not_greater (actual_region.width)
					if word_cursor.item_text.count > 0 and line_width + word_cursor.item_width <= actual_region.width then
						word_cursor.append_item (line)
						line_width := line_width + word_cursor.item_width
						word_cursor.forth
					else
						--| FIXME !!!
					end
				end
				lines.put_last (line)
			end
			precursor (region)
		end

	render_forth (document : FO_DOCUMENT; region : FO_RECTANGLE) is
		local
			line_region : FO_RECTANGLE
			available_region : FO_RECTANGLE
			done : BOOLEAN
			use_top_margins : BOOLEAN
			use_bottom_margins : BOOLEAN
		do
			if last_rendered_region = Void then
				create last_rendered_region.set (region.left, region.top - margins.top,
					region.right, region.top)
				create available_region.set (region.left,region.bottom,
					region.right, region.top - margins.top)
				use_top_margins := True
			else
				create available_region.copy (region)
				last_rendered_region.set (region.left, region.top,
					region.right, region.top)
			end
			if not is_prerendered then
				pre_render (region)
			end
			-- Render one line at a time			
			if not document.current_page.is_text_mode then
				document.current_page.begin_text
			end
			from
				if render_cursor = Void then
					render_cursor := lines.new_cursor
					render_cursor.start
				end
				if not render_cursor.off and available_region.height <= text_leading.max (render_cursor.item.height) then
					done := True
				end
			until
				render_cursor.off or else done
			loop
				create line_region.set (available_region.left + margins.left, available_region.bottom,
					available_region.right - margins.right,	available_region.top)
				if line_region.height >= text_leading.max (render_cursor.item.height) then
					render_cursor.item.render_start (document, line_region)
					if render_cursor.item.is_prerendered then
						last_rendered_region := last_rendered_region.merged (render_cursor.item.last_rendered_region)
					else
						do_nothing
					end
					if available_region.height > render_cursor.item.height then
						available_region := available_region.shrinked_top (text_leading.max (render_cursor.item.height))
					else
						done := True
					end
					render_cursor.forth
				else
					done := True
				end
			end
			if document.current_page.is_text_mode then
				document.current_page.end_text
			end
			if render_cursor.off and last_rendered_region.height + margins.bottom <= region.height then
				is_render_inside := not render_cursor.off
				is_render_off := render_cursor.off
				render_cursor := Void
				last_rendered_region := last_rendered_region.shrinked_bottom (margins.bottom)
				use_bottom_margins := True
			else
				is_render_inside := True
				is_render_off := False
			end
			debug ("fo_show_block_margins")
				show_margins (document, use_top_margins, use_bottom_margins)
			end
			last_region := region
		end
		
	render_start (document : FO_DOCUMENT; region : FO_RECTANGLE) is
			-- Start rendering on `document' within `region'.
		do
			is_prerendered := False
			if region.height > margins.top + margins.bottom then
				pre_render (region)
				is_render_inside := True
				last_rendered_region := Void
				render_forth (document, region)
			else
				last_rendered_region := Void
				is_render_inside := True
				is_render_off := False
				last_region := region
			end
		end

					
feature -- Comparison

	is_equal (other : like Current) : BOOLEAN is
		do
			Result := same_colorable (other)  and same_marginable (other)
		end
		
feature -- Inapplicable

	show_margins (document : FO_DOCUMENT; use_top_margins, use_bottom_margins : BOOLEAN) is
		local
			gy : DOUBLE
			y_bottom : DOUBLE
			gh : DOUBLE
		do
			document.current_page.gsave
			document.current_page.move (0,0)
--			if lines.count > 0 then
--				y_bottom := last_rendered_region.bottom.as_points + (lines.last.bounding_box.bottom).as_points  -- / create {FO_MEASUREMENT}.points (1000) * lines.last.height).as_points ,
--				gy := last_rendered_region.bottom.as_points + (lines.last.bounding_box.bottom).as_points -- / create {FO_MEASUREMENT}.points (1000) * lines.last.height).as_points
--			else
				y_bottom := last_rendered_region.bottom.as_points
				gy := last_rendered_region.bottom.as_points
--			end
			document.current_page.rectangle (
				last_rendered_region.left.as_points, 
				y_bottom, 
				last_rendered_region.width.as_points, 
				last_rendered_region.height.as_points)			
			document.current_page.stroke
			document.current_page.grestore
			document.current_page.gsave
			document.current_page.set_gray_stroke (0.5)
			document.current_page.set_line_dash (<< 1,  3>>, 0)
			document.current_page.move (0,0)
			gh := last_rendered_region.height.as_points
			if use_bottom_margins then
				gy := gy + margins.bottom.as_points
				gh := gh - margins.bottom.as_points
			end
			if use_top_margins then
				gh := gh - margins.top.as_points
			end
			
			document.current_page.rectangle (
				(last_rendered_region.left + margins.left).as_points,
				gy,
				(last_rendered_region.width - (margins.left + margins.right)).as_points, 
				gh)
			document.current_page.stroke
			document.current_page.grestore
		end
		
	show_paragraph_mark (inline : FO_INLINE) is		
		do
				inline.append_character (inlines.first.font.pdf_encoding.code_of_name ("paragraph").to_character)	
				inline.set_foreground_color (create {FO_COLOR}.make_rgb (80,80,80))
		end
		
feature {FO_DOCUMENT} -- Implementation

	inlines : DS_LIST [FO_INLINE]

	render_cursor : DS_LIST_CURSOR[FO_LINE]

feature {NONE} -- Implementation

	word_cursor : FO_INLINES_WORD_CURSOR
			
invariant

	inlines_not_void: inlines /= Void
	text_leading_not_void: text_leading /= Void
	
end

