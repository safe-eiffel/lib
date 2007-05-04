indexing
	description: "Objects that test block functionalities."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TUTORIAL_TEST_BLOCK

inherit
	TUTORIAL_TEST

	FO_SHARED_FONT_FACTORY

	FO_INTERNAL

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
			append_section ("Margins", "Blocks are rectangular area that contain text. Blocks can %
				%have margins, i.e. space between the %"block bounding box%" and the %"text bounding box%". %
				%For learning purpose, the block bounding box is shown as a continuous line and the text bounding %
				%box is shown as a dotted line.")

			create marginable.make_default
			marginable.set_is_debugging (True)
			create margins.set (mm(5), mm(10), mm (15), mm (5))
			marginable.set_margins (margins)
			marginable.append_string ("This is a block with 5mm left margin, 10mm bottom margin, 15mm right margins and 5 mm top margin.")
			document.append_block (marginable)
			--| borderable
			append_section ("Borders", "Blocks can have borders.  Borders can be set on any side of the block : %
				%left, right, top or bottom.%N%
				% A border has several attributes : %N%
				% - style : solid, dotted, dashed or dot-dashed%N%
				% - colour : any RGB%N%
				% - width : any measurement%N%
				%Borders are drawn with respect to `border_margins' which is the distance between the block bounding box and the borders box.%N%N")

			create borderable.make_default
			create border.make ({FO_BORDER}.style_solid, pt (0.5), color_red)
			borderable.set_border_left (border)
			create border.make ({FO_BORDER}.style_dotted, pt (1), color_blue)
			borderable.set_border_right (border)
			create border.make ({FO_BORDER}.style_dashed, pt (1.5), color_green)
			borderable.set_border_bottom (border)
			create border.make ({FO_BORDER}.style_dot_dash, pt (2), color_black)
			borderable.set_border_top (border)
			create margins.set (cm(1), cm(1), cm(1),cm(1))
			borderable.set_margins (margins)
			create margins.set (mm (5), mm (5), mm (5), mm (5))
			borderable.set_border_margins (margins)
			borderable.append_string ("This is a block with%N%
				% - a left red, solid, 0.5 pt border%N%
				% - a right blue, dotted, 1 pt border%N%
				% - a bottom green, dashed, 1.5 pt border%N%
				% - a top black, dot-dashed, 2 pt border%N%
				%Border margins are 5mm while block margins are 10mm.")
			document.append_block (borderable)

			create borderable.make_default
			create margins.set (mm(10), mm(10), mm(10), mm(10))
			borderable.set_margins (margins)
			create margins.set (mm(5), mm(5), mm (5), mm(5))
			borderable.set_border_margins (margins)
			create border.make ({FO_BORDER}.style_solid, pt(0.5), color_red)
			borderable.set_uniform_borders (border)
			borderable.append_string ("This is a block with 10mm uniform margins, i.e. The text bounding box is 10mm away from the block bounding box.%N%
% The red border is 5 mm away from the block bounding box. The dotted lines show the text bounding box. The continuous line is the block bounding box.")
			borderable.set_is_debugging (true)
			document.append_block (borderable)

			create borderable.make_default
			create border.make ({FO_BORDER}.style_double, mm (0.01), color_blue)
			borderable.set_uniform_borders (border)
			create margins.set (mm (5), mm(5), mm(5), mm(5))
			borderable.set_margins (margins)
			create border_margins.set (mm (2.5), mm (2.5), mm (2.5), mm (2.5))
			borderable.set_border_margins (border_margins)
			borderable.append_string ("This is a block with blue `double' border of 0.01 mm, and margins or 5mm on every side")
			document.append_block (borderable)


			create borderable.make_default
			create border.make ({FO_BORDER}.style_double, pt(0.5), color_blue)
			borderable.set_border_left (border)
			create border.make ({FO_BORDER}.style_solid, pt(0.5), color_green)
			borderable.set_border_top (border)
			create border.make ({FO_BORDER}.style_dashed, pt(1.5), color_red)
			borderable.set_border_bottom (border)
			create margins.set (mm (5), mm(5), mm(5), mm(5))
			borderable.set_margins (margins)
			create border_margins.set (mm (2.5), mm (2.5), mm (2.5), mm (2.5))
			borderable.set_border_margins (border_margins)
			borderable.append_string ("Border styles can be mixed.  There is no border at the right side.%NThis can be rather unusual...")
			document.append_block (borderable)

			--| colorable
			append_section ("Colorable", "Blocks are `colorable', i.e. they can have a background color. %
			%The next block has a light rose background color and some borders.")

			create borderable.make_default
			create border.make ({FO_BORDER}.style_solid, pt (0.5), color_red)
			borderable.set_border_left (border)
			create border.make ({FO_BORDER}.style_dotted, pt (1), color_blue)
			borderable.set_border_right (border)
			create border.make ({FO_BORDER}.style_dashed, pt (1.5), color_green)
			borderable.set_border_bottom (border)
			create border.make ({FO_BORDER}.style_dot_dash, pt (2), color_black)
			borderable.set_border_top (border)
			create margins.set (cm(1), cm(1), cm(1),cm(1))
			borderable.set_margins (margins)
			create margins.set (mm (5), mm (5), mm (5), mm (5))
			borderable.set_border_margins (margins)
			borderable.append_string ("This is a block with%N%
				% - a left red, solid, 0.5 pt border%N%
				% - a right blue, dotted, 1 pt border%N%
				% - a bottom green, dashed, 1.5 pt border%N%
				% - a top black, dot-dashed, 2 pt border%N%
				%Border margins are 5mm while block margins are 10mm.")
			borderable.set_background_color (create {FO_COLOR}.make_rgb (255, 200, 200))
			borderable.set_margins (create {FO_MARGINS}.set (mm(10), mm(10), mm(10), mm(10)))
			document.append_block (borderable)
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
