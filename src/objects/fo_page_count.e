indexing
	description: 
	
		"Inlines whose current text represent the total pages count in a document."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class FO_PAGE_COUNT

inherit
	FO_SPECIAL_INLINE

create
	make_inherit, make_with_font

feature -- Basic operations

	update_text (document: FO_DOCUMENT; region: FO_RECTANGLE) is
		do
			set_text (document.page_count.out)
		end
		
end


