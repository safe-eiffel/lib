indexing

	description: "Factory of XFOCFG_PAGE objects."
	nota_bene: "Generated class; DO NOT MODIFY"
	author: "XSD_GEN"
	generated: "2006/01/15 12:26:05.843"

class XFOCFG_PAGE_FACTORY

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
			attribute_height := Void
			attribute_width := Void
			attribute_orientation := Void
		end

feature  -- Constants

	page_constants: XFOCFG_PAGE_CONSTANTS is
			-- XML Constants in element `page'
		once
			create Result
		end

feature  -- Basic operations

	new_page (p_element: XM_ELEMENT): like last_product is
			-- Create instance of type `XFOCFG_PAGE' from `p_element'.
		require
			p_element_not_void: p_element /= Void
			good_tag: STRING_.same_string (p_element.name, page_constants.t_page)
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

	last_product: XFOCFG_PAGE
			-- Last product of this factory.

	attribute_height: STRING
			-- Attribute entity for `height'.

	attribute_width: STRING
			-- Attribute entity for `width'.

	attribute_orientation: STRING
			-- Attribute entity for `orientation'.

feature {NONE} -- Implementation

	process_element (p_element: XM_ELEMENT) is
			-- Process child element.
		do
			-- First line is a comment
		end

	process_attribute (p_attribute: XM_ATTRIBUTE) is
			-- Process attribute element.
		do
			-- First line is a comment
			if STRING_.same_string (p_attribute.name, page_constants.a_height) then
				attribute_height := xml_tools.to_string(p_attribute.value)
			elseif STRING_.same_string (p_attribute.name, page_constants.a_width) then
				attribute_width := xml_tools.to_string(p_attribute.value)
			elseif STRING_.same_string (p_attribute.name, page_constants.a_orientation) then
				attribute_orientation := xml_tools.to_string(p_attribute.value)
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
			last_product.set_attribute_height (attribute_height)
			last_product.set_attribute_width (attribute_width)
			last_product.set_attribute_orientation (attribute_orientation)
		end

feature {NONE} -- Factory

end -- class XFOCFG_PAGE_FACTORY
