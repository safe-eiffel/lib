indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TUTORIAL_TEST_LABELS

inherit
	TUTORIAL_TEST

	FO_SHARED_DEFAULTS

create
	execute

feature -- Basic operations

	execute is
		local
			table : FO_TABLE
			block0, block1, block2 : FO_BLOCK
		do
			create_document ("test_labels.pdf")
			document.set_margins (document_margins)
			document.open
			create table.make (2, << mm (99.1 + 2.5), mm (99.1) >>)
			table.set_align (create {FO_ALIGNMENT}.make_center)

			create block0.make_default
			block0.append_string ("[





 ]")
			block0.set_margins (cell_margins)

			create block1.make_default
			block1.append_string ("[
Paul G. Crismer
Avenue Albert Ier, 20

4053 EMBOURG






]")
			block1.set_margins (cell_margins)
			block1.set_uniform_borders (cell_border)
			
			create block2.make_default
			block2.append_string ("[
Ti`Doc
Isabelle Thiran-Marionex
Rue de Lonzée 251

5030 Lonzée


]")
			block2.set_margins (cell_margins)
			block2.set_uniform_borders (cell_border)
			
--			table.append_new_row
--			table.last_row.set_fixed_height (mm(38.1))
--			table.last_row.put (block0, 1)
--			table.last_row.put (block0, 2)

--			table.append_new_row
--			table.last_row.set_fixed_height (mm(38.1))
--			table.last_row.put (block0, 1)
--			table.last_row.put (block0, 2)

			table.append_new_row
			table.last_row.set_fixed_height (mm (38.1))
			table.last_row.put (block1, 1)
			table.last_row.put (block2, 2)

			table.append_new_row
			table.last_row.set_fixed_height (mm (38.1))
			table.last_row.put (block1, 1)
			create block2.make_default
			block2.append_string ("[
Dominique Gilkinet
rue Gubin, 11
 
5150 Floreffe

]")
			block2.set_margins (cell_margins)
			block2.set_uniform_borders (cell_border)
			table.last_row.put (block2, 2)
			
			document.append_table (table)
			document.close
		end

feature -- Access

	document_margins : FO_MARGINS is
		once
			create Result.set (mm(4.65), mm(15.15), mm (4.65), mm (15.15))
		end

	cell_margins : FO_MARGINS is
		once
			create Result.set (mm(5), mm (5), mm (5), cm (1))
		end

	cell_border : FO_BORDER is
		once
			create Result.make ({FO_BORDER}.style_dotted, points (1), create {FO_COLOR}.make_rgb (200,200,200))
		end

feature -- Measurement

feature -- Status report

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

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
