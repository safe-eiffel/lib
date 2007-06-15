indexing
	description: "Link destinations."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	FO_DESTINATION

inherit
	FO_BORDER_STYLE

create
	make, make_uri

feature {NONE} -- Initialization

	make (new_name : STRING) is
		require
			new_name_not_void: new_name /= Void
			name_not_empty: not new_name.is_empty
		do
			name := new_name
		ensure
			name_set: name = new_name
		end

	make_uri (new_uri : UT_URI) is
		require
			new_uri_not_void: new_uri /= Void
		do
			name := new_uri.full_reference
		ensure
			name_set: name.is_equal (new_uri.full_reference)
		end

feature -- Access

	name : STRING
			-- Name to be referenced.

feature -- Element change

	set_border_none is
		do
			style := style_none
		end

	set_border_dashed is
		do
			style := style_dashed
		end

	set_border_dot_dashed is
		do
			style := style_dot_dash
		end

	set_border_dotted is
		do
			style := style_dotted
		end
		
invariant

	name_not_void: name /= Void
	name_not_empty: not name.is_empty

end
