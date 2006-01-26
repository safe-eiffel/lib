indexing
	description	: "System's root class"
	note		: "Initial version automatically generated"

class
	EREPORT

inherit	
	
	KL_SHARED_EXECUTION_ENVIRONMENT
	KL_SHARED_FILE_SYSTEM
	
creation
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			--| Add your code here
			test_trie
			test_hyphen
			use_classes
			test_measurement
			test_multiple_fonts
		end

feature -- Basic operations

	test_hyphen is
		local
			hy : FO_TEX_HYPHEN_FILE
		do
			create tries.make
			create hy.make (file_system.nested_pathname (execution_environment.variable_value ("SAFE"), <<"lib","fo","src", "support", "hyphen", "frhyph.tex">>))
			from
				hy.open_read
			until
				hy.end_of_input			
			loop
				hy.read_pattern
				if not hy.end_of_input then
					tries.put (clone (hy.last_hyph), clone (hy.last_pattern))
				end
			end
			tries.search ("astro")
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

	show_measurement (m : FO_MEASUREMENT; value, unit : STRING) is
			-- 
		do
			print (value + " " + unit + " = %N")
			print ("  " + m.as_inches.out + "%Tinches%N")
			print ("  " + m.as_centimeters.out + "%Tcentimeters%N")
			print ("  " + m.as_points.out + "%Tpoints%N")
			print ("  " + m.as_millimeters.out + "%Tmillimeters%N%N")
		end
	block : FO_BLOCK

	use_classes is
			-- 
		local
			alignable : FO_ALIGN_ABLE
			alignment : FO_ALIGNMENT
			color : FO_COLOR
			colorable : FO_COLOR_ABLE
			fontable : FO_FONT_ABLE
			font : FO_FONT
			inline : FO_INLINE
			marginable : FO_MARGIN_ABLE
			margins : FO_MARGINS
			measurement : FO_MEASUREMENT
		do
			create font_factory.make
			font_factory.find_font ("Helvetica", "", "", font_factory.encoding_winansi)
			if font_factory.last_font /= Void then
				font := font_factory.last_font
				create measurement.points (12)
				font.set_size (measurement)
				create inline.make_with_font ("This is a content that I know is%
				% completely useless, except for the example I am ", font)
				create margins.make
				margins.set_left (create {FO_MEASUREMENT}.centimeters (0))
				create block.make (margins)

				block.append (inline)
				font_factory.find_font ("Helvetica", "", "italic", font_factory.encoding_winansi)
				font_factory.last_font.set_size (create {FO_MEASUREMENT}.points (12))
				do_nothing
				create inline.make_with_font ("try", font_factory.last_font)
				inline.set_foreground_color (create {FO_COLOR}.make_rgb (255, 0, 0))
				block.append (inline)
				create inline.make_with_font ("i", font_factory.last_font)
				inline.set_foreground_color (create {FO_COLOR}.make_rgb (0, 255, 0))
				block.append (inline)
				create inline.make_with_font ("ng t", font_factory.last_font)
				inline.set_foreground_color (create {FO_COLOR}.make_rgb (0, 255, 255))
				block.append (inline)
				create inline.make_with_font ("o emphasize.", font_factory.last_font)
				inline.set_foreground_color (create {FO_COLOR}.make_rgb (255, 64, 64))
				block.append (inline)
				font_factory.find_font ("Times", "bold", "", font_factory.encoding_winansi)
				font_factory.last_font.set_size (create {FO_MEASUREMENT}.points (14))
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
			document : FO_DOCUMENT
			rectangle : FO_RECTANGLE
			writer : FO_DOCUMENT_WRITER
			a210, a297, a0 : FO_MEASUREMENT
			margins : FO_MARGINS
			row : FO_ROW
			inline : FO_INLINE
			block2 : FO_BLOCK
		do
			create writer.make ("c:\ereport.pdf")
			create a210.centimeters (21)
			create a297.centimeters (29.7)
			create a0.points (0)
			create rectangle.set (a0, a0, a210, a297)
			create document.make (rectangle, writer)
			create margins.make
			margins.set_bottom (create {FO_MEASUREMENT}.centimeters (2))
			margins.set_top (create {FO_MEASUREMENT}.centimeters (2))
			margins.set_left (create {FO_MEASUREMENT}.centimeters (2))
			margins.set_right (create {FO_MEASUREMENT}.centimeters (2))
			document.set_margins (margins)
		
			--|
--			page := document.last_page
--			document.find_font ("Helvetica", document.Encoding_winansi)
--			page.set_font (document.last_font, 10)
--			page.begin_text
--			page.move_text_origin (page.mediabox.llx, page.mediabox.height-20)
--			page.put_string ("Ceci est une ")
--			document.find_font ("Times-Roman", document.Encoding_winansi)
--			page.set_font (document.last_font, 10)
--			page.put_string ("police")
--			page.set_font (document.last_font, 12)
--			page.put_string (" de plus ")
--			page.set_font (document.last_font, 16)
--			page.put_string ("grande")
--			page.end_text
			document.open
			block.margins.set_top (create {FO_MEASUREMENT}.centimeters (0.5))
			block.margins.set_bottom (create {FO_MEASUREMENT}.centimeters (0.5))
			block.margins.set_right (create {FO_MEASUREMENT}.centimeters (0.5))
			block.margins.set_left (create {FO_MEASUREMENT}.centimeters (0.5))
			document.append_block (block)
			block.margins.set_left (create {FO_MEASUREMENT}.centimeters (0.5))
			document.append_block (block)
			block.margins.set_left (create {FO_MEASUREMENT}.centimeters (1.5))
			block.margins.set_top (create {FO_MEASUREMENT}.centimeters (1))
			document.append_block (block)
			block.margins.set_top (create {FO_MEASUREMENT}.centimeters (0.5))
			document.append_block (block)
			create row.make_widths (2, << create {FO_MEASUREMENT}.points (300), create {FO_MEASUREMENT}.points (100)>>)
			block.margins.set_top (create {FO_MEASUREMENT}.centimeters (0.2))
			block.margins.set_bottom (create {FO_MEASUREMENT}.centimeters (0.2))
			block.margins.set_right (create {FO_MEASUREMENT}.centimeters (0.2))
			block.margins.set_left (create {FO_MEASUREMENT}.centimeters (0.2))
			row.blocks.put (block, 1)
			create margins.make
			margins.set_top (create {FO_MEASUREMENT}.centimeters (1))
			margins.set_bottom (create {FO_MEASUREMENT}.centimeters (2))
			margins.set_right (create {FO_MEASUREMENT}.centimeters (0.2))
			margins.set_left (create {FO_MEASUREMENT}.centimeters (0.2))
			create block2.make (margins)
			create inline.make_with_font ("Ceci est un essai que j'espère concluant.  En effet, il est difficile de savoir comment le truc va se comporter.",
				font_factory.last_font)
			block2.append (inline)
			row.blocks.put (block2, 2)
			document.append_row (row)
			document.append_block (block)
			document.append_block (block2)	
			block.margins.set_top (create {FO_MEASUREMENT}.centimeters (2))
			block.margins.set_bottom (create {FO_MEASUREMENT}.centimeters (1))
			block.margins.set_right (create {FO_MEASUREMENT}.centimeters (1))
			document.append_block (block)
			document.close

		end

	font_factory : FO_FONT_FACTORY
		
end -- class EREPORT
