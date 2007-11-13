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
		do
			test_marginable
			test_borderable
			test_colorable
			test_leading
		end

	test_leading is
		local
			block : FO_BLOCK
		do
			append_section ("Text Leading", "Text leading is the distance between two lines of text.")
			create block.make_default
			block.set_text_leading (pt (18))
			block.append_string ("This is a block with a 18 pt text leading.  The quick brown fox jumps over the lazy fox.  The quick brown fox jumps over the lazy fox. We should see if it is possible to define the text leading with a block.  This should be a block expanding on at least two lines.")
			document.append_block (block)
		end


	test_inlines is
		local
			inline : FO_INLINE
			font : FO_FONT
		do
			append_section ("Inlines", "Inlines are sequence of characters that share the same attributes : font, color,...")
			--| fontable
			font_factory.find_font ("Helvetica", font_factory.weigth_normal, font_factory.style_italic, pt (12))
			font := font_factory.last_font
			create inline.make_with_font (" This text is in Helvetica Italic, 12 points. ", font)
			section_text.append (inline)
			--| colorable
			create inline.make_with_font (" this text is in the same font but 'red' with a 'yellow' background. I set a very long long long long phrase so that I can see if the backgrounds overlap", font)
			inline.set_background_color (create {FO_COLOR}.make_rgb (250, 250, 163))
			inline.set_foreground_color (create {FO_COLOR}.make_rgb (255, 0, 0))
			section_text.append (inline)
			--| targetable
			create inline.make_with_font (" This is a link to the section title.", font_factory.default_font)
			inline.set_destination (create {FO_DESTINATION}.make ("Margins"))
			inline.destination.set_border_dot_dashed
			section_text.append (inline)
			-- Note: après rendering, poser une destination ou un target ne sert à rien => précondition ou autre protocole.
	--		document.append_block (create {FO_BLOCK}.make_default)
		end

	test_marginable is
		local
			marginable : FO_BLOCK
			margins : FO_MARGINS
		do
			--| marginable
			append_section ("Margins", "Blocks are rectangular area that contain text. Blocks can %
				%have margins, i.e. space between the %"block bounding box%" and the %"text bounding box%". %
				%For learning purpose, the block bounding box is shown as a continuous line and the text bounding %
				%box is shown as a dotted line.")
			margin_title := section_title
			create marginable.make_default
			marginable.set_is_debugging (True)
			create margins.set (mm(5), mm(10), mm (15), mm (5))
			marginable.set_margins (margins)
			marginable.append_string ("This is a block with 5mm left margin, 10mm bottom margin, 15mm right margins and 5 mm top margin.")
			margin_title.set_target (create {FO_TARGET}.make ("Margins"))
			document.append_block (marginable)
		end

	margin_title : FO_BLOCK

	test_borderable is
		local
			borderable : FO_BLOCK
			border : FO_BORDER
			margins, border_margins : FO_MARGINS
		do
			--| borderable
			append_section ("Borders", "Blocks can have borders.  Borders can be set on any side of the block : %
				%left, right, top or bottom.%N%
				% A border has several attributes : %N%
				% - style : solid, dotted, dashed or dot-dashed%N%
				% - colour : any RGB%N%
				% - width : any measurement%N%
				%Borders are drawn with respect to `border_margins' which is the distance between the block bounding box and the borders box.%N%N")

			-- Border styles
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

			-- Uniform borders
			create borderable.make_default
			create margins.set (mm(10), mm(10), mm(10), mm(10))
			borderable.set_margins (margins)
			create margins.set (mm(5), mm(5), mm (5), mm(5))
			borderable.set_border_margins (margins)
			create border.make ({FO_BORDER}.style_solid, pt(0.5), color_red)
			borderable.set_uniform_borders (border)
			borderable.append_string ("This is a block with uniform borders, with 10mm uniform, i.e. The text bounding box is 10mm away from the block bounding box.%N%
% The red border is 5 mm away from the block bounding box. The dotted lines show the text bounding box. The continuous line is the block bounding box.")
			borderable.set_is_debugging (true)
			document.append_block (borderable)

			-- Double borders
			create borderable.make_default
			create border.make ({FO_BORDER}.style_double, mm (0.01), color_blue)
			borderable.set_uniform_borders (border)
			create margins.set (mm (5), mm(5), mm(5), mm(5))
			borderable.set_margins (margins)
			create border_margins.set (mm (2.5), mm (2.5), mm (2.5), mm (2.5))
			borderable.set_border_margins (border_margins)
			borderable.append_string ("This is a block with blue `double' border of 0.01 mm, and margins or 5mm on every side")
			document.append_block (borderable)

			-- Mixed borders
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
		end

	test_colorable is
		local
			colorable : FO_BLOCK
			border : FO_BORDER
			margins : FO_MARGINS
		do
			--| colorable
			append_section ("Colorable", "Blocks are `colorable', i.e. they can have a background color. %
			%The next block has a light rose background color and some borders.")

			create colorable.make_default
			create border.make ({FO_BORDER}.style_solid, pt (0.5), color_red)
			colorable.set_border_left (border)
			create border.make ({FO_BORDER}.style_dotted, pt (1), color_blue)
			colorable.set_border_right (border)
			create border.make ({FO_BORDER}.style_dashed, pt (1.5), color_green)
			colorable.set_border_bottom (border)
			create border.make ({FO_BORDER}.style_dot_dash, pt (2), color_black)
			colorable.set_border_top (border)
			create margins.set (cm(1), cm(1), cm(1),cm(1))
			colorable.set_margins (margins)
			create margins.set (mm (5), mm (5), mm (5), mm (5))
			colorable.set_border_margins (margins)
			colorable.append_string ("This is a block with%N%
				% - a left red, solid, 0.5 pt border%N%
				% - a right blue, dotted, 1 pt border%N%
				% - a bottom green, dashed, 1.5 pt border%N%
				% - a top black, dot-dashed, 2 pt border%N%
				%Border margins are 5mm while block margins are 10mm.")
			colorable.set_background_color (create {FO_COLOR}.make_rgb (255, 200, 200))
			colorable.set_margins (create {FO_MARGINS}.set (mm(10), mm(10), mm(10), mm(10)))
			document.append_block (colorable)
		end


	test_very_long_block is
		local
			i : INTEGER
			vlb, other : FO_BLOCK
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
			create other.make_default
			other.append_string ("This Block should appear on a new page")
			other.enable_page_break_before
			document.append_block (other)
			document.append_block (vlb)
		end

end
