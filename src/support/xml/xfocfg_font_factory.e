indexing

	description: "Factory of XFOCFG_FONT objects."
	note: "Generated class; DO NOT MODIFY"
	author: "XSD_GEN"
	generated: "2006/01/15 12:26:08.437"

class XFOCFG_FONT_FACTORY

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
			attribute_family := Void
			attribute_style := Void
			attribute_weight := Void
			attribute_size := Void
			attribute_stretch := Void
		end

feature  -- Constants

	font_constants: XFOCFG_FONT_CONSTANTS is
			-- XML Constants in element `font'
		once
			create Result
		end

feature  -- Basic operations

	new_font (p_element: XM_ELEMENT): like last_product is
			-- Create instance of type `XFOCFG_FONT' from `p_element'.
		require
			p_element_not_void: p_element /= Void
			good_tag: STRING_.same_string (p_element.name, font_constants.t_font)
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

	last_product: XFOCFG_FONT
			-- Last product of this factory.

	attribute_family: STRING
			-- Attribute entity for `family'.

	attribute_style: STRING
			-- Attribute entity for `style'.

	attribute_weight: STRING
			-- Attribute entity for `weight'.

	attribute_size: STRING
			-- Attribute entity for `size'.

	attribute_stretch: DOUBLE_REF
			-- Attribute entity for `stretch'.

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
			if STRING_.same_string (p_attribute.name, font_constants.a_family) then
				attribute_family := xml_tools.to_string(p_attribute.value)
			elseif STRING_.same_string (p_attribute.name, font_constants.a_style) then
				attribute_style := xml_tools.to_string(p_attribute.value)
			elseif STRING_.same_string (p_attribute.name, font_constants.a_weight) then
				attribute_weight := xml_tools.to_string(p_attribute.value)
			elseif STRING_.same_string (p_attribute.name, font_constants.a_size) then
				attribute_size := xml_tools.to_string(p_attribute.value)
			elseif STRING_.same_string (p_attribute.name, font_constants.a_stretch) then
				attribute_stretch := xml_tools.to_double(p_attribute.value)
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
			last_product.set_attribute_family (attribute_family)
			last_product.set_attribute_style (attribute_style)
			last_product.set_attribute_weight (attribute_weight)
			last_product.set_attribute_size (attribute_size)
			last_product.set_attribute_stretch (attribute_stretch)
		end

feature {NONE} -- Factory

end -- class XFOCFG_FONT_FACTORY
