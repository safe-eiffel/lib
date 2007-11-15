indexing

	description: "Factory of XFOCFG_SECTION objects."
	note: "Generated class; DO NOT MODIFY"
	author: "XSD_GEN"
	generated: "2006/01/15 12:26:07.484"

class XFOCFG_SECTION_FACTORY

inherit

	XML_SHARED_FACTORY_TOOLS
	KL_IMPORTED_STRING_ROUTINES
	XM_NODE_PROCESSOR
		redefine
			process_element, process_attribute, process_character_data
		end

create

	make

feature {NONE} -- Initialization

	make is
		do
			-- First line is a comment
		end

	wipe_out is
		do
			page := Void
			margins := Void
			attribute_name := Void
		end

feature  -- Constants

	section_constants: XFOCFG_SECTION_CONSTANTS is
			-- XML Constants in element `section'
		once
			create Result
		end

feature  -- Basic operations

	new_section (p_element: XM_ELEMENT): like last_product is
			-- Create instance of type `XFOCFG_SECTION' from `p_element'.
		require
			p_element_not_void: p_element /= Void
			good_tag: STRING_.same_string (p_element.name, section_constants.t_section)
		do
			wipe_out
			p_element.process_children (Current)
			create_last_product
			fill_last_product
			Result := last_product
		ensure
			result_not_void: Result /= Void
		end

feature  -- Access

	last_product: XFOCFG_SECTION
			-- Last product of this factory.

	page: XFOCFG_PAGE
			-- Child entity for `page'.

	margins: XFOCFG_MARGINS
			-- Child entity for `margins'.

	attribute_name: STRING
			-- Attribute entity for `name'.

feature {NONE} -- Implementation

	process_element (p_element: XM_ELEMENT) is
			-- Process child element.
		do
			-- First line is a comment
			if STRING_.same_string (p_element.name, section_constants.t_page) then
				page := page_factory.new_page(p_element)
			elseif STRING_.same_string (p_element.name, section_constants.t_margins) then
				margins := margins_factory.new_margins(p_element)
			end
		end

	process_attribute (p_attribute: XM_ATTRIBUTE) is
			-- Process attribute element.
		do
			-- First line is a comment
			if STRING_.same_string (p_attribute.name, section_constants.a_name) then
				attribute_name := xml_tools.to_string(p_attribute.value)
			end
		end

	process_character_data (p_character_data: XM_CHARACTER_DATA) is
			-- Process character data.
		do
			-- First line is a comment
		end

	create_last_product is
			-- Create `last_product'.
		do
			create last_product
		end

	fill_last_product is
			-- Fill `last_product'.
		do
			last_product.set_page (page)
			last_product.set_margins (margins)
			last_product.set_attribute_name (attribute_name)
		end

feature {NONE} -- Factory

	page_factory: XFOCFG_PAGE_FACTORY is
			-- Factory for `page' elements.
		do
			create Result.make
		ensure
			page_factory_not_void: Result /= Void
		end

	margins_factory: XFOCFG_MARGINS_FACTORY is
			-- Factory for `margins' elements.
		do
			create Result.make
		ensure
			margins_factory_not_void: Result /= Void
		end

end -- class XFOCFG_SECTION_FACTORY
