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

	PDF_LAYOUT_CONSTANTS

	PDF_PAGE_MODE_CONSTANTS

	PDF_ENCODING_CONSTANTS

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all;
			{ANY} file_system
		end
create
	make

feature {NONE} -- Initialization

	make is
			-- creates a document
		do
			-- create non PDF-objects
			create xref.make
			create fonts_table.make (10)
			create encodings_table.make (2)
			!DS_LINKED_LIST[PDF_PAGE]!page_list.make
			default_mediabox := Mediabox_a4
			-- use factory methods for PDF-objects
			create_pages
			create_catalog (last_pages)
			catalog := last_catalog
			-- ensure invariant
			create_information_impl
			-- ensure post_condition
			add_page
		ensure
			default_mediabox_exists: default_mediabox = Mediabox_a4
			first_page_created: last_page /= Void
		end

feature {NONE} -- Access

	catalog : PDF_CATALOG
			-- PDF mandatory

feature -- Access

	page_layout : PDF_NAME
			-- A name object specifying the page layout to be used when the
			-- document is opened

	page_mode : PDF_NAME
			-- The page mode to be used when the document is opened

	default_mediabox : PDF_RECTANGLE
			-- Media box for pages without specific media box

	last_page : PDF_PAGE
			-- Last created page; set by `add_page'

	last_font : PDF_FONT
			-- Last found font; set by `find_font'

	last_encoding : PDF_CHARACTER_ENCODING
			-- Last character encoding; set by `find_encoding'

	last_image : PDF_IMAGE
			-- Last image created by `create_image' or `create_png_image'

	last_outline_item : PDF_OUTLINE_ITEM
			-- Last outline item created

	outlines : PDF_OUTLINES is
			-- Outlines entry; root of outline items
		do
			Result := catalog.outlines
		end

	information : PDF_DOCUMENT_INFORMATION is
			-- Metadata about current document
		do
			Result := document_information
		end

	viewer_preferences : PDF_VIEWER_PREFERENCES
			-- UI preferences for PDF Viewer

feature -- Status report

	valid_encoding (encoding_name : STRING) : BOOLEAN is
		do
			if encoding_name /= Void then
				Result := encoding_name.is_equal (Encoding_winansi) or else
				encoding_name.is_equal (Encoding_mac) or else
				encoding_name.is_equal (Encoding_standard) or else
				encoding_name.is_equal (Encoding_pdf)
			end
		end

feature {NONE} -- Measurement

	count : INTEGER is
			-- number of PDF objects
		do
			Result := xref.count
		end

feature -- Element change

	add_named_destination (a_name : STRING; a_destination : PDF_DESTINATION) is
		require
			a_name_not_void: a_name /= Void
			a_destination_not_void: a_destination /= Void
		local
			names_dictionary : PDF_DICTIONARY_OBJECT
		do
			if destinations_catalog = Void then
				create destinations_catalog.make (Current, 100)
				create_dictionary_object
				names_dictionary := last_dictionary_object
				names_dictionary.add_entry (names.dests.value, destinations_catalog)
				catalog.set_names (names_dictionary)
			end
			destinations_catalog.force (a_destination, a_name)
		end

	add_page is
			-- create a new page and add it to Current
		do
			create_page
			last_page.add_stream (Current)
			last_page.set_mediabox (default_mediabox)
		ensure
			created: last_page /= Void
			new: last_page /= old last_page
			stream: last_page.current_stream = last_stream
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
			create page_layout.make (name)
			catalog.set_page_layout (page_layout)
		ensure
			page_layout /= Void and then page_layout.value.is_equal (name)
		end

	set_page_mode (name : STRING) is
			-- set the page mode for viewing
		require
			good_name: name.is_equal (Mode_use_none) or else
				name.is_equal (Mode_use_outlines) or else
				name.is_equal (Mode_use_thumbs) or else
				name.is_equal (Mode_full_screen)
		do
			create page_mode.make (name)
			catalog.set_page_mode (page_mode)
		ensure
			page_mode_set: page_mode /= Void and then page_mode.value.is_equal (name)
		end

	create_image (image_width, image_height, sample_colors, color_precision: INTEGER) is
			-- Create an image, `image_width' large, `image_height' high, with `sample_colors' color count and `color_precision' bits per sample
		require
			image_width_positive: image_width >= 1
			image_height_positive: image_height >= 1
			valid_sample_colors: sample_colors = 1 or else sample_colors = 3
			valid_color_precision: color_precision = 1 or else color_precision = 4 or else color_precision = 8
		do
			create last_image.make (xref.count, image_width, image_height, sample_colors, color_precision)
			xref.add_entry (last_image)
		ensure
			image_created: last_image /= Void
		end

	create_png_image (file_name : STRING) is
			-- create png image from file `file_name'
		require
			file_name_exists: file_name /= Void
			file_exists: File_system.file_exists (file_name)
		local
			pdf_image : PDF_PNG_IMAGE
		do
			create {PDF_PNG_IMAGE}pdf_image.make (xref.count, file_name)
			if pdf_image.is_valid then
				xref.add_entry (pdf_image)
				pdf_image.fill_xobject (Current)
				last_image := pdf_image
			end
		ensure
			image_created: last_image /= Void and then last_image /= old last_image
		end

	create_outlines is
			-- create `outlines'
		require
			no_outlines: outlines = Void
		local
			l_outlines : PDF_OUTLINES
		do
			create l_outlines.make (xref.count)
			xref.add_entry (l_outlines)
			catalog.set_outlines (l_outlines)
		ensure
			outlines_set: outlines /= Void
		end

	create_outline_item (item_title: STRING; referenced_page: PDF_PAGE; referenced_left, referenced_top: DOUBLE) is
			-- create outline item with `item_title', referencing `referenced_page', fitting the window top left corner at `referenced_left', `referenced_top'
		require
			item_title_exists: item_title /= Void
			referenced_page_exists: referenced_page /= Void
			destination_fits_mediabox: referenced_page.mediabox.has_point (referenced_left, referenced_top)
		do
			create last_outline_item.make (xref.count, item_title, referenced_page, referenced_left, referenced_top)
			xref.add_entry (last_outline_item)
		ensure
			last_outline_item_created: last_outline_item /= Void and then last_outline_item /= old last_outline_item
		end

	create_outline_item_with_destination (title : STRING; destination : PDF_DESTINATION) is
			-- create outline item with `item_title', referencing `destination'
		require
			title_exists: title /= Void
			destination_exists: destination /= Void
		do
			create last_outline_item.make_with_destination (xref.count, title, destination)
			xref.add_entry (last_outline_item)
		ensure
			last_outline_item_created: last_outline_item /= Void and then last_outline_item /= old last_outline_item
		end

	create_information is
			-- create `information'
		obsolete "information need not be created anymore"
		do
		ensure
			information_exist: information /= Void
		end

	create_viewer_preferences is
		require
			view_preferences_do_not_exist: viewer_preferences = Void
		do
			create viewer_preferences.make (xref.count)
			xref.add_entry (viewer_preferences)
			catalog.set_viewer_preferences (viewer_preferences)
		ensure
			viewer_preferences_exist: viewer_preferences /= Void
		end

feature -- Constants

	Mediabox_letter : PDF_RECTANGLE is
			-- letter format
		once
			create Result.make_letter
		end

	Mediabox_a4 : PDF_RECTANGLE is
			-- a4 format
		once
			create Result.make_a4
		end

feature -- Conversion

	to_pdf : STRING is
			-- Current converted to PDF format - 'put_pdf' is preferred.
		local
			string_stream : KL_STRING_OUTPUT_STREAM
			output_medium : PDF_OUTPUT_MEDIUM
		do
			create string_stream.make_empty
			create output_medium.make_string (string_stream)
			put_pdf (output_medium)
			Result := string_stream.string
		end

	put_pdf (medium : PDF_OUTPUT_MEDIUM) is
			-- put document to `medium'
		local
			startxref : INTEGER
		do
			-- build pages tree
			catalog.pages.build_pages_tree (Current, page_list)
			-- header
			medium.put_string (pdf_header)
			-- body
			put_pdf_body (medium)
			-- cross reference
			startxref := medium.count
			xref.put_pdf (medium)
			-- trailer
			put_pdf_trailer (startxref, medium)
		end

feature -- Basic operations

	find_font (font_name : STRING; encoding_name : STRING) is
			-- find the 'font_name' font with 'encoding_name' encoding
			-- last_font /= Void if found...
		require
			good_encoding_name: valid_encoding (encoding_name)
			font_name_exists: font_name /= Void
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
		ensure
			same_name_if_found: last_font /= Void implies font_name.is_equal (last_font.basefont.value)
			same_encoding_if_found: last_font /= Void implies encoding_name.is_equal (last_font.encoding.name.value)
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
		ensure
			last_encoding: last_encoding /= Void implies encoding_name.is_equal (last_encoding.name.value)
		end

feature {PDF_PAGE} -- Factory

	create_stream is
			-- create Stream object before any text or graphics operation
			-- and add it to a page
		do
			create last_stream.make (xref.count, last_page)
			xref.add_entry (last_stream)
		ensure
			last_stream /= Void and last_stream.page = last_page
		end

	last_stream : PDF_STREAM

feature {PDF_PAGES} -- Factory results

	last_pages : PDF_PAGES

	create_pages is
			-- create a new pages node
		do
			create last_pages.make (xref.count)
			xref.add_entry (last_pages)
		ensure
			created: last_pages /= Void
			new: last_pages /= old last_pages
		end

feature {NONE} -- Factory results (private)

	last_catalog : PDF_CATALOG

	last_dictionary_object : PDF_DICTIONARY_OBJECT

	create_page is
			-- create a new page
		do
			create last_page.make (xref.count)
			xref.add_entry (last_page)
			page_list.put_last (last_page)
			-- temporarily link to root pages node
			last_page.set_parent (catalog.pages)
		ensure
			created: last_page /= Void
			new: last_page /= old last_page
			added_to_list: page_list.has (last_page)
		end

feature {PDF_OBJECT} -- Access

		xref : PDF_XREF
			-- PDF Cross reference

feature {NONE} -- Implementation

	create_dictionary_object is
			--
		do
			create last_dictionary_object.make (xref.count)
			xref.add_entry (last_dictionary_object)
		end

	create_catalog (pages_root : PDF_PAGES) is
			-- create `last_catalog' using `pages_root'
		require
			pages_root_exists: pages_root /= Void
		do
			create last_catalog.make (pages_root, xref.count)
			xref.add_entry (last_catalog)
		end

	create_winansi_encoding is
			-- create a Windows/ANSI encoding
		do
			create	{PDF_WINANSI_ENCODING}last_encoding
		ensure
			last_encoding_created: last_encoding /= Void
		end

	create_mac_encoding is
			-- create a MAC encoding
		do
			create 	{PDF_MAC_ENCODING}last_encoding
		ensure
			last_encoding_created: last_encoding /= Void
		end

	create_adobe_standard_encoding is
			-- create an Adobe standard encoding
		do
			create	{PDF_ADOBE_STANDARD_ENCODING}last_encoding
		ensure
			last_encoding_created: last_encoding /= Void
		end

	create_pdf_encoding is
			-- create a PDF encoding
		do
			create	{PDF_PDF_ENCODING}last_encoding
		ensure
			last_encoding_created: last_encoding /= Void
		end


	create_font (font_name : STRING; encoding : PDF_CHARACTER_ENCODING) is
			-- create a font of name `font_name' font with `encoding'
		require
			font_name_exists: font_name /= Void
		do
			if font_name.is_equal ("Courier") then
				create {PDF_COURIER_FONT} last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Helvetica") then
				create {PDF_HELVETICA_FONT} last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Times-Roman") then
				create {PDF_TIMES_ROMAN_FONT} last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Symbol") then
				create {PDF_SYMBOL_FONT} last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Courier-Bold") then
				create {PDF_COURIER_BOLD_FONT} last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Helvetica-Bold") then
				create {PDF_HELVETICA_BOLD_FONT} last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Times-Bold") then
				create {PDF_TIMES_BOLD_FONT} last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("ZapfDingbats") then
				create {PDF_ZAPFDINGBATS_FONT} last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Courier-Oblique") then
				create {PDF_COURIER_OBLIQUE_FONT} last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Helvetica-Oblique") then
				create {PDF_HELVETICA_OBLIQUE_FONT} last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Times-Italic") then
				create {PDF_TIMES_ITALIC_FONT} last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Courier-BoldOblique") then
				create {PDF_COURIER_BOLDOBLIQUE_FONT} last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Helvetica-BoldOblique") then
				create {PDF_HELVETICA_BOLDOBLIQUE_FONT} last_font.make (xref.count, encoding)
			elseif font_name.is_equal ("Times-BoldItalic") then
				create {PDF_TIMES_BOLDITALIC_FONT} last_font.make (xref.count, encoding)
			else
				last_font := Void
			end
			if last_font /= Void then
				xref.add_entry (last_font)
			end
		ensure
			font_created_with_encoding: last_font /= Void implies last_font.encoding = encoding
			font_created_has_same_name: last_font /= Void implies last_font.basefont.value.is_equal (font_name)
		end

	pdf_header : STRING is "%%PDF-1.4%N%%‚„œ”%N"

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


	put_pdf_trailer (startxref : INTEGER; medium : PDF_OUTPUT_MEDIUM) is
			-- put pdf trailer
		require
			startxref_lower_medium_count: startxref < medium.count
		local
			size_name : PDF_NAME
			root_name : PDF_NAME
			info_name : PDF_NAME
		do
			medium.put_string ("trailer%N")
			create size_name.make ("Size")
			create root_name.make ("Root")
			medium.put_string ("<<%N")
			medium.put_string (dictionary_entry (size_name, count.out))
			medium.put_string (dictionary_entry (root_name, catalog.indirect_reference))
			if not document_information.is_empty then
				create info_name.make ("Info")
				medium.put_string (dictionary_entry (info_name, document_information.indirect_reference))
			end
			medium.put_string (">>%N")
			-- startxref
			medium.put_string ("startxref%N")
			medium.put_string (startxref.out)
			medium.put_new_line
			medium.put_string ("%%%%EOF%N")
		end


	destinations_catalog : PDF_NAME_TREE

	fonts_table : DS_HASH_TABLE[PDF_FONT, STRING]

	encodings_table : DS_HASH_TABLE[PDF_CHARACTER_ENCODING, STRING]

	new_font_key (font_name, encoding_name : STRING) : STRING is
		do
			create Result.make (font_name.count+encoding_name.count+1)
			Result.append_string (font_name)
			Result.append_character (',')
			Result.append_string (encoding_name)
		end

	page_list : DS_LIST[PDF_PAGE]

	document_information : PDF_DOCUMENT_INFORMATION

	create_information_impl is
			-- create `information'
		require
			information_does_not_exist: information = Void
		do
			if information = Void then
				create document_information.make (xref.count)
				xref.add_entry (document_information)
			end
		ensure
			information_exist: information /= Void
		end

invariant
	information_always_present: information /= Void
	default_mediabox_exists: default_mediabox /= Void

end -- class PDF_DOCUMENT
