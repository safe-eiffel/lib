indexing

	description: "PDF Document objects.  They are a factory for every composing object."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."
	
class
	PDF_DOCUMENT

inherit
	PDF_SERIALIZABLE
		undefine
			indirect_reference
		redefine
			put_pdf
		end

	PDF_OBJECT
		rename 
			make as make_objet
		export 
			{NONE} all 
		undefine
			put_pdf
		end
		
creation
	make
	
feature {NONE} -- Initialization
	
	make is
			-- creates a document
		do
			-- create non PDF-objects
			!!xref.make
			!!fonts_table.make (10)
			!!encodings_table.make (2)
			!DS_LINKED_LIST[PDF_PAGE]!page_list.make
			default_mediabox := Mediabox_a4
			-- use factory methods for PDF-objects
			create_catalog
			catalog := last_catalog
			create_pages
			catalog.set_pages (last_pages)
			add_page
		ensure
			default_mediabox = Mediabox_a4
			last_page /= Void
		end
		
feature {NONE} -- Access

	catalog : PDF_CATALOG
			-- PDF mandatory

feature -- Access

	page_layout : PDF_NAME
			-- A name object specifying the page layout to be used when the
			-- document is opened

	default_mediabox : PDF_RECTANGLE
			-- Default media box for each page
			-- A page mediabox can be set individually

	last_page : PDF_PAGE
			-- last created page; set by `add_page'
	
	last_font : PDF_FONT
			-- last found font; set by `find_font'

	last_encoding : PDF_CHARACTER_ENCODING
			-- last character encoding; set by `find_encoding'

feature {NONE} -- Measurement

	count : INTEGER is
			-- number of PDF objects 
		do
			Result := xref.count
		end
		
feature -- Element change

	add_page is
			-- add page
		do
			create_page
			last_page.add_stream (Current)
			last_page.set_mediabox (default_mediabox)
		ensure
			created: last_page /= Void
			new: last_page /= old last_page
			stream: last_page.current_stream = last_stream
		end
	
	find_font (font_name : STRING; encoding_name : STRING) is
			-- find the 'font_name' font with 'encoding_name' encoding
			-- last_font /= Void if found...
		require
			good_encoding_name: encoding_name.is_equal (Encoding_winansi) or else
				encoding_name.is_equal (Encoding_mac) or else
				encoding_name.is_equal (Encoding_standard) or else
				encoding_name.is_equal (Encoding_pdf)
		local
			font_key : STRING
		do
			font_key := new_font_key (font_name, encoding_name)
			fonts_table.search (font_key)
			if fonts_table.found then
				last_font := fonts_table.found_item
			else
				-- create font and add to table
				-- 1. find/create encoding
				find_encoding (encoding_name)
				if last_encoding /= Void then
					-- 2. create font
					create_font (font_name, last_encoding)
					-- 3. insert font in table
					fonts_table.force (last_font, font_key)
				else
					last_font := Void
				end
			end
		end
	
	set_default_mediabox (a_media_box : PDF_RECTANGLE) is
			-- set `default_mediabox'
		require
			a_media_box /= Void
		do
			default_mediabox := a_media_box
		ensure
			default_mediabox = a_media_box
		end
	
	set_page_layout (name : STRING) is
			-- set the page layout for viewing or printing
		require
			good_name: name.is_equal (Layout_single_page) or else
				name.is_equal (Layout_one_column) or else
				name.is_equal (Layout_two_column_left) or else
				name.is_equal (Layout_two_column_right)
		do
			!!page_layout.make (name)
		ensure
			page_layout /= Void and then page_layout.value = name
		end
			
	find_encoding (encoding_name : STRING) is
			-- find 'encoding_name' encoding.  If found, last_encoding /= Void
		require
			encoding_name /= Void
		do
			encodings_table.search (encoding_name)
			if encodings_table.found then
				last_encoding := encodings_table.found_item
			else
				-- create encoding
				if encoding_name.is_equal (Encoding_winansi) then
					create_winansi_encoding
				elseif encoding_name.is_equal (Encoding_mac) then
					create_mac_encoding
				elseif encoding_name.is_equal (Encoding_standard) then
					create_adobe_standard_encoding
				elseif encoding_name.is_equal (Encoding_pdf) then
					create_pdf_encoding
				else
					last_encoding := Void
				end
				if last_encoding /= Void then
					encodings_table.force (last_encoding, encoding_name)
				end
			end
		end

feature -- Constants

	Encoding_winansi : STRING is "WinAnsiEncoding"
			-- ANSI encoding for Latin languages

	Encoding_mac : STRING is "MacRomanEncoding"
			-- Latin text in western European languages
	
	Encoding_standard : STRING is "StandardEncoding"
			-- standard encoding.
			-- Use it for Symbol and ZapfDingbats fonts

	Encoding_pdf : STRING is "PDFDocEncoding"
			-- Encoding used outside of stream objects
			-- Not intented to be used.

	Layout_single_page : STRING is "SinglePage" 
			-- Display one page at a time.

	Layout_one_column : STRING is "OneColumn" 
			-- Display the pages in one column.

	Layout_two_column_left : STRING is "TwoColumnLeft"
			-- Display the pages in two columns, with oddnumbered
			-- pages on the left.

	Layout_two_column_right : STRING is "TwoColumnRight"
			-- Display the pages in two columns, with oddnumbered
			-- pages on the right.

	Mediabox_letter : PDF_RECTANGLE is
			-- letter format
		once
			!!Result.make_letter
		end
		
	Mediabox_a4 : PDF_RECTANGLE is
			-- a4 format
		once
			!!Result.make_a4
		end

feature -- Conversion

	to_pdf : STRING is
			-- Current converted to PDF format - 'put_pdf' is preferred.
		local
			string_stream : KL_STRING_OUTPUT_STREAM
			output_medium : PDF_OUTPUT_MEDIUM
		do
			!!string_stream.make_empty
			!!output_medium.make (string_stream)
			put_pdf (output_medium)
			Result := string_stream.string
		end

	put_pdf (medium : PDF_OUTPUT_MEDIUM) is
			-- put document to `medium'
		do
			pdf_count := 0
			-- build pages tree
			build_pages_tree
			-- header
			medium.put_string (pdf_header)
			-- body
			put_pdf_body (medium)
			-- cross reference
			xref_index := medium.count
			xref.put_pdf (medium)
			-- trailer
			put_pdf_trailer (medium)
		end

feature {PDF_PAGE} -- Factory
	
	create_stream is
			-- create Stream object before any text or graphics operation
			-- and add it to a page
		do
			!!last_stream.make (xref.count, last_page)
			xref.add_entry (last_stream)
		ensure
			last_stream /= Void and last_stream.page = last_page
		end

	last_stream : PDF_STREAM
	
feature {NONE} -- Factory results (private)

	last_catalog : PDF_CATALOG
				
	last_dictionary_object : PDF_DICTIONARY_OBJECT

	last_pages : PDF_PAGES

	create_pages is
			-- create a new pages node
		do
			!!last_pages.make (xref.count)
			xref.add_entry (last_pages)
		ensure
			created: last_pages /= Void
			new: last_pages /= old last_pages
		end
		
	create_page is
			-- create a new page
		do
			!!last_page.make (xref.count)
			xref.add_entry (last_page)
			page_list.put_last (last_page)
			-- temporarily link to root pages node
			last_page.set_parent (catalog.pages)
		ensure
			created: last_page /= Void
			new: last_page /= old last_page
			added_to_list: page_list.has (last_page)
		end

feature {NONE} -- Implementation

	create_dictionary_object is
			-- 
		do
			!!last_dictionary_object.make (xref.count)
			xref.add_entry (last_dictionary_object)
		end

	create_catalog is
			-- 
		do
			!!last_catalog.make (xref.count)
			xref.add_entry (last_catalog)
		end

	create_winansi_encoding is
			-- 
		do
				!PDF_WINANSI_ENCODING!last_encoding		
		end
		
	create_mac_encoding is
			-- 
		do
				!PDF_MAC_ENCODING!last_encoding
		end
		
	create_adobe_standard_encoding is
			-- 
		do
				!PDF_ADOBE_STANDARD_ENCODING!last_encoding
		end
		
	create_pdf_encoding is
			--
		do
				!PDF_PDF_ENCODING!last_encoding
		end

	
	create_font (font_name : STRING; encoding : PDF_CHARACTER_ENCODING) is
			-- create 'font_name' font with 'encoding' 
		require
			font_name /= Void
		do
			if font_name.is_equal ("Courier") then
				!PDF_COURIER_FONT!last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Helvetica") then
				!PDF_HELVETICA_FONT!last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Times-Roman") then
				!PDF_TIMES_ROMAN_FONT!last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Symbol") then
				!PDF_SYMBOL_FONT!last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Courier-Bold") then
				!PDF_COURIER_BOLD_FONT!last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Helvetica-Bold") then
				!PDF_HELVETICA_BOLD_FONT!last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Times-Bold") then
				!PDF_TIMES_BOLD_FONT!last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("ZapfDingbats") then
				!PDF_ZAPFDINGBATS_FONT!last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Courier-Oblique") then
				!PDF_COURIER_OBLIQUE_FONT!last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Helvetica-Oblique") then
				!PDF_HELVETICA_OBLIQUE_FONT!last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Times-Italic") then
				!PDF_TIMES_ITALIC_FONT!last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Courier-BoldOblique") then
				!PDF_COURIER_BOLDOBLIQUE_FONT!last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Helvetica-BoldOblique") then
				!PDF_HELVETICA_BOLDOBLIQUE_FONT!last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Times-BoldItalic") then
				!PDF_TIMES_BOLDITALIC_FONT!last_font.make (xref.count, encoding)
			else
				last_font := Void
			end
			if last_font /= Void then
				xref.add_entry (last_font)
			end
		ensure
			last_font /= Void implies last_font.encoding = encoding
		end

	xref : PDF_XREF
	
	xref_index : INTEGER
		-- xref index in file

	pdf_count : INTEGER

	pdf_header : STRING is "%%PDF-1.3%N"

	put_pdf_body (medium : PDF_OUTPUT_MEDIUM) is
			-- put pdf body
		local
			object_number : INTEGER
		do
			from
				object_number := 1
			until
				object_number = count
			loop
				xref.set_entry_offset (object_number, medium.count)
				xref.object (object_number).put_pdf (medium)
				object_number := object_number + 1
			end
		end

	put_pdf_xref (medium : PDF_OUTPUT_MEDIUM) is
			-- put pdf cross reference
		do
						
		end

	put_pdf_trailer (medium : PDF_OUTPUT_MEDIUM) is
			-- put pdf trailer 
		local
			size_name : PDF_NAME
			root_name : PDF_NAME
		do 
			medium.put_string ("trailer%N")
			!!size_name.make ("Size")
			!!root_name.make ("Root")
			medium.put_string ("<<%N")
			medium.put_string (dictionary_entry (size_name, count.out))
			medium.put_string (dictionary_entry (root_name, catalog.indirect_reference))
			medium.put_string (">>%N")
			-- startxref
			medium.put_string ("startxref%N")
			medium.put_string (xref_index.out)
			medium.put_new_line
			medium.put_string ("%%%%EOF%N")
		end
		
	fonts_table : DS_HASH_TABLE[PDF_FONT, STRING]

	encodings_table : DS_HASH_TABLE[PDF_CHARACTER_ENCODING, STRING]
	
	new_font_key (font_name, encoding_name : STRING) : STRING is
		do
			!!Result.make (font_name.count+encoding_name.count+1)
			Result.append_string (font_name)
			Result.append_character (',')
			Result.append_string (encoding_name)
		end

	page_list : DS_LIST[PDF_PAGE]

	build_pages_tree is
			-- Build pages tree using PDF_PAGE_TREE_NODEs, hierachical organization
			-- of pages; Each PDF_PAGES_TREE_NODE having at most 'kids_count' kids.
		local
			nodes_count : INTEGER
			nodes_list : DS_LIST[PDF_PAGE_TREE_NODE]
			nodes_list_cursor : DS_LIST_CURSOR [PDF_PAGE_TREE_NODE]
		do
			from
				nodes_count := ((page_list.count - 1)/kids_count).truncated_to_integer + 1
				nodes_list := page_list
				last_parent_list := Void
			until
				nodes_count < kids_count
			loop
				give_a_parent (nodes_list)
				nodes_count := ((nodes_count - 1)/kids_count).truncated_to_integer + 1
			end
			-- add those nodes to root node
			if last_parent_list /= Void then
				nodes_list := last_parent_list
			else
				nodes_list := page_list
			end
			from
				nodes_list_cursor := nodes_list.new_cursor
				nodes_list_cursor.start
				catalog.pages.empty_kids
			until
				nodes_list_cursor.off
			loop
				catalog.pages.add_kid (nodes_list_cursor.item)
				nodes_list_cursor.forth
			end
		end
		
	give_a_parent (nodes : DS_LIST[PDF_PAGE_TREE_NODE]) is
			-- Give a parent to 'nodes'; parent can be found in 'last_parent'
		local
			node_count : INTEGER
			nodes_list_cursor : DS_LIST_CURSOR [PDF_PAGE_TREE_NODE]
		do
			from 
				nodes_list_cursor := nodes.new_cursor 
				nodes_list_cursor.start
				node_count := 0
				!DS_LINKED_LIST[PDF_PAGE_TREE_NODE]!last_parent_list.make
			variant
				nodes.count - node_count
			until
				nodes_list_cursor.off
			loop
				if node_count \\ kids_count = 0 then
					-- create a parent
					create_pages
					-- add it to the DS_LIST
					last_parent_list.put_last (last_pages)					
				end
				-- add kids up-to the kids_count
				last_pages.add_kid (nodes_list_cursor.item)
				node_count := node_count + 1
				nodes_list_cursor.forth
			end		
		ensure
			result_in_last_parent_list: last_parent_list /= Void 
				-- and each parent p in last_parent_list
				-- has at most 'kids_count' kids from nodes
				-- foreach n in nodes : n.parent /= Void : each node in nodes has a parent
		end
		
	last_parent_list : DS_LIST[PDF_PAGE_TREE_NODE]
	
	kids_count : INTEGER is 10
	
end -- class PDF_DOCUMENT
