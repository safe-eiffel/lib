indexing
	description: "Objects that..."

	usage: ""
	quality: ""
	refactoring: ""

	status: "see notice at end of class";
	date: "$Date$";
	revision: "$Revision$";
	author: ""

class TUTORIAL_SHOW_TABLES

inherit

	TUTORIAL_TEST

create
	execute

feature {NONE} -- Initialization

	execute is
			-- Initialize `Current'.
		local
			a_table : FO_TABLE
			back_link : FO_BLOCK
			current_outline : FO_OUTLINE_NODE
		do
			--| 1
--			create writer.make ("tutorial_tables.pdf")
--			create document.make (writer)

			--| 2
--			document.open

--			document.append_block (title)

			append_chapter ("Tables")

			append_section ("Left aligned", "[
Tables can be left aligned.  The whole content is aligned to the left of the render region.
Cell widths are considered as absolutes.
]")
			create current_outline.make_child (chapter_outline, "Left aligned", create {FO_DESTINATION}.make (section_title.target.name))

			put_simple_table (create {FO_ALIGNMENT}.make_left)

			append_section ("Right aligned", "[
Tables can be right aligned.  The whole content is aligned to the right of the render region.
Cell widths are considered as absolutes.
]")
			put_simple_table (create {FO_ALIGNMENT}.make_right)

			append_section ("Justified", "[
Tables can be justified.  The whole content is adjusted to the total width of the render region.
Cell widths are considered as relatives, i.e. they represent proportions. Let T be a 3 columns table with widths (3, 3, 2).  The total proportion is 3 + 3 + 2 = 8.  The actual widths will be (3/8, 3/8, 2/8) of the render region.
]")
			put_simple_table (create {FO_ALIGNMENT}.make_justify)

			append_section ("Centered", "[
Tables can be centered.  The center of the table content is at the center of the render region.
Cell widths are considered as absolutes.
]")
			put_simple_table (create {FO_ALIGNMENT}.make_center)

			document.append_page_break

			create_sample_table (100)
			a_table := last_table
			create_sample_table (12)
			a_table.last_row.put (last_table, 1)
			--| *
			document.append_table (a_table)

			create back_link.make_default
			back_link.append_string ("This is a back link gjq")
			back_link.last_inline.set_destination (create {FO_DESTINATION}.make ("Titel"))
			document.append_block (back_link)
			--| 6
--			document.close
		end

feature -- Access

	last_table : FO_TABLE

	current_color : FO_COLOR

feature -- Basic operations

	put_simple_table (alignment : FO_ALIGNMENT) is
		local
			border : FO_BORDER
			row, column : INTEGER
			cell_margins : FO_MARGINS
			table_margins : FO_MARGINS
			block : FO_BLOCK
		do
			create last_table.make (3, << cm(5), cm (5), cm (2) >>)
			
			last_table.set_align (alignment)
			
			create table_margins.set (mm (5), mm (10), mm (5), mm (5))
			last_table.set_margins (table_margins)
			
			last_table.create_header_row
			last_table.enable_header_row_on_new_page
			
			create border.make ({FO_BORDER}.style_solid, points (1), create {FO_COLOR}.make_rgb (100, 100, 100))
			create cell_margins.set (mm (4), mm(1), mm (2), mm (3))

			create block.make_default
			block.append_string ("Header Column 1")
			block.set_uniform_borders (border)
			block.set_margins (cell_margins)

			last_table.header_row.put (block, 1)

			create block.make_default
			block.append_string ("Header Column 2")
			block.set_uniform_borders (border)
			block.set_margins (cell_margins)

			last_table.header_row.put (block, 2)

			create block.make_default
			block.append_string ("Header Column 3")
			block.set_uniform_borders (border)
			block.set_margins (cell_margins)

			last_table.header_row.put (block, 3)

			from
				row := 1
			until
				row > 3
			loop
				last_table.append_new_row
				from
					column := 1
				until
					column > 3
				loop
					create block.make_default
					block.append_string (row.out + "." + column.out)
					block.set_uniform_borders (border)
					block.set_margins (cell_margins)

					last_table.last_row.put (block, column)

					column := column + 1
				end
				row := row + 1
			end
			document.append_table (last_table)
		end
		
	create_sample_table ( i : INTEGER) is
		local
			border : FO_BORDER
			alignment : FO_ALIGNMENT
			block : FO_BLOCK
			j : INTEGER
		do
			create last_table.make (3, <<cm (12), cm (3), cm (3)>>)
			if current_color = Void then
				create current_color.make_rgb (255, 0, 0)
				create alignment.make_left
			else
				create current_color.make_rgb (127, 127, 127)
				create alignment.make_justify
			end
			last_table.set_align (alignment)
			create border.make ({FO_BORDER}.style_solid, points (1), current_color)

			last_table.create_header_row
			last_table.enable_header_row_on_new_page

			create block.make_default
			block.append_string ("Name")
			block.set_uniform_borders (border)

			last_table.header_row.put (block, 1)

			create block.make_default
			block.append_string ("Phone")
			block.set_uniform_borders (border)

			last_table.header_row.put (block, 2)

			create block.make_default
			block.append_string ("e-mail")
			block.set_uniform_borders (border)

			last_table.header_row.put (block, 3)

			from
				j := 1

			until
				j > i
			loop
				append_row (last_table, j)
				j := j + 1
			end
		end

	append_row (a_table : FO_TABLE; i : INTEGER) is
		local
			a_block : FO_BLOCK
		do
			a_table.append_new_row

			create a_block.make_default
			a_block.append_string ("This is a very long name I suppose it still is ok " + i.out)

			a_table.last_row.put (a_block, 1)

			create a_block.make_default
			a_block.append_string (i.out+"-23456")

			a_table.last_row.put (a_block, 2)

			create a_block.make_default
			a_block.append_string ("e"+i.out+"@mail.com")

			a_table.last_row.put (a_block, 3)
		end
		
end

