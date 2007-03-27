indexing

	description:

		"[
		EREPORT System's root class
		]"

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	EREPORT

inherit

	KL_SHARED_EXECUTION_ENVIRONMENT
	KL_SHARED_FILE_SYSTEM

	FO_MEASUREMENT_ROUTINES
	FO_SHARED_FONT_FACTORY

creation
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			p : FO_PAGE_SIZE
		do
			create p.make ("a4")

			setup_document
			show_inline_properties
--			show_font_properties
			close_document
			--| Add your code here
--			test_trie
--			test_hyphen
			use_classes
--			test_measurement
			test_multiple_fonts
		end

feature -- Access

	document : FO_DOCUMENT

	writer : FO_DOCUMENT_WRITER

	page_rectangle : FO_RECTANGLE

	helvetica_12 : FO_FONT

feature -- Basic operations

	setup_document is
			-- Create and setup document.
		local
			l_margins : FO_MARGINS
			l_page_size : FO_PAGE_SIZE
		do
			create writer.make ("c:\ereport0.pdf")
			create l_margins.set (cm (2), cm (2), cm (2), cm (2))
			create l_page_size.make_a4
			create document.make_rectangle (l_page_size, writer)
			document.set_margins (l_margins)
			document.open
			font_factory.find_font ("Helvetica", "","", points (12))
			helvetica_12 := font_factory.last_font
		end

	show_inline_properties is
		local
			l_block : FO_BLOCK
			l_inline : FO_INLINE
			l_margins : FO_MARGINS
			l_red : FO_COLOR
			l_yellow : FO_COLOR
		do
			create l_margins.make
			create l_inline.make_with_font ("This is an inline in helvetica 12 points%N", helvetica_12)
			create l_block.make (l_margins)
			l_block.append (l_inline)

			create l_inline.make_with_font ("This is an inline in helvetica 12, red foreground.%N", helvetica_12)
			create l_red.make_rgb (255, 0, 0)
			l_inline.set_foreground_color (l_red)
			l_block.append (l_inline)

			create l_inline.make_with_font ("This is an inline in helvetica 12, red foreground, yellow background.%N", helvetica_12)
			create l_red.make_rgb (255, 0, 0)
			create l_yellow.make_rgb (255, 255, 0)
			l_inline.set_foreground_color (l_red)
			l_inline.set_background_color (l_yellow)
			l_block.append (l_inline)

			create l_inline.make_with_font ("This is an inline in helvetica 12 points, stretch 150%N", helvetica_12)
			l_inline.set_stretch (unit (150))
			l_block.append (l_inline)

			create l_inline.make_with_font ("This is an inline in helvetica 12 points, word spacing 5%N", helvetica_12)
			l_inline.set_word_spacing (unit (5))
			l_block.append (l_inline)

			create l_inline.make_with_font ("This is an inline in helvetica 12 points, character spacing 3%N", helvetica_12)
			l_inline.set_character_spacing (unit (3))
			l_block.append (l_inline)


			document.append_block (l_block)
		end

	close_document is
		do
			document.close
		end

	show_block_properties is
		do

		end

	show_font_properties is
		do

		end


	test_hyphen is
		local
			hy : FO_TEX_HYPHEN_FILE
			hypen : FO_HYPHENATION
		do
			create tries.make
			create hy.make (file_system.nested_pathname (execution_environment.variable_value ("SAFE"), <<"lib","fo","src", "support", "hyphen", "frhyph.tex">>))
			create hypen.make ('-', 2, 2, hy)
			hypen.hyphenate ("appelle")
			hypen.hyphenate ("ANTICONSTITUtionnellement")
			hypen.hyphenate ("Isabelle")
			hypen.hyphenate ("Zarathoustra")
		end

	tries : DS_TRIE[STRING]

	test_trie is
		local
			t : DS_TRIE[STRING]
		do
			create t.make
			t.put ("1", "t")
			t.put ("2", "to")
			t.put ("3", "zozo")
			t.put ("4", "zut")
			t.put ("5", "toit")
			t.put ("6", "tout")
			t.put ("7", "zu")
			print (t)
		end

	test_measurement is
			--
		local
			m : FO_MEASUREMENT
		do
			create m.centimeters (10)
			show_measurement (m, "10", "centimeters")
			create m.millimeters (10)
			show_measurement (m, "10", "millimeters")
			create m.points (72)
			show_measurement (m, "72", "points")
			create m.inches (1/2.54)
			show_measurement (m, (1/2.54).out, "inches")
			create m.points (1)
			show_measurement (m, "1", "points")
		end

	show_measurement (m : FO_MEASUREMENT; value, unit_string : STRING) is
			--
		do
			print (value + " " + unit_string + " = %N")
			print ("  " + m.as_inches.out + "%Tinches%N")
			print ("  " + m.as_centimeters.out + "%Tcentimeters%N")
			print ("  " + m.as_points.out + "%Tpoints%N")
			print ("  " + m.as_millimeters.out + "%Tmillimeters%N%N")
		end
	block : FO_BLOCK

	use_classes is
			--
		local
			font : FO_FONT
			inline : FO_INLINE
			margins : FO_MARGINS
			measurement : FO_MEASUREMENT
			red, yellow, blue2, green, magenta : FO_COLOR
		do
			font_factory.find_font ("Helvetica", "", "", points (12))
			if font_factory.last_font /= Void then
				font := font_factory.last_font
				create measurement.points (12)
				create inline.make_with_font ("This is a content that I know is%
				% completely useless, except for the example I am ", font)
				create margins.make
				margins.set_left (cm (0))
				create block.make (margins)

				block.append (inline)
				font_factory.find_font ("Helvetica", "", "italic", points (12))
				do_nothing
				create inline.make_with_font ("try", font_factory.last_font)
				create red.make_rgb (255, 0, 0)
				create yellow.make_rgb (255,255,0)
				inline.set_foreground_color (red)
				inline.set_background_color (yellow)
				inline.set_stretch (unit (260))
				block.append (inline)

				create inline.make_with_font ("i", font_factory.last_font)
				create green.make_rgb (0, 255, 0)
				inline.set_foreground_color (green)
				block.append (inline)

				create inline.make_with_font ("ng t", font_factory.last_font)
				create magenta.make_rgb (0, 255, 255)
				inline.set_foreground_color (magenta)
				block.append (inline)

				create inline.make_with_font ("o emphasize.", font_factory.last_font)
				create blue2.make_rgb (255, 64, 64)
				inline.set_foreground_color (blue2)
				block.append (inline)
				font_factory.find_font ("Times", "bold", "", points (14))
				do_nothing
				create inline.make_with_font ("%N%NAnd this is the last trial I'm doing before arriving %
				%at Brussels-North. Now it is time for me to continue to work this way because %N%NI%N%N%N think %Nthis is better.", font_factory.last_font)
				block.append (inline)
			end
			measurement := inline.width
			print ("Block is :%N")
			print (block.out)
		end

	test_multiple_fonts is
			--
		local
			a_document : FO_DOCUMENT
			rectangle : FO_RECTANGLE
			a_writer : FO_DOCUMENT_WRITER
			a210, a297, a0 : FO_MEASUREMENT
			margins : FO_MARGINS
			row : FO_ROW
			inline : FO_INLINE
			block2 : FO_BLOCK
			image : FO_IMAGE
			border : FO_BORDER
			red : FO_COLOR
			border_constants : FO_BORDER
			table : FO_TABLE
		do
			create a_writer.make ("c:\ereport.pdf")
			create a210.centimeters (21)
			create a297.centimeters (29.7)
			create a0.points (0)
			create rectangle.set (a0, a0, a210, a297)
			create a_document.make_rectangle (rectangle, a_writer)
			create margins.make
			margins.set_bottom (centimeters (2))
			margins.set_top (centimeters (2))
			margins.set_left (centimeters (2))
			margins.set_right (centimeters (2))
			a_document.set_margins (margins)

			--|
--			page := a_document.last_page
--			a_document.find_font ("Helvetica", a_document.Encoding_winansi)
--			page.set_font (a_document.last_font, 10)
--			page.begin_text
--			page.move_text_origin (page.mediabox.llx, page.mediabox.height-20)
--			page.put_string ("Ceci est une ")
--			a_document.find_font ("Times-Roman", a_document.Encoding_winansi)
--			page.set_font (a_document.last_font, 10)
--			page.put_string ("police")
--			page.set_font (a_document.last_font, 12)
--			page.put_string (" de plus ")
--			page.set_font (a_document.last_font, 16)
--			page.put_string ("grande")
--			page.end_text
			a_document.open
			block.margins.set_top (centimeters (0.5))
			block.margins.set_bottom (centimeters (0.5))
			block.margins.set_right (centimeters (0.5))
			block.margins.set_left (centimeters (0.5))
			a_document.append_block (block)
			block.margins.set_left (centimeters (0.5))
			a_document.append_block (block)
			block.margins.set_left (centimeters (1.5))
			block.margins.set_top (centimeters (1))
			a_document.append_block (block)
			block.margins.set_top (centimeters (0.5))
			a_document.append_block (block)

			create table.make (2, << points (300), points (100)>>)
			table.append_new_row
			row := table.last_row
			row.set_align (create {FO_ALIGNMENT}.make_justify)

			block.margins.set_top (centimeters (0.2))
			block.margins.set_bottom (centimeters (0.2))
			block.margins.set_right (centimeters (0.2))
			block.margins.set_left (centimeters (0.2))
			row.put (block, 1)
			create margins.make
			margins.set_top (centimeters (1))
			margins.set_bottom (centimeters (2))
			margins.set_right (centimeters (0.2))
			margins.set_left (centimeters (0.2))
			create block2.make (margins)
			create inline.make_with_font ("Ceci est un essai que j'espère concluant.  En effet, il est difficile de savoir comment le truc va se comporter.",
				font_factory.last_font)
			block2.append (inline)
			row.put (block2, 2)
			a_document.append_table(table)
			a_document.append_block (block)
			a_document.append_block (block2)
			block.margins.set_top (centimeters (2))
			block.margins.set_bottom (centimeters (1))
			block.margins.set_right (centimeters (1))
			a_document.append_block (block)

			create image.make_from_png ("C:\User\eiffel\safe\safe\lib\ecli\examples\books\data\nvc.png", a_document)
			image.set_width (centimeters (10))
			create red.make_rgb (255, 0, 0)
			create border_constants.make_none
			create border.make (border_constants.style_dot_dash, points (1),
				red)
			image.align.make_center
			image.margins.set_left (centimeters (1))
			image.margins.set_right (centimeters (1))
			image.margins.set_top (centimeters (1))
			image.margins.set_bottom (centimeters (1))
			image.set_uniform_borders (border)
			a_document.append_image (image)
			test_row_single (a_document)
		test_row_multiple (a_document)
			a_document.close

		end

	test_row_single (a_document : FO_DOCUMENT) is
		local
			row : FO_ROW
			b : FO_BLOCK
			image : FO_IMAGE
			i : FO_INLINE

			margins : FO_MARGINS
			table : FO_TABLE
		do
			create table.make (2, << cm (5), cm (7)>>)
			table.append_new_row
			row := table.last_row
			row.set_align (create {FO_ALIGNMENT}.make_justify)

			create margins.set (mm(2), mm(2), mm(2), mm(2)) --| no margins.

			create b.make (margins)

			font_factory.find_font ("Helvetica", "", "italic", points (12))
			create i.make_with_font ("", font_factory.last_font)
			b.append (i)
			b.append_string ("[
This is a long text about NonViolent communication.
I like it very much as it is for me the best way to
handle relationships peacefully.  I am aware that this
is a somewhat challenging path.  And I also know that is
is a very effective way of dealing with oneself and with
other people.
]")

			create image.make_from_png (nvc_image_file, a_document)
			image.set_width (cm (5))

			row.put (image, 1)
			row.put (b, 2)

			row.put (new_nvc_row (a_document), 1)
			a_document.append_table (table)
		end

	test_row_multiple (a_document : FO_DOCUMENT) is
		local
			row : FO_ROW
			b : FO_BLOCK
			i : FO_INLINE

			table : FO_TABLE
			margins : FO_MARGINS
		do
			
			create table.make (2, << cm (5), cm (7)>>)
			table.append_new_row
			row := table.last_row
			row.set_align (create {FO_ALIGNMENT}.make_justify)

			create margins.set (mm(0), mm(0), mm(0), mm(0)) --| no margins.

			create b.make (margins)

			font_factory.find_font ("Helvetica", "", "italic", points (12))
			create i.make_with_font ("", font_factory.last_font)
			b.append (i)
			b.append_string ("[
This is a long text about NonViolent communication.
I like it very much as it is for me the best way to
handle relationships peacefully.  I am aware that this
is a somewhat challenging path.  And I also know that is
is a very effective way of dealing with oneself and with
other people.
]"
)

			row.put (b, 2)
			row.put (new_nvc_row (a_document), 1)

			a_document.append_table (table)
		end

	new_nvc_row (a_document : FO_DOCUMENT) : FO_TABLE is
		local
			row : FO_ROW
			b : FO_BLOCK
			image : FO_IMAGE
			i : FO_INLINE
			a_table : FO_TABLE
			margins : FO_MARGINS
		do
			create a_table.make (2, << cm (5), cm (7)>>)
			a_table.append_new_row
			row := a_table.last_row
			row.set_align (create {FO_ALIGNMENT}.make_justify)

			create margins.set (mm(0), mm(0), mm(0), mm(0)) --| no margins.

			create b.make (margins)

			font_factory.find_font ("Helvetica", "", "italic", points (12))
			create i.make_with_font ("", font_factory.last_font)
			b.append (i)
			b.append_string ("[
This is a long text about NonViolent communication.
I like it very much as it is for me the best way to
handle relationships peacefully.  I am aware that this
is a somewhat challenging path.  And I also know that this
is a very effective way of dealing with oneself and with
other people.
]")

			create image.make_from_png (nvc_image_file, a_document)
			image.set_width (cm (2))

			row.put (image, 1)
			row.put (b, 2)
			Result := a_table
		end

	nvc_image_file : STRING is "C:\User\eiffel\safe\safe\lib\ecli\examples\books\data\nvc.png"

end -- class EREPORT
