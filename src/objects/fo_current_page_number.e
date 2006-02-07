indexing
	description: 
	
		"Inlines whose text is the current page number."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"


class FO_CURRENT_PAGE_NUMBER

inherit
	FO_SPECIAL_INLINE

create
	make_inherit, make_with_font
	
feature -- Basic operations

	update_text (document: FO_DOCUMENT; region: FO_RECTANGLE) is
		do
			set_text (document.current_page_number.out)
		end

end

