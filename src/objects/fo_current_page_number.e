indexing
	description: "Objects that..."

	usage: ""
	quality: ""
	refactoring: ""

	status: "see notice at end of class";
	date: "$Date$";
	revision: "$Revision$";
	author: ""

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

