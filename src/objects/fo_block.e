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
	FO_MARGINABLE
		undefine
			is_equal, out
		end

	FO_RENDERABLE
		undefine
			post_render
		redefine
			pre_render, is_equal, out,
			render_forth, is_renderable
		end

	FO_COLORABLE
		undefine
			is_equal, out
		end

	FO_BORDERABLE
		undefine
			is_equal, out
		end

	FO_SHARED_DEFAULTS
		undefine
			is_equal, out
		end

	KL_IMPORTED_INTEGER_ROUTINES
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
			-- Make with `new_margins' and right justification.
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
			-- Make with `new_margins' and center justification.
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
			-- Last inserted inline.
		do
			if not inlines.is_empty then
				Result := inlines.last
			end
		ensure
			last_inline_not_void_when_not_empty: not is_empty implies Result /= Void
		end

	text_leading : FO_MEASUREMENT
			-- Space between two lines of text.
			-- Zero means 'the height of each individual line'.

feature {NONE} -- Access

	lines : DS_LIST [FO_LINE]
			-- Pre rendered lines.

	render_state : INTEGER

	render_state_before : INTEGER is 0
	render_state_inside : INTEGER is 1
	render_state_after : INTEGER is 2

feature -- Constants

	justify_left : INTEGER is 0
	justify_right: INTEGER is 1
	justify_center : INTEGER is 2

feature -- Measurement

	inner_line_width : FO_MEASUREMENT
			-- Width of pre-rendered lines.

	width : FO_MEASUREMENT is
			-- Total width.
		require
			inner_line_width_not_void: inner_line_width /= Void
		do
			Result := inner_line_width + margins.left + margins.right
		ensure
			width_not_void: Result /= Void
			width_definition: Result.is_equal (inner_line_width +  margins.left + margins.right)
		end

	height : FO_MEASUREMENT
			-- Height.

	max_font_width : FO_MEASUREMENT
			-- Maximum font width in current block.

feature -- Status report

	is_left_justified : BOOLEAN is
			-- Is text left justified ?
		do
			Result := justification = justify_left
		end

	is_right_justified : BOOLEAN is
			-- Is text right justified ?
		do
			Result := justification = justify_right
		end

	is_center_justified : BOOLEAN is
			-- Is text centered ?
		do
			Result := justification = justify_center
		end

	is_empty : BOOLEAN is
			-- Is the block empty?
		do
			Result := inlines.is_empty
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
			one_character_is_at_least_renderable: Result = (margins.content_region (region).width > max_font_width)
		end

	is_page_break_before : BOOLEAN
			-- Must a page break occur before rendering?

	is_keep_with_next : BOOLEAN
			-- Must this block be kept with next block on the same page?

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
			-- Keep on the same page with next renderable.
		do
			is_keep_with_next := True
		ensure
			is_keep_with_next: is_keep_with_next
		end

	disable_keep_with_next is
			-- Disable keep-with-next.
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
			max_font_width_adapted: max_font_width >= old max_font_width
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
			-- Terse printable representation.
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
			-- New line character.

feature {FO_DOCUMENT, FO_RENDERABLE} -- Basic operations

	pre_render (region: FO_RECTANGLE) is
		do
			last_region := region
			compute_available_region (region)
			compute_lines (available_region)
			precursor (region)
			--| adjust height
			if render_state = render_state_before then
				height := height + margins.top
			end
			if word_cursor.off and height + margins.bottom <= region.height  then
				height := height + margins.bottom
			end
		ensure then
			available_region_not_void: available_region /= Void
		end

	available_region : FO_RECTANGLE
			-- Region where real rendering can take place.

	compute_available_region (a_region : FO_RECTANGLE) is
			-- Compute available region based on `a_region'.
		local
			l_left, l_right, l_top, l_bottom : FO_MEASUREMENT
		do
			l_left := a_region.left + margins.left
			l_right := a_region.right - margins.right
			inspect render_state
			when render_state_before then
					l_top := a_region.top - margins.top
					l_bottom := a_region.bottom
			when render_state_inside then
					l_top := a_region.top
					l_bottom := a_region.bottom
			else
				l_top := a_region.top
				l_bottom := a_region.bottom - margins.bottom
			end
			create available_region.set (l_left, l_bottom, l_right, l_top)
		ensure
			available_region_not_void: available_region /= Void
		end

	render_forth (document : FO_DOCUMENT; region : FO_RECTANGLE) is
		local
			line_region : FO_RECTANGLE
			use_top_margins : BOOLEAN
			use_bottom_margins : BOOLEAN
			last_descender : FO_MEASUREMENT
		do
			if last_rendered_region = Void then
				create last_rendered_region.set (region.left, region.top - margins.top,
					region.right, region.top)
				use_top_margins := True
			else
				last_rendered_region.set (region.left, region.top,
					region.right, region.top)
			end
			if not is_prerendered or else not last_region.is_equal (region) then
				pre_render (region)
			end
			-- Render one line at a time
			if not document.current_page.is_text_mode then
				document.current_page.begin_text
			end
			from
					render_cursor := lines.new_cursor
					render_cursor.start
			until
				render_cursor.off -- or else done
			loop
				create line_region.set (available_region.left, available_region.bottom,
					available_region.right,	available_region.top)
					render_cursor.item.render_start (document, line_region)
					if render_cursor.item.last_rendered_region /= Void then
						last_rendered_region := last_rendered_region.merged (render_cursor.item.last_rendered_region)
						available_region := available_region.shrinked_top (text_leading.max (render_cursor.item.last_rendered_region.height))
						last_descender := render_cursor.item.bounding_box.bottom
					else
						create last_descender.points (0)
					end
					render_cursor.forth
			end
			if document.current_page.is_text_mode then
				document.current_page.end_text
			end
--			if render_cursor.off and last_rendered_region.height + margins.bottom <= region.height then
			if word_cursor.off and last_rendered_region.height + margins.bottom <= region.height then
				if render_cursor.off then
					set_render_after
				else
					set_render_inside
				end
				render_cursor := Void
				last_rendered_region := last_rendered_region.shrinked_bottom (margins.bottom)
				use_bottom_margins := True
			else
				set_render_inside
			end
			if is_render_inside then
				if last_descender /= Void then
					available_region := available_region.shrinked_top (- last_descender)
					last_rendered_region := last_rendered_region.shrinked_bottom (- last_descender)
				end
			end
			debug ("fo_show_block_margins")
				show_margins (document, use_top_margins, use_bottom_margins)
			end
			last_region := region
			is_prerendered := False
		end

	render_start (document : FO_DOCUMENT; region : FO_RECTANGLE) is
			-- Start rendering on `document' within `region'.
		do
			is_prerendered := False
			if region.height > margins.top + margins.bottom then
				line := Void
				word_cursor := Void
				set_render_before
				pre_render (region)
				set_render_inside
				last_rendered_region := Void
				render_forth (document, region)
			else
				last_rendered_region := Void
				set_render_inside
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
			y_bottom := last_rendered_region.bottom.as_points
			gy := last_rendered_region.bottom.as_points
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
		local
			grey : FO_COLOR
		do
			inline.append_character (INTEGER_.to_character (inlines.first.font.pdf_encoding.code_of_name ("paragraph")))
			create grey.make_rgb (80,80,80)
			inline.set_foreground_color (grey)
		end

feature {FO_DOCUMENT} -- Implementation

	inlines : DS_LIST [FO_INLINE]

	render_cursor : DS_LIST_CURSOR[FO_LINE]

feature {NONE} -- Implementation

	set_render_before is do render_state := render_state_before ; is_render_off := True; is_render_inside := False end
	set_render_inside is do render_state := render_state_inside ; is_render_off := False; is_render_inside := True end
	set_render_after is do render_state := render_state_after; is_render_off := True; is_render_inside := False end

	word_cursor : FO_INLINES_WORD_CURSOR

	compute_lines (region : FO_RECTANGLE) is
			-- Compute lines for `line_width'.
		local
			line_width : FO_MEASUREMENT
			current_inline : FO_INLINE
			current_height : FO_MEASUREMENT
			s : STRING
			current_width : FO_MEASUREMENT
		do
			line_width := region.width
			inner_line_width := line_width
			from
				if word_cursor = Void then
					create word_cursor.make (inlines)
					word_cursor.start
				end
				create {DS_LINKED_LIST[FO_LINE]}lines.make
				create current_height.points (0)
			until
				word_cursor.off
				or else current_height + text_leading.max (word_cursor.item_height) > region.height
			loop
				create line.make_justified (line_width, text_leading, Current, justification)
				create current_width.points (0)
				from
				until
					word_cursor.off
					or else current_height + text_leading.max (word_cursor.item_height) > region.height
					or else current_width + word_cursor.item_width > line_width
				loop
					if word_cursor.item_text.item (1) = c_new_line then
						create s.make (1)
						create current_inline.make_inherit (s, inlines.first)
						debug ("fo_show_paragraph_marks")
							show_paragraph_mark (current_inline)
						end
						line.add_inline (current_inline)
						lines.put_last (line)
						current_height := current_height + text_leading.max(line.height)
						create line.make_justified (line_width, text_leading, Current, justification)
						create current_width.points (0)
					else
						word_cursor.append_item (line)
					end
					current_width := current_width + word_cursor.item_width
					word_cursor.forth
				end
				if word_cursor.item_width > line_width then
-- Cut...
-- Here hyphenation takes place.
					word_cursor.keep_head_not_greater (line_width)
					if word_cursor.item_text.count > 0 and current_width + word_cursor.item_width <= line_width then
						word_cursor.append_item (line)
						current_width := current_width + word_cursor.item_width
						word_cursor.forth
					else
						--| FIXME !!!
					end
				end
				lines.put_last (line)
				current_height := current_height + text_leading.max(line.height)
			end
			height := current_height
		ensure
			height_not_void: height /= Void
			lines_not_void: lines /= Void
			height_not_greater_region_height: height <= region.height
		end

	line : FO_LINE

	lines_height : FO_MEASUREMENT is
		local
			cursor : DS_LIST_CURSOR[FO_LINE]
		do
			from
				cursor := lines.new_cursor
				cursor.start
				create Result.points (0)
			until
				cursor.off
			loop
				Result := text_leading.max (cursor.item.height) + Result
				cursor.forth
			end
		end

invariant

	inlines_not_void: inlines /= Void
	text_leading_not_void: text_leading /= Void

end

