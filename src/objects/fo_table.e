indexing	
	
	description: 
	
		"Objects that contain horizontally consecutive renderable items."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class FO_TABLE

inherit
	
	FO_RENDERABLE
		redefine
			render_forth, pre_render, is_renderable
		end
		
--	FO_BORDER_ABLE
--		redefine
--			render_forth, render_borders
--		end
		
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
		do
			column_count := desired_columns
			widths := desired_widths
			create rows.make
		ensure
			column_count_set: column_count = desired_columns
			widths_set: widths = desired_widths
		end
		
feature -- Access

	header_row : FO_ROW
		
	last_row : FO_ROW
	
	widths : ARRAY[FO_MEASUREMENT]
	
feature -- Measurement

	column_count : INTEGER
			-- Number of columns.
			
	row_count : INTEGER is
			-- Current number of rows.
		do
			Result := rows.count
		end
	
	height : FO_MEASUREMENT is	
		do
			
		end
		
feature -- Comparison

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
	
	is_page_break_before : BOOLEAN
	
	is_keep_with_next : BOOLEAN
		
feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	render_forth (document: FO_DOCUMENT; region: FO_RECTANGLE) is
		do
			
		end
	
	pre_render (region: FO_RECTANGLE) is	
		do
			
		end
		
	render_start (document: FO_DOCUMENT; region: FO_RECTANGLE) is
		do
			
		end
		
feature -- Obsolete

feature -- Inapplicable

feature -- Constants

feature {NONE} -- Implementation

	rows : DS_LINKED_LIST[FO_ROW]

invariant	
	
	rows_not_void: rows /= Void
	column_count_positive: column_count > 0
	
end
