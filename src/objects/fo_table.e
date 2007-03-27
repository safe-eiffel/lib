indexing

	description:

		"Objects that contain a vertical sequence of horizontally consecutive renderable items."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class FO_TABLE

inherit

	FO_SHARED_DEFAULTS
		undefine
			is_equal
		end

	FO_MARGINABLE
		undefine
			is_equal
		end

	FO_RENDERABLE
		redefine
			render_forth, pre_render, is_renderable
		end

	FO_ALIGNABLE

	KL_IMPORTED_ARRAY_ROUTINES

create

	make

feature {NONE} -- Initialization

	make (desired_columns : INTEGER; desired_widths : ARRAY[FO_MEASUREMENT]) is
			-- Make a table of `desired_columns', with `desired_widths'.
		require
			desired_columns_positive: desired_columns > 0
			desired_widths_not_void: desired_widths /= Void
			desired_widths_count_consistent: desired_widths.count = desired_columns
			all_widths_set: not any_array_.has (desired_widths, Void)
		do
			column_count := desired_columns
			widths := desired_widths
			create rows.make
			create align.make_left
			set_margins (shared_defaults.table_margins)
		ensure
			column_count_set: column_count = desired_columns
			widths_set: widths = desired_widths
		end

feature -- Access

	header_row : FO_ROW

	last_row : FO_ROW
			-- Last row created by factory commands `create_header_row' and `append_new_row'.

	widths : ARRAY[FO_MEASUREMENT]

feature -- Measurement

	column_count : INTEGER
			-- Number of columns.

	row_count : INTEGER is
			-- Current number of rows.
		do
			Result := rows.count
		end

	height : FO_MEASUREMENT
		-- require: is_prerendered.

	width : FO_MEASUREMENT is
		local
			i : INTEGER
		do
			from
				create Result.points (0)
				i := widths.lower
			until
				i > widths.upper
			loop
				Result := Result + widths.item (i)
				i := i + 1
			end
		ensure
			width_not_void: Result /= Void
		end

	available_region : FO_RECTANGLE

feature -- Status report

	is_renderable (region : FO_RECTANGLE) : BOOLEAN is
			-- Is Current renderable in `region'?
		do
			if header_row /= Void then
				Result := header_row.is_renderable (region)
			else
				if rows.last /= Void then
					Result := rows.last.is_renderable (region)
				end
			end

		end

	is_repeat_header_on_new_page : BOOLEAN

	is_page_break_before : BOOLEAN

	is_keep_with_next : BOOLEAN

	has (a_row : FO_ROW) : BOOLEAN is
			-- Has Current `a_row' ?
		do
			Result := rows.has (a_row)
		end

feature -- Status setting

	enable_header_row_on_new_page is
			-- Repeat the header row on each page.
		do
			is_repeat_header_on_new_page := True
		ensure
			definition: is_repeat_header_on_new_page
		end

feature -- Element change

	create_header_row is
			-- Create `header_row'.
		do
			create_row
			header_row := last_row
		ensure
			new_last_row: last_row /= Void and then last_row /= old last_row
			header_row_set: header_row = last_row
		end

	append_new_row is
			-- Append new row to table content.
		do
			create_row
			rows.put_last (last_row)
		ensure
			new_last_row: last_row /= Void and then last_row /= old last_row
			last_row_appended: has (last_row)
		end

feature -- Basic operations

	pre_render (region: FO_RECTANGLE) is
		local
			c : DS_LIST_CURSOR[FO_ROW]
		do
			is_prerendered := False
			if header_row /= Void then
				header_row.pre_render (region)
				height := header_row.height
			else
				create height.points (0)
			end
			from
				c := rows.new_cursor
				c.start
			until
				c.off
			loop
				c.item.pre_render (region)
				height := height + c.item.height
				c.forth
			end
			is_prerendered := True
			last_region := region
		end

	render_start (document: FO_DOCUMENT; region: FO_RECTANGLE) is
		local
			done : BOOLEAN
			post_render_region : FO_RECTANGLE
			must_render_rows : BOOLEAN
		do
			set_render_before
			set_rendering_none
			compute_available_region (region)
			create last_rendered_region.set (
				region.left, region.top, region.right, region.top)
			render_cursor := Void
			if not (is_prerendered and then last_region.is_equal (region)) then
				pre_render (available_region)
			end
			must_render_rows := True
			if header_row /= Void then
				-- Start rendering header_row
				set_render_inside
				set_rendering_header
				header_row.render_start (document, available_region)
				if header_row.is_render_after then
					create post_render_region.set (available_region.left, header_row.last_rendered_region.bottom, available_region.right, header_row.last_rendered_region.top)
					header_row.post_render (document, post_render_region)
					last_rendered_region := last_rendered_region.merged (header_row.last_rendered_region)
					available_region := available_region.shrinked_top (header_row.last_rendered_region.height)
				else
					must_render_rows := False
				end
			end
			if must_render_rows then
				--| render rows until one of them cannot be rendered.
				from
					set_rendering_rows
					render_cursor := rows.new_cursor
					render_cursor.start
				until
					render_cursor.off or else done
				loop
					render_cursor.item.render_start (document, available_region)
					if render_cursor.item.last_rendered_region /= Void then
						create post_render_region.set (available_region.left, render_cursor.item.last_rendered_region.bottom, available_region.right, render_cursor.item.last_rendered_region.top)
						render_cursor.item.post_render (document, post_render_region)
						last_rendered_region := last_rendered_region.merged (render_cursor.item.last_rendered_region)
						available_region := available_region.shrinked_top (render_cursor.item.last_rendered_region.height)
					else
						do_nothing
					end
					if not render_cursor.item.is_render_after then
						done := True
					else
						render_cursor.forth
					end
				end
				if render_cursor.off then
					set_render_after
				end
			end
		end

	render_forth (document: FO_DOCUMENT; region: FO_RECTANGLE) is
		local
			done : BOOLEAN
			post_render_region : FO_RECTANGLE
		do
			last_region := region
			compute_available_region (region)
			create last_rendered_region.set (
				region.left, region.top, region.right, region.top)

			if is_repeat_header_on_new_page or rendering_state = state_rendering_header then
				if rendering_state = state_rendering_header then
					header_row.render_forth (document, available_region)
				else
					set_rendering_header
					header_row.render_start (document, available_region)
				end
				create post_render_region.set (available_region.left, header_row.last_rendered_region.bottom, available_region.right, header_row.last_rendered_region.top)
				header_row.post_render (document, post_render_region)
				last_rendered_region := last_rendered_region.merged (header_row.last_rendered_region)
				available_region := available_region.shrinked_top (header_row.last_rendered_region.height)
				if header_row.is_render_off then
					set_rendering_rows
				end
			end
			if rendering_state = state_rendering_rows then
				from
					if render_cursor = Void or else render_cursor.off then
						render_cursor := rows.new_cursor
						render_cursor.start
					end
				until
					render_cursor.off or else done
				loop
					if render_cursor.item.is_render_inside then
						render_cursor.item.render_forth (document, available_region)
					else
						render_cursor.item.render_start (document, available_region)
					end
					create post_render_region.set (available_region.left, render_cursor.item.last_rendered_region.bottom, available_region.right, render_cursor.item.last_rendered_region.top)
					render_cursor.item.post_render (document, render_cursor.item.last_rendered_region)
					last_rendered_region := last_rendered_region.merged (render_cursor.item.last_rendered_region)
					available_region := available_region.shrinked_top (render_cursor.item.last_rendered_region.height)
					if not render_cursor.item.is_render_after then
						done := True
					else
						render_cursor.forth
					end
				end
				if render_cursor.off then
					set_render_after
				end
			end
		end

feature -- Constants

	state_rendering_none : INTEGER is 0
	state_rendering_header : INTEGER is 1
	state_rendering_rows : INTEGER is 2

	rendering_state : INTEGER

feature -- Status setting

	set_rendering_none is do rendering_state := state_rendering_none end
	set_rendering_header is do rendering_state := state_rendering_header end
	set_rendering_rows is do rendering_state := state_rendering_rows end

feature {NONE} -- Implementation

--	post_render (renderable : FO_RENDERABLE; document : FO_DOCUMENT) is
--		local
--			borderable : FO_BORDER_ABLE
--		do
--			borderable ?= renderable
--			if borderable /= Void then
--				borderable.render_borders (document, borderable.last_rendered_region)
--			end
--		end

	rows : DS_LINKED_LIST[FO_ROW]

	render_cursor : DS_LIST_CURSOR[FO_ROW]

	create_row is
			-- Create a new row.
		do
			create last_row.make_widths (column_count, widths)
			last_row.set_align (align)
		ensure
			last_row_not_void: last_row /= Void
		end

--	create_available_region (region : FO_RECTANGLE) is
--		do
--			create available_region.set (region.left + margins.left, region.bottom + margins.bottom, region.right - margins.right, region.top - margins.top)
--		ensure
--			available_region_not_void: available_region /= Void
--		end

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

invariant

	rows_not_void: rows /= Void
	column_count_positive: column_count > 0

end
