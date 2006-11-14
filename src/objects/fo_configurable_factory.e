indexing
	description:

		"Factories of fo_objects, configurable by an XML file."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"


class FO_CONFIGURABLE_FACTORY

inherit

	FO_MEASUREMENT_ROUTINES

	FO_SHARED_DEFAULTS

create
	make

feature {NONE} -- Initialization

	make (file_name : STRING; an_error_handler : UT_ERROR_HANDLER) is
			-- Make using configuration in `file_name', and reporting into `error_handler'.
		require
			file_name_not_void: file_name /= Void
			an_error_handler_not_void: an_error_handler /= Void
		local
			styles : DS_LIST_CURSOR[XFOCFG_STYLE]
			sections: DS_LIST_CURSOR[XFOCFG_SECTION]
			section : XFOCFG_SECTION
			style : XFOCFG_STYLE
			tester : KL_EQUALITY_TESTER[STRING]
		do
			error_handler := an_error_handler
			create parser.make
			create tree_pipe.make
			parser.set_callbacks (tree_pipe.start)
			create input.make (file_name)
			input.open_read
			parser.parse_from_stream (input)
			
			create factory.make
			if not tree_pipe.error.has_error then
				xml_document := factory.new_document (tree_pipe.document.root_element)
				create style_catalog.make (10)
				create section_catalog.make (10)
				create style_names_impl.make
				create tester
				style_names_impl.set_equality_tester (tester)
				create section_names_impl.make
				create tester
				section_names_impl.set_equality_tester (tester)
				from
					sections := xml_document.section_collection.new_cursor
					sections.start
				until
					sections.off
				loop
					section := sections.item
					section_catalog.force (section, section.attribute_name)
					section_names_impl.put_last (section.attribute_name)
					sections.forth
				end
				from
					styles := xml_document.style_collection.new_cursor
					styles.start
				until
					styles.off
				loop
					style := styles.item
					style_catalog.force (style, style.attribute_name)
					style_names_impl.put_last (style.attribute_name)
					styles.forth
				end
			else
				error_handler.report_error_message (parser.last_error_extended_description)
				is_error := True
			end
		ensure
			error_handler_set: error_handler = an_error_handler
		end


feature -- Access

	error_handler : UT_ERROR_HANDLER

	last_document : FO_DOCUMENT
			-- Last created document.

	last_section : FO_SECTION
			-- Last created section.

	last_block : FO_BLOCK
			-- Last created block.

	last_inline : FO_INLINE
			-- Last created inline.

	last_row : FO_ROW
			-- Last created row.

	section_names : DS_LIST[STRING] is
			-- Names of available sections.
		do
			Result := section_names_impl
		ensure
			section_names_not_void: Result /= Void
		end

	style_names : DS_LIST[STRING] is
			-- Names of available styles.
		do
			Result := style_names_impl
		ensure
			style_names_not_void: Result /= Void
		end

feature -- Status report

	is_error : BOOLEAN

	is_ok : BOOLEAN is do Result := not is_error end

	has_style (name : STRING) : BOOLEAN is
			-- Does style `name' exist?
		require
			name_not_void: name /= Void
		do
			Result := style_catalog.has (name)
		end

	has_section (name : STRING) : BOOLEAN is
			-- Does section `name' exist?
		require
			name_not_void: name /= Void
		do
			Result := section_catalog.has (name)
		end

feature -- Basic operations

	create_document (a_writer : FO_DOCUMENT_WRITER) is
			-- Create document from `a_writer'.
		require
			is_ok: is_ok
			a_writer_not_void: a_writer /= Void
		local
			l_rectangle : FO_RECTANGLE
			section : XFOCFG_SECTION
		do
			section_catalog.search ("default")
			if section_catalog.found then
				section := section_catalog.found_item
				l_rectangle := x_new_page_rectangle (section.page, error_handler)
			end
			create last_document.make_rectangle (l_rectangle, a_writer)
		ensure
			last_document_not_void: last_document /= Void
		end

	create_section (name : STRING) is
			-- Create section corresponding to `name'.
		require
			is_ok: is_ok
			name_not_void: name /= Void
			section_names_has_name: section_names.has (name)
		local
			section : XFOCFG_SECTION
			margins : FO_MARGINS
			rectangle : FO_RECTANGLE
			page : XFOCFG_PAGE
			is_landscape : BOOLEAN
		do
			section_catalog.search (name)
			if section_catalog.found then
				section := section_catalog.found_item
				margins := x_new_margins (section.margins, error_handler)
				if margins = Void then
					create margins.make
				end
				page := section.page
				if page = Void then
					create rectangle.set (cm (0), cm(0), cm (21), cm (29.7))
				else
					rectangle := x_new_page_rectangle (page, error_handler)
					if page.attribute_orientation /= Void then
						is_landscape := page.attribute_orientation.is_equal ("landscape")
					end
				end
				create last_section.make (section.attribute_name, rectangle, margins)
				if is_landscape then
					last_section.set_orientation_landscape
				end
			else
				create last_section.make ("default", shared_defaults.document_rectangle, shared_defaults.document_margins)
			end
		ensure
			last_section_not_void: last_section /= Void
		end

	create_block (name : STRING) is
			-- Create block corresponding to `name'.
		require
			is_ok: is_ok
			name_not_void: name /= Void
			style_names_has_name: style_names.has (name)
		local
			style : XFOCFG_STYLE
			margins : FO_MARGINS
			justification : STRING
		do
			style_catalog.search (name)
			if style_catalog.found then
				style := style_catalog.found_item
				margins := x_new_margins (style.margins, error_handler)
				if margins = Void then
					create margins.make
				end
				create last_block.make (margins)
				if style_catalog.found_item.justification /= Void then
					justification := style_catalog.found_item.justification.attribute_value
					if justification /= Void then
						if justification.is_equal ("center") then
							last_block.center_justify
						elseif justification.is_equal ("right") then
							last_block.right_justify
						end
					end
				end
			else
				create last_block.make_default
			end
		ensure
			last_block_not_void: last_block /= Void
		end

	create_block_inline (style : STRING) is
			-- Create block whith inline corresponding to `style'.
		require
			style_not_void: style /= Void
		do
			create_block (style)
			create_inline (style)
			last_block.append (last_inline)
		ensure
			last_block_not_void: last_block /= Void
			last_block_has_last_inline: last_block.last_inline = last_inline
		end

	create_inline (name : STRING) is
			-- Create inline with style `name'.
		require
			is_ok: is_ok
			name_not_void: name /= Void
		local
			font : FO_FONT
			xfont : XFOCFG_FONT
		do
			style_catalog.search (name)
			if style_catalog.found then
				xfont := style_catalog.found_item.font
				font := x_new_font (xfont, error_handler)
				create last_inline.make_with_font ("",font)
				if xfont.attribute_stretch /= Void then
					last_inline.set_stretch (unit (xfont.attribute_stretch.item))
				end
			else
				create last_inline.make ("")
			end
		ensure
			last_inline_not_void: last_inline /= Void
		end

--	create_row (name : STRING) is
--		require
--			name_not_void: name /= Void
--		do
--			create last_row.
--		end

feature {NONE} -- Implementation

	parser : XM_EIFFEL_PARSER

	tree_pipe: XM_TREE_CALLBACKS_PIPE

	input : KL_TEXT_INPUT_FILE

	factory : XFOCFG_DOCUMENT_FACTORY

	points_regex : RX_PCRE_REGULAR_EXPRESSION is
		once
			create Result.make
			Result.compile ("([+\-]?[0-9]+(\.[0-9]*)?)((in)|(pt)|(cm)|(mm))")
		end

	style_catalog : DS_HASH_TABLE[XFOCFG_STYLE, STRING]
	section_catalog : DS_HASH_TABLE [XFOCFG_SECTION, STRING]

	x_new_document (xdocument : XFOCFG_DOCUMENT; eh : UT_ERROR_HANDLER) : FO_DOCUMENT is
		require
			xdocument_not_void: xdocument /= Void
			eh_not_void: eh /= Void
		do

		end

	x_new_margins (xmargins : XFOCFG_MARGINS; eh : UT_ERROR_HANDLER) : FO_MARGINS is
		require
			xmargins_not_void: xmargins /= Void
			eh_not_void: eh /= Void
		local
			m : FO_MEASUREMENT
		do
			create Result.make
			if xmargins.attribute_left /= Void then
				m := new_measurement (xmargins.attribute_left)
				if m /= Void then
					Result.set_left (m)
				end
			end
			if xmargins.attribute_top /= Void then
				m := new_measurement (xmargins.attribute_top)
				if m /= Void then
					Result.set_top (m)
				end
			end
			if xmargins.attribute_bottom /= Void then
				m := new_measurement (xmargins.attribute_bottom)
				if m /= Void then
					Result.set_bottom (m)
				end
			end
			if xmargins.attribute_right /= Void then
				m := new_measurement (xmargins.attribute_right)
				if m /= Void then
					Result.set_right (m)
				end
			end
		end

	x_new_page_rectangle (xpage : XFOCFG_PAGE; eh : UT_ERROR_HANDLER) : FO_RECTANGLE is
		require
			xpage_not_void: xpage /= Void
		local
			zero : FO_MEASUREMENT
			height, width : FO_MEASUREMENT
		do
			create zero.points (0)
			height := zero
			width := zero
			create Result.make
			if xpage.attribute_height /= Void then
				height := new_measurement (xpage.attribute_height)
			end
			if xpage.attribute_width /= Void then
				width := new_measurement (xpage.attribute_width)
			end
			Result.set (zero, zero, width, height)
			if xpage.attribute_orientation /= Void then
				if xpage.attribute_orientation.is_equal ("landscape") then

				end
			end
		end

	x_new_font (xfont : XFOCFG_FONT; eh : UT_ERROR_HANDLER) : FO_FONT is
		require
			xfont_not_void: xfont /= Void
		local
			family, weight, style : STRING
			size : FO_MEASUREMENT
		do
			family := xfont.attribute_family
			weight := xfont.attribute_weight
			style := xfont.attribute_style
			size := new_measurement (xfont.attribute_size)
			if family /= Void then
				if weight = Void then
					weight := ""
				end
				if style = Void then
					style := ""
				end
				if size = Void then
					create size.points (12)
				end
				font_factory.find_font (family, weight, style, size)
				if font_factory.last_font /= Void then
					Result := font_factory.last_font
				end
			end
		end

	font_factory : FO_FONT_FACTORY is
		once
			create Result.make
		ensure
			font_factory_not_void: result /= Void
		end

	style_names_impl : DS_LINKED_LIST[STRING]
	section_names_impl : DS_LINKED_LIST[STRING]

	new_measurement (m : STRING) : FO_MEASUREMENT is
		require
			m_not_void: m /= Void
		local
			value : STRING
			v : DOUBLE
			measurement_unit : STRING
		do
			create Result.points (0)
			points_regex.match (m)
			if points_regex.has_matched then
				value := points_regex.captured_substring (1)
				measurement_unit := points_regex.captured_substring (3)
				v := value.to_double
				if measurement_unit.is_equal ("cm") then
					create Result.centimeters (v)
				elseif measurement_unit.is_equal ("pt") then
					create Result.points (v)
				elseif measurement_unit.is_equal ("mm") then
					create Result.millimeters (v)
				elseif measurement_unit.is_equal ("in") then
					create Result.inches (v)
				else
					do_nothing
				end
			end
		end

	xml_document : XFOCFG_DOCUMENT
			-- XML document.

invariant

	style_names_impl_not_void: style_names_impl /= Void
	section_names_impl_not_void: section_names_impl /= Void

end

