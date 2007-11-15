indexing

	description: "Factory of XFOCFG_MARGINS objects."
	note: "Generated class; DO NOT MODIFY"
	author: "XSD_GEN"
	generated: "2006/01/15 12:26:06.671"

class XFOCFG_MARGINS_FACTORY

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
			attribute_left := Void
			attribute_right := Void
			attribute_bottom := Void
			attribute_top := Void
		end

feature  -- Constants

	margins_constants: XFOCFG_MARGINS_CONSTANTS is
			-- XML Constants in element `margins'
		once
			create Result
		end

feature  -- Basic operations

	new_margins (p_element: XM_ELEMENT): like last_product is
			-- Create instance of type `XFOCFG_MARGINS' from `p_element'.
		require
			p_element_not_void: p_element /= Void
			good_tag: STRING_.same_string (p_element.name, margins_constants.t_margins)
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

	last_product: XFOCFG_MARGINS
			-- Last product of this factory.

	attribute_left: STRING
			-- Attribute entity for `left'.

	attribute_right: STRING
			-- Attribute entity for `right'.

	attribute_bottom: STRING
			-- Attribute entity for `bottom'.

	attribute_top: STRING
			-- Attribute entity for `top'.

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
			if STRING_.same_string (p_attribute.name, margins_constants.a_left) then
				attribute_left := xml_tools.to_string(p_attribute.value)
			elseif STRING_.same_string (p_attribute.name, margins_constants.a_right) then
				attribute_right := xml_tools.to_string(p_attribute.value)
			elseif STRING_.same_string (p_attribute.name, margins_constants.a_bottom) then
				attribute_bottom := xml_tools.to_string(p_attribute.value)
			elseif STRING_.same_string (p_attribute.name, margins_constants.a_top) then
				attribute_top := xml_tools.to_string(p_attribute.value)
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
			last_product.set_attribute_left (attribute_left)
			last_product.set_attribute_right (attribute_right)
			last_product.set_attribute_bottom (attribute_bottom)
			last_product.set_attribute_top (attribute_top)
		end

feature {NONE} -- Factory

end -- class XFOCFG_MARGINS_FACTORY
