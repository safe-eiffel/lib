indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TUTORIAL_TEST_BLOCK

inherit
	TUTORIAL_TEST

create
	execute

feature -- Basic operations

	execute is
		do
			create_document ("test_block.pdf")
			document.open
			-- test simple block : one block + a very long text
			test_simple_block
			-- test inlines : one block + many types of inlines
			test_inlines
			test_very_long_block
			document.close
		end



	test_simple_block is
		local
			borderable, colorable, marginable : FO_BLOCK
			border : FO_BORDER
			margins, border_margins : FO_MARGINS
		do
			--| marginable
			create marginable.make_default
			marginable.append_string ("This is a block with no margins")
			document.append_block (marginable)
			create marginable.make_default
			create margins.set (mm(5), mm(10), mm (15), mm (5))
			marginable.set_margins (margins)
			marginable.append_string ("This is a block with 5mm left margin, 10mm bottom margin, 15mm right margins and 5 mm top margin.")
			document.append_block (marginable)
			--| borderable
			create borderable.make_default
			create border.make ({FO_BORDER}.style_solid, mm (1), color_red)
			borderable.set_uniform_borders (border)

			borderable.append_string ("This is a block with red solid border of 1 mm")
			document.append_block (borderable)

			create borderable.make_default
			create border.make ({FO_BORDER}.style_dashed, mm (0.01), color_blue)
			borderable.set_uniform_borders (border)
			create margins.set (mm (5), mm(5), mm(5), mm(5))
			borderable.set_margins (margins)
			create border_margins.set (mm (2.5), mm (2.5), mm (2.5), mm (2.5))
			borderable.set_border_margins (border_margins)
			borderable.append_string ("This is a block with blue dashed border of 0.01 mm, and margins or 5mm on every side")
			document.append_block (borderable)
			--| colorable
		end

	test_inlines is
		do
			--| colorable
			--| fontable
		end

	test_very_long_block is
		local
			i : INTEGER
			vlb : FO_BLOCK
		do
			create vlb.make_default
			from
				i := 1
			until
				i > 100
			loop
				vlb.append_string ("This is line " + i.out + " of the block%N")
				i := i + 1
			end
			document.append_block (vlb)
		end

end
