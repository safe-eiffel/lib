indexing

	description: "Objects isomorphic to 'document' elements"
	nota_bene: "Generated class : DO NOT EDIT!"
	generated: "2006/01/15 12:26:10.453"

class XFOCFG_DOCUMENT

create

	make

feature  -- Access

	section_collection: DS_LINKED_LIST[XFOCFG_SECTION]

	style_collection: DS_LINKED_LIST[XFOCFG_STYLE]

feature  -- Element change

feature {NONE} -- Initialization

	make is
		do
			create section_collection.make
			create style_collection.make
		end

invariant

	section_collection_exists: section_collection /= Void
	style_collection_exists: style_collection /= Void

end -- class XFOCFG_DOCUMENT
