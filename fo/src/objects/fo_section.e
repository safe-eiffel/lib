indexing
	description:

		"Objects that describe the layout of pages : header/footer, page size and orientation."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class FO_SECTION

inherit

	KL_IMPORTED_ARRAY_ROUTINES

create

	make

feature {NONE} -- Initialization

	make (new_name : STRING; new_page_rectangle : FO_RECTANGLE; new_margins : FO_MARGINS) is
			-- create with `new_name', `new_page_rectangle' and `new_margins'.
		require
			new_name_not_void: new_name /= Void
			new_name_not_empty: not new_name.is_empty
			new_page_rectangle_not_void: new_page_rectangle /= Void
			new_margins_not_void: new_margins /= Void
		do
			name := new_name
			page_rectangle := new_page_rectangle
			margins := new_margins
			column_widths := << margins.content_region (page_rectangle).width >>
			create column_spaces.make (1,0)
			compute_regions
		ensure
			name_set: name = new_name
			page_rectangle_set: page_rectangle = new_page_rectangle
			margins_set: margins = new_margins
			is_orientation_portrait: is_orientation_portrait
			column_count_one: column_count = 1
		end

feature -- Access

	name : STRING
			-- Name.

	page_rectangle : FO_RECTANGLE
			-- Page rectangle.

	margins : FO_MARGINS
			-- Section margins.

	header : FO_HEADER_FOOTER
			-- Header.

	footer : FO_HEADER_FOOTER
			-- Footer.

	column_widths : ARRAY[FO_MEASUREMENT]
			-- Widths of columns.

	column_spaces : ARRAY[FO_MEASUREMENT]
			-- Spaces between columns.

	region (index : INTEGER) : FO_RECTANGLE is
			-- Region of `index'-th column.
		require
			index_within_limits: index >= 1 and index <= column_count
		do
			Result := column_regions.item (index)
		ensure
			region_not_void: Result /= Void
		end

feature -- Measurement

	column_count : INTEGER is
			-- Count of defined columns.
		do
			Result := column_widths.upper
		ensure
			result_stricly_positive: Result > 0
			definition: Result = column_widths.upper
		end

	sum_of_measurement (a_table : ARRAY[FO_MEASUREMENT]) : FO_MEASUREMENT is
			-- Sum of measurement in `a_table'.
		require
			a_table_not_void: a_table /= Void
			no_void_in_table: any_array_.has (a_table, Void)
		local
			index : INTEGER
		do
			from
				index := 2
				Result := a_table.item (1)
			until
				index > column_count
			loop
				Result := Result + a_table.item (index)
				index := index + 1
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	is_orientation_portrait : BOOLEAN is
			-- Is the page orientation Portrait?
		do
			Result := not is_orientation_landscape
		end

	is_orientation_landscape : BOOLEAN
			-- Is the page orientation Landscape?

feature -- Status setting

	set_orientation_landscape is
			-- set `is_orientation_landscape'.
		do
			is_orientation_landscape := True
		end

	set_orientation_portrait is
			-- set `is_orientation_portrait'.
		do
			is_orientation_landscape := False
		end

feature -- Element change.

	set_header (a_header : FO_HEADER_FOOTER) is
			-- Set `header' to `a_header'.
		require
			a_header_not_void: a_header /= Void
		do
			header := a_header
		ensure
			header_set: header = a_header
		end

	set_footer (a_footer : FO_HEADER_FOOTER) is
			-- Set `footer' to `a_footer'.
		require
			a_footer_not_void: a_footer /= Void
		do
			footer := a_footer
		ensure
			footer_set: footer = a_footer
		end

	set_columns (widths, spaces : ARRAY[FO_MEASUREMENT]) is
			-- Set `column_widths' and `column_spaces' to `widths' and `spaces'.
		require
			widths_not_void: widths /= Void
			spaces_not_void: spaces /= Void
			lower_is_one: widths.lower = 1 and spaces.lower = 1
			count_difference_one: widths.upper - spaces.upper = 1
			width_consistency: sum_of_measurement (widths) + sum_of_measurement (spaces) <= page_rectangle.width
		do
			column_widths := widths
			column_spaces := spaces
			compute_regions
		ensure
			column_widths_set: column_widths = widths
			column_spaces_set: column_spaces = spaces
			column_regions_not_void: column_regions /= Void
		end

feature {NONE} -- Implementation

	column_regions : ARRAY[FO_RECTANGLE]

	compute_regions is
			-- Compute regions.
		local
			index : INTEGER
			available_region : FO_RECTANGLE
			current_region : FO_RECTANGLE
			left : FO_MEASUREMENT
			right : FO_MEASUREMENT
		do
			available_region := margins.content_region (page_rectangle)
			from
				index := 2
				create column_regions.make (1, column_widths.upper)
				create current_region.set (available_region.left, available_region.bottom,
								available_region.left + column_widths.item (1), available_region.top)
				column_regions.put (current_region, 1)
			until
				index > column_count
			loop
				left := current_region.right + column_spaces.item (index - 1)
				right := left + column_widths.item (index)
				create current_region.set (left,
								available_region.bottom,
								right,
								available_region.top)
				column_regions.put (current_region, index)
				index := index + 1
			end
		end

invariant

	portrait_xor_landscape: is_orientation_portrait xor is_orientation_landscape
	name_not_void: name /= Void
	name_not_empty: not name.is_empty
	page_rectangle_not_void: page_rectangle /= Void
	margins_not_void: margins /= Void
	column_widths_not_void: column_widths /= Void
	column_spaces_not_void: column_spaces /= Void
	columns_lower_one: column_widths.lower = 1 and column_spaces.lower = 1
	column_count_less_column_spaces_count: column_widths.upper - column_spaces.upper = 1
	column_regions_not_void: column_regions /= Void
end

