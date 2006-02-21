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
	
	FO_SHARED_FONT_FACTORY
	FO_MEASUREMENT_ROUTINES
	
create
	execute

feature {NONE} -- Initialization

	execute is
			-- Initialize `Current'.
		local
			a_table : FO_TABLE
		do
			--| 1
			create writer.make ("tutorial_tables.pdf")
			create document.make (writer)

			--| 2
			document.open
			
			create_sample_table (100)
			a_table := table
			create_sample_table (12)
			a_table.last_row.put (table, 1)
			--| *
			document.append_table (a_table)

			--| 6
			document.close
		end
		
feature {NONE} -- Implementation

	document : FO_DOCUMENT
	
	table : FO_TABLE
	
	create_sample_table ( i : INTEGER) is
		local
			border : FO_BORDER
			j : INTEGER
		do
			create table.make (3, <<cm (12), cm (3), cm (3)>>)
			create border.make ({FO_BORDER}.style_solid, points (1), create {FO_COLOR}.make_rgb (255, 0, 0))
			
			table.create_header_row
			table.enable_header_row_on_new_page
			
			create block.make_default
			block.append_string ("Name")
			block.set_uniform_borders (border)
			
			table.header_row.put (block, 1)
						
			create block.make_default
			block.append_string ("Phone")
			block.set_uniform_borders (border)
			
			table.header_row.put (block, 2)
			
			create block.make_default
			block.append_string ("e-mail")
			block.set_uniform_borders (border)
			
			table.header_row.put (block, 3)
			
			from
				j := 1
				
			until
				j > i
			loop
				append_row (table, j)
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
			a_block.append_string ("Phone "+i.out)
			
			a_table.last_row.put (a_block, 2)
			
			create a_block.make_default
			a_block.append_string ("e-mail "+i.out)
			
			table.last_row.put (a_block, 3)
		end
		
	writer : FO_DOCUMENT_WRITER	
	
	block : FO_BLOCK
	
end

