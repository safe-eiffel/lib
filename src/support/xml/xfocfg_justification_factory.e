indexing

	description: "Factory of XFOCFG_JUSTIFICATION objects."
	note: "Generated class; DO NOT MODIFY"
	author: "XSD_GEN"
	generated: "2006/01/15 12:26:09.078"

class XFOCFG_JUSTIFICATION_FACTORY

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
			attribute_value := Void
		end

feature  -- Constants

	justification_constants: XFOCFG_JUSTIFICATION_CONSTANTS is
			-- XML Constants in element `justification'
		once
			create Result
		end

feature  -- Basic operations

	new_justification (p_element: XM_ELEMENT): like last_product is
			-- Create instance of type `XFOCFG_JUSTIFICATION' from `p_element'.
		require
			p_element_not_void: p_element /= Void
			good_tag: STRING_.same_string (p_element.name, justification_constants.t_justification)
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

	last_product: XFOCFG_JUSTIFICATION
			-- Last product of this factory.

	attribute_value: STRING
			-- Attribute entity for `value'.

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
			if STRING_.same_string (p_attribute.name, justification_constants.a_value) then
				attribute_value := xml_tools.to_string(p_attribute.value)
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
			last_product.set_attribute_value (attribute_value)
		end

feature {NONE} -- Factory

end -- class XFOCFG_JUSTIFICATION_FACTORY
