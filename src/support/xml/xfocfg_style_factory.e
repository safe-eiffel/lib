indexing

	description: "Factory of XFOCFG_STYLE objects."
	note: "Generated class; DO NOT MODIFY"
	author: "XSD_GEN"
	generated: "2006/01/15 12:26:09.812"

class XFOCFG_STYLE_FACTORY

inherit

	XML_SHARED_FACTORY_TOOLS
	KL_IMPORTED_STRING_ROUTINES
	XM_NODE_PROCESSOR
		redefine
			process_element, process_attribute, process_character_data
		end

creation

	make

feature {NONE} -- Initialization

	make is
		do
			-- First line is a comment
		end

	wipe_out is
		do
			margins := Void
			font := Void
			justification := Void
			attribute_name := Void
		end

feature  -- Constants

	style_constants: XFOCFG_STYLE_CONSTANTS is
			-- XML Constants in element `style'
		once
			create Result
		end

feature  -- Basic operations

	new_style (p_element: XM_ELEMENT): like last_product is
			-- Create instance of type `XFOCFG_STYLE' from `p_element'.
		require
			p_element_not_void: p_element /= Void
			good_tag: STRING_.same_string (p_element.name, style_constants.t_style)
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

	last_product: XFOCFG_STYLE
			-- Last product of this factory.

	margins: XFOCFG_MARGINS
			-- Child entity for `margins'.

	font: XFOCFG_FONT
			-- Child entity for `font'.

	justification: XFOCFG_JUSTIFICATION
			-- Child entity for `justification'.

	attribute_name: STRING
			-- Attribute entity for `name'.

feature {NONE} -- Implementation

	process_element (p_element: XM_ELEMENT) is
			-- Process child element.
		do
			-- First line is a comment
			if STRING_.same_string (p_element.name, style_constants.t_margins) then
				margins := margins_factory.new_margins(p_element)
			elseif STRING_.same_string (p_element.name, style_constants.t_font) then
				font := font_factory.new_font(p_element)
			elseif STRING_.same_string (p_element.name, style_constants.t_justification) then
				justification := justification_factory.new_justification(p_element)
			end
		end

	process_attribute (p_attribute: XM_ATTRIBUTE) is
			-- Process attribute element.
		do
			-- First line is a comment
			if STRING_.same_string (p_attribute.name, style_constants.a_name) then
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
			last_product.set_margins (margins)
			last_product.set_font (font)
			last_product.set_justification (justification)
			last_product.set_attribute_name (attribute_name)
		end

feature {NONE} -- Factory

	margins_factory: XFOCFG_MARGINS_FACTORY is
			-- Factory for `margins' elements.
		do
			create Result.make
		ensure
			margins_factory_not_void: Result /= Void
		end

	font_factory: XFOCFG_FONT_FACTORY is
			-- Factory for `font' elements.
		do
			create Result.make
		ensure
			font_factory_not_void: Result /= Void
		end

	justification_factory: XFOCFG_JUSTIFICATION_FACTORY is
			-- Factory for `justification' elements.
		do
			create Result.make
		ensure
			justification_factory_not_void: Result /= Void
		end

end -- class XFOCFG_STYLE_FACTORY
