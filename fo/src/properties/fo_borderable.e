indexing
	description:

		"Objects that have borders."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class

	FO_BORDERABLE

feature {NONE} -- Initialization

	make_borders_none is
		do
			create border_top.make_none
			create border_bottom.make_none
			create border_left.make_none
			create border_right.make_none
			create border_margins.make
		ensure
			uniform_borders: is_borders_uniform
			border_is_none: border_top.is_none
		end

feature -- Access

	border_margins : FO_MARGINS
			-- Distance between the start of an area and the start of the borders.

	border_top : FO_BORDER
			-- Top border.

	border_bottom : FO_BORDER
			-- Bottom border.

	border_left : FO_BORDER
			-- Left border.

	border_right : FO_BORDER
			-- Right border.

feature -- Status report

	is_borders_uniform : BOOLEAN is
			-- Do all borders have the same width/style/color?
		do
			if border_top.is_equal (border_bottom) and border_top.is_equal (border_left) and border_top.is_equal (border_right) then
				Result := True
			end
		end

feature -- Element change

	set_border_margins (some_margins : FO_MARGINS) is
			-- Set `border_margins' to `some_margins'.
		require
			some_margins_not_void: some_margins /= Void
		do
			border_margins := some_margins
		ensure
			border_margins_set: border_margins = some_margins
		end

	set_uniform_borders (a_border : like border_top) is
			-- Set all borders to `a_border'.
		require
			a_border_not_void: a_border /= Void
		do
			set_border_bottom (a_border)
			set_border_left (a_border)
			set_border_right (a_border)
			set_border_top (a_border)
		ensure
			border_bottom_set: border_bottom = a_border
			border_left_set: border_left = a_border
			border_right_set: border_right = a_border
			border_top_set: border_top = a_border
			is_borders_uniform: is_borders_uniform
		end

	set_border_top (a_border : like border_top) is
			-- Set top border to `a_border'.
		require
			a_border_not_void: a_border /= Void
		do
			border_top := a_border
		ensure
			border_top_set: border_top = a_border
		end

	set_border_bottom (a_border : like border_bottom) is
			-- Set bottom border to `a_border'.
		require
			a_border_not_void: a_border /= Void
		do
			border_bottom := a_border
		ensure
			border_bottom_set: border_bottom = a_border
		end

	set_border_left (a_border : like border_left) is
			-- Set left border to `a_border'.
		require
			a_border_not_void: a_border /= Void
		do
			border_left := a_border
		ensure
			border_left_set: border_left = a_border
		end

	set_border_right (a_border : like border_right) is
			-- Set right border to `a_border'.
		require
			a_border_not_void: a_border /= Void
		do
			border_right := a_border
		ensure
			border_right_set: border_right = a_border
		end

feature -- Comparison

	same_borders (other : FO_BORDERABLE) : BOOLEAN is
			-- Has `other' the same borders as `Current'?
		require
			other_not_void: other /= Void
		do
			Result := border_left.is_equal (other.border_left) and
					  border_right.is_equal (other.border_right) and
					  border_top.is_equal (other.border_top) and
					  border_bottom.is_equal (other.border_bottom)
		end

feature {FO_DOCUMENT} -- Basic operations

	post_render (document: FO_DOCUMENT; region: FO_RECTANGLE) is
		do
			render_borders (document, region)
		end

feature {NONE} -- Implementation

	set_line_properties (page : PDF_PAGE; border : FO_BORDER) is
			-- Set line properties (style/color) of `border' into `page'.
		local
			rule : DS_PAIR[ARRAY[INTEGER],INTEGER]
		do
			if border.style = border.style_none then
				page.set_line_solid
			else
				rule := border.style_rule
				page.set_line_dash (rule.first, rule.second)
			end
			if border.color /= Void then
				page.set_rgb_color_stroke (border.color.red/255, border.color.green/255, border.color.blue/255)
			end
			if border.width /= Void then
				page.set_line_width (border.width.as_points)
			end
		end

	render_borders (document : FO_DOCUMENT; current_region : FO_RECTANGLE) is
			-- Render borders in `document' into `current_region'.
		local
			page : PDF_PAGE
			region : FO_RECTANGLE
		do
			if current_region /= Void and then current_region.height.sign = 1 then
				page := document.current_page
				if page.is_text_mode then
					page.end_text
				end
				if border_margins /= Void then
					region := border_margins.content_region (current_region)
				else
					region := current_region
				end
				page.gsave
				if is_borders_uniform and not border_left.is_none then
					--| draw rectangle
					set_line_properties (page, border_left)
					page.move (0, 0)
					page.rectangle (region.left.as_points, region.bottom.as_points, region.width.as_points, region.height.as_points)
					if border_left.style = {FO_BORDER}.style_double then
						page.rectangle (region.left.as_points + border_left.width.as_points + double_border_offset,
							region.bottom.as_points + border_bottom.width.as_points + double_border_offset,
							region.width.as_points - (border_right.width.as_points + double_border_offset) * 2,
							region.height.as_points - (border_top.width.as_points + double_border_offset) * 2)
					end
					page.stroke
				else
					--| draw borders.
					if border_left /= Void and then not border_left.is_none then
						draw_vertical_border (page, border_left, [region.left, region.bottom, region.left, region.top], border_bottom, border_top, +1)
					end
					if border_bottom /= Void and then not border_bottom.is_none then
						draw_horizontal_border (page, border_bottom, [region.left, region.bottom, region.right, region.bottom], border_left, border_right, +1)
					end
					if border_right /= Void and then not border_right.is_none then
						draw_vertical_border (page, border_right, [region.right, region.bottom, region.right, region.top], border_bottom, border_top, -1)
					end
					if border_top /= Void and then not border_top.is_none then
						draw_horizontal_border (page, border_top, [region.left, region.top, region.right, region.top], border_left, border_right, -1)
					end
				end
				page.grestore
			end
		end

	draw_horizontal_border (page : PDF_PAGE; border : FO_BORDER; coordinates : TUPLE[x1, y1, x2, y2 : FO_MEASUREMENT]; left_border, right_border : FO_BORDER; offset_sign : INTEGER) is
		local
			left_offset, right_offset : INTEGER
		do
			set_line_properties (page, border)
			page.move (coordinates.x1.as_points, coordinates.y1.as_points)
			page.lineto (coordinates.x2.as_points, coordinates.y2.as_points)
			page.stroke
			if border.style = {FO_BORDER}.style_double then
				left_offset := offset_for_adjacent_border (left_border)
				right_offset := offset_for_adjacent_border (right_border)
				page.move (coordinates.x1.as_points + left_offset, coordinates.y1.as_points + ((double_border_offset + border.width.as_points) * offset_sign))
				page.lineto (coordinates.x2.as_points - right_offset, coordinates.y2.as_points + ((double_border_offset + border.width.as_points) * offset_sign))
				page.stroke
			end
		end

	draw_vertical_border (page : PDF_PAGE; border : FO_BORDER; coordinates : TUPLE[x1, y1, x2, y2 : FO_MEASUREMENT]; bottom_border, top_border : FO_BORDER; offset_sign : INTEGER) is
		local
			bottom_offset, top_offset : INTEGER
			offset : DOUBLE
		do
			set_line_properties (page, border)
			page.move (coordinates.x1.as_points, coordinates.y1.as_points)
			page.lineto (coordinates.x2.as_points, coordinates.y2.as_points)
			page.stroke
			if border.style = {FO_BORDER}.style_double then
				offset := double_border_offset + border.width.as_points
				bottom_offset := offset_for_adjacent_border (bottom_border)
				top_offset := offset_for_adjacent_border (top_border)
				page.move (coordinates.x1.as_points + (offset * offset_sign), coordinates.y1.as_points + bottom_offset)
				page.lineto ( coordinates.x2.as_points + (offset * offset_sign), coordinates.y2.as_points - top_offset)
				page.stroke
			end
		end

	offset_for_adjacent_border (border : FO_BORDER) : INTEGER is
		do
			if border /= Void and then not border.is_none and then border.style = {FO_BORDER}.style_double then
				Result := double_border_offset + border.width.as_points.truncated_to_integer
			end
		end

-- Adjacent borders:
-- left : top, bottom
-- right : top, bottom
-- top : left, right
-- bottom : left, right

	double_border_offset : INTEGER is 2

invariant

	border_left_not_void: border_left /= Void
	border_right_not_void: border_right /= Void
	border_top_not_void: border_top /= Void
	border_bottom_not_void: border_bottom /= Void

end
