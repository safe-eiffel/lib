indexing
	description: "Objects that..."

	usage: ""
	quality: ""
	refactoring: ""

	status: "see notice at end of class";
	date: "$Date$";
	revision: "$Revision$";
	author: ""

class FO_CONFIGURABLE_FACTORY

inherit
	
	FO_MEASUREMENT_ROUTINES
	
create
	make
	
feature {NONE} -- Initialization

	make (file_name : STRING; error_handler : UT_ERROR_HANDLER) is
		require
			file_name_not_voit: file_name /= Void
		local
			styles : DS_LIST_CURSOR[XFOCFG_STYLE]
			sections: DS_LIST_CURSOR[XFOCFG_SECTION]
			section : XFOCFG_SECTION
			style : XFOCFG_STYLE
		do
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
				from
					sections := xml_document.section_collection.new_cursor
					sections.start
				until
					sections.off
				loop
					section := sections.item
					section_catalog.force (section, section.attribute_name)
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
					styles.forth
				end
			else
				error_handler.report_error_message (parser.last_error_extended_description)
			end		
		end
	
		
feature -- Access

	last_document : FO_DOCUMENT
	
	last_section : FO_SECTION
	
	last_block : FO_BLOCK
	
	last_inline : FO_INLINE
	
	last_row : FO_ROW
	
	xml_document : XFOCFG_DOCUMENT

	section_names : DS_LIST[STRING] is	
			-- Names of available sections.
			-- (Warning: creates a new list at each call)
		local
			c : DS_HASH_TABLE_CURSOR[XFOCFG_SECTION, STRING]
		do
			create {DS_LINKED_LIST[STRING]}Result.make
			from
				c := section_catalog.new_cursor
				c.start
			until
				c.off
			loop
				Result.put_last (c.key)
				c.forth
			end
		ensure
			section_names_not_void: Result /= Void
		end

	style_names : DS_LIST[STRING] is	
			-- Names of available styles.
			-- (Warning: creates a new list at each call)
		local
			c : DS_HASH_TABLE_CURSOR[XFOCFG_STYLE, STRING]
		do
			create {DS_LINKED_LIST[STRING]}Result.make
			from
				c := style_catalog.new_cursor
				c.start
			until
				c.off
			loop
				Result.put_last (c.key)
				c.forth
			end
		ensure
			style_names_not_void: Result /= Void
		end
		
feature -- Status report

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

	new_document (a_writer : FO_DOCUMENT_WRITER) is
		local
			l_rectangle : FO_RECTANGLE
			section : XFOCFG_SECTION
		do
			section_catalog.search ("default")
			if section_catalog.found then
				section := section_catalog.found_item
				l_rectangle := x_new_page_rectangle (section.page)
			end
			create last_document.make (l_rectangle, a_writer)
		end
		
	
	new_section (name : STRING) is
		require
			name_not_void: name /= Void
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
				margins := x_new_margins (section.margins)
				if margins = Void then
					create margins.make
				end
				page := section.page
				if page = Void then
					create rectangle.set (cm (0), cm(0), cm (21), cm (29.7))
				else
					rectangle := x_new_page_rectangle (page)
					if page.attribute_orientation /= Void then
						is_landscape := page.attribute_orientation.is_equal ("landscape")
					end
				end
				create last_section.make (section.attribute_name, rectangle, margins)
				if is_landscape then
					last_section.set_orientation_landscape
				end
			end
		end
		
	new_block (name : STRING) is
		require
			name_not_void: name /= Void
		local
			style : XFOCFG_STYLE
			margins : FO_MARGINS
			justification : STRING
		do
			style_catalog.search (name)
			if style_catalog.found then
				style := style_catalog.found_item
				margins := x_new_margins (style.margins)
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
			end
		end
		
	new_inline (name : STRING) is
		require
			name_not_void: name /= Void
		local
			font : FO_FONT
		do
			style_catalog.search (name)
			if style_catalog.found then
				font := x_new_font (style_catalog.found_item.font)
				create last_inline.make_with_font ("",font)
			end
		end
	
--	new_row (name : STRING) is	
--		require
--			name_not_void: name /= Void
--		do
--			create last_row.
--		end

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

	x_new_margins (xmargins : XFOCFG_MARGINS) : FO_MARGINS is	
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

	x_new_page_rectangle (xpage : XFOCFG_PAGE) : FO_RECTANGLE is	
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
		end

	x_new_font (xfont : XFOCFG_FONT) : FO_FONT is	
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
				font_factory.find_font (family, weight, style, font_factory.encoding_winansi)
				if font_factory.last_font /= Void then
					Result := font_factory.last_font
					Result.set_size (size)
					if xfont.attribute_stretch /= Void then
						Result.set_stretch (xfont.attribute_stretch)
					end
				end
			end
		end
		
	font_factory : FO_FONT_FACTORY is
		once
			create Result.make
		end
		
end

