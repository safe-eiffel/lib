indexing
	description:

		"Link destinations."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_DESTINATION

inherit
	FO_BORDER_STYLE
		rename
			set_style_none as set_border_none,
			set_style_dotted as set_border_dotted,
			set_style_dashed as set_border_dashed,
			set_style_dot_dashed as set_border_dot_dashed,
			set_style_solid as set_border_solid
		export
			{NONE} set_style_double
		end

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

invariant

	name_not_void: name /= Void
	name_not_empty: not name.is_empty

end
