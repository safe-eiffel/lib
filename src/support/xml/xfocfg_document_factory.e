indexing

	description: "Factory of XFOCFG_DOCUMENT objects."
	note: "Generated class; DO NOT MODIFY"
	author: "XSD_GEN"
	generated: "2006/01/15 12:26:10.593"

class XFOCFG_DOCUMENT_FACTORY

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
			create section_collection.make
			create style_collection.make
		end

	wipe_out is
		do
			section_collection.wipe_out
			style_collection.wipe_out
		end

feature  -- Constants

	document_constants: XFOCFG_DOCUMENT_CONSTANTS is
			-- XML Constants in element `document'
		once
			create Result
		end

feature  -- Basic operations

	new_document (p_element: XM_ELEMENT): like last_product is
			-- Create instance of type `XFOCFG_DOCUMENT' from `p_element'.
		require
			p_element_not_void: p_element /= Void
			good_tag: STRING_.same_string (p_element.name, document_constants.t_document)
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

	last_product: XFOCFG_DOCUMENT
			-- Last product of this factory.

	section_collection: DS_LINKED_LIST[XFOCFG_SECTION]
			-- Child entity for `section'.

	style_collection: DS_LINKED_LIST[XFOCFG_STYLE]
			-- Child entity for `style'.

feature {NONE} -- Implementation

	process_element (p_element: XM_ELEMENT) is
			-- Process child element.
		do
			-- First line is a comment
			if STRING_.same_string (p_element.name, document_constants.t_section) then
				section_collection.put_last (section_factory.new_section(p_element))
			elseif STRING_.same_string (p_element.name, document_constants.t_style) then
				style_collection.put_last (style_factory.new_style(p_element))
			end
		end

	process_attribute (p_attribute: XM_ATTRIBUTE) is
			-- Process attribute element.
		do
			-- First line is a comment
		end

	process_character_data (p_character_data: XM_CHARACTER_DATA) is
			-- Process character data.
		do
			-- First line is a comment
		end

	create_last_product is
			-- Create `last_product'.
		do
			create last_product.make
		end

	fill_last_product is
			-- Fill `last_product'.
		do
			last_product.section_collection.copy (section_collection)
			last_product.style_collection.copy (style_collection)
		end

feature {NONE} -- Factory

	section_factory: XFOCFG_SECTION_FACTORY is
			-- Factory for `section' elements.
		do
			create Result.make
		ensure
			section_factory_not_void: Result /= Void
		end

	style_factory: XFOCFG_STYLE_FACTORY is
			-- Factory for `style' elements.
		do
			create Result.make
		ensure
			style_factory_not_void: Result /= Void
		end

invariant

	section_collection_not_void: section_collection /= Void
	style_collection_not_void: style_collection /= Void

end -- class XFOCFG_DOCUMENT_FACTORY
