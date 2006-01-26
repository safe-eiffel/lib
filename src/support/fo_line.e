indexing
	description: "Blocks whose components reside on the same horizontal line."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	FO_LINE

inherit
	FO_RENDERABLE
		undefine
			is_equal, out
		redefine
			pre_render
		end
		
	FO_MARGIN_ABLE
		redefine
			out, is_equal
		end
	
create {FO_BLOCK} 
	make, make_justified
	
feature {NONE} -- Initialization

	make (new_maximum_width : FO_MEASUREMENT; renderable : FO_RENDERABLE; marginable : FO_MARGIN_ABLE) is
		require
			new_maximum_width_exists: new_maximum_width /= Void
			new_maximum_width_positive: new_maximum_width.sign = 1
			renderable_not_void: renderable /= Void
			marginable_not_void: marginable /= Void
		do
			maximum_width := new_maximum_width
			create width.points (0)
			create {DS_LINKED_LIST[FO_INLINE]}inlines.make
			set_margins (marginable.margins)
			create height.points (0)
		ensure
			maximum_width_set: maximum_width = new_maximum_width
			height_zero: height.is_equal (create {FO_MEASUREMENT}.points(0))
		end

	make_justified (new_maximum_width : FO_MEASUREMENT; renderable : FO_RENDERABLE; marginable : FO_MARGIN_ABLE; a_justification : INTEGER) is		
		require
			new_maximum_width_exists: new_maximum_width /= Void
			new_maximum_width_positive: new_maximum_width.sign = 1
			renderable_not_void: renderable /= Void
			marginable_not_void: marginable /= Void
		do
			justification := a_justification
			maximum_width := new_maximum_width
			create width.points (0)
			create {DS_LINKED_LIST[FO_INLINE]}inlines.make
			set_margins (marginable.margins)
			create height.points (0)
		ensure
			justification_set: justification = a_justification
			maximum_width_set: maximum_width = new_maximum_width
			height_zero: height.is_equal (create {FO_MEASUREMENT}.points(0))
		end
		
		
feature -- Access


	justification : INTEGER
	
	justify_left : INTEGER is 0
	justify_right: INTEGER is 1
	justify_center : INTEGER is 2
	
	last_descender : FO_MEASUREMENT
	
feature -- Measurement

	width : FO_MEASUREMENT
	
	bounding_box : FO_RECTANGLE is	
		local
			c : DS_LIST_CURSOR[FO_INLINE]
		do
			--| find the greatest bounding box of all fonts.
			from	
				c := inlines.new_cursor
				c.start
			until
				c.off
			loop
				if Result = Void then
					Result := c.item.font.bounding_box
				else
					Result := Result.merged (c.item.font.bounding_box)
				end
				c.forth
			end
		end
		
	height : FO_MEASUREMENT
	
	maximum_width : FO_MEASUREMENT

	text : STRING is
		local
			cursor : DS_LIST_CURSOR[FO_INLINE]
		do
			create Result.make (0)
			from
				cursor := inlines.new_cursor
				cursor.start
			until
				cursor.off
			loop
				Result.append_string (cursor.item.text)
				cursor.forth
			end
		end
		
feature -- Measurement

--	fitting_string (inline : FO_INLINE) : STRING is
--		require
--			inline_exists: inline /= Void
--		local
--			l_width : FO_MEASUREMENT
--			char_width : FO_MEASUREMENT
--			l_string_width : FO_MEASUREMENT
--			l_string : STRING
--			index : INTEGER
--			done : BOOLEAN
--			c : CHARACTER
--		do
--			l_width := width
--			create l_string_width.points (0)
--			create Result.make (inline.text.count)
--			from
--				index := 1
--			until
--				index > inline.text.count or else l_string_width + l_width > maximum_width
--			loop
--				Result.append_character (inline.text.item (index))
--				l_string_width := inline.font.string_width (Result)
--				index := index + 1
--			end
--			Result.keep_head (index - 1)
--			from
--				index := 1
--				done := False
--			until
--				done
--			loop
--				if index > inline.text.count then
--					done := True
--				else
--					c := inline.text.item (index)
--					char_width := inline.font.character_width (c)
--					if l_width + l_string_width + char_width > maximum_width then
--						done := True
--					else
--						Result.append_character (c)
--						l_string_width := l_string_width + char_width
--						index := index + 1
--					end
--				end
--			end
--		ensure
--			definition: Result /= Void and then inline.font.string_width (Result) + width <= maximum_width 
--		end
		
feature -- Status report

	has (inline : FO_INLINE) : BOOLEAN is
		require
			inline_exists: inline /= Void
		do
			Result := inlines.has (inline)
		end

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

	is_page_break_before : BOOLEAN is do  end		
	is_keep_with_next : BOOLEAN is do  end	
	
feature -- Status setting

feature -- Cursor movement

feature -- Element change

	add_inline (inline : FO_INLINE) is
		require
			inline_exists: inline /= Void
			inline_fitting: width + inline.width <= maximum_width
		do
			if not inlines.is_empty and inline.same_renderable (inlines.last) then
					inlines.last.append (inline)
			else
					inlines.put_last (inline)
			end
			width := width + inline.width
			if height = Void or else height < inline.height then
				height := inline.height
			end
		ensure
			width_adapted: width.is_equal ((old width) + inline.width)
			heigh_adapted: height.is_equal ((old height).max (inline.height))
		end

	merge_last (list : DS_LIST[FO_INLINE]) is		
		require
			list_not_void: list /= Void
		local
			c : DS_LIST_CURSOR[FO_INLINE]
		do
			from
				c := list.new_cursor
				c.start
			until
				c.off
			loop
				add_inline (c.item)
				c.forth
			end
		end
		
feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

	out : STRING is
		do
			create Result.make (0)
			from
				inlines.start
			until
				inlines.off
			loop
				Result.append_string (inlines.item_for_iteration.out)
				inlines.forth
			end
		end
		
feature -- Comparison

	is_equal (other : like Current) : BOOLEAN is
		do
			Result := precursor {FO_MARGIN_ABLE} (other) and precursor {FO_RENDERABLE} (other) and
				inlines.is_equal (other.inlines)
		end
		
feature -- Inapplicable

	pre_render (region: FO_RECTANGLE) is
		local
			cursor : DS_LIST_CURSOR[FO_INLINE]
		do
			from
				cursor := inlines.new_cursor
				cursor.start
			until
				cursor.off
			loop
				cursor.item.pre_render (region)
				cursor.forth
			end
			precursor (region)
		end
		
	render_start (document : FO_DOCUMENT; region : FO_RECTANGLE) is
		local
			line_height : FO_MEASUREMENT
			cursor : DS_LIST_CURSOR[FO_INLINE]
			current_page : PDF_PAGE
		do
			pre_render (region)
			current_page := document.current_page
			line_height := height
			if (current_page.text_leading - line_height.as_points).abs > 0.1 then
				current_page.set_text_leading (line_height.as_points)
			end
			set_text_origin_justified (current_page, last_region)
			from
				cursor := inlines.new_cursor
				cursor.start
			until
				cursor.off
			loop
				cursor.item.render_start (document, last_region)
				cursor.forth
			end
			create last_rendered_region.set (
					region.left,
					region.top - line_height,
					region.right,
					region.top)
			--| establish postcondition
			last_descender := bounding_box.bottom
			is_render_off := True
			is_render_inside := False
		end

feature {FO_LINE, FO_DOCUMENT} -- Access

	inlines : DS_LIST [FO_INLINE]

	set_text_origin_justified (page : PDF_PAGE; region : FO_RECTANGLE) is
		local
			x, y : FO_MEASUREMENT
		do
			y := region.top - bounding_box.top

			inspect justification
			when Justify_right then
				x := region.right - width
			when Justify_center then
				x := region.left + (region.width - width) / create {FO_MEASUREMENT}.points (2)
			else
				x := region.left
			end
			page.set_text_origin (x.as_points, y.as_points)
		end
	
end -- class FO_LINE
