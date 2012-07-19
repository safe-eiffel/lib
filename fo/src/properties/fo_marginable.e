indexing

	description:

		"Objects that have margins"

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_MARGINABLE

inherit

	ANY
		redefine
			is_equal
		end

feature -- Access

	margins : FO_MARGINS assign set_margins

feature -- Element change

	set_margins (new_margins: FO_MARGINS) is
			-- Set `margins' to `new_margin'.
		require
			new_margin_not_void: new_margins /= Void
		do
			margins := new_margins
		ensure
			margins_assigned: margins = new_margins
		end

feature -- Comparison

	is_equal (other : like Current) : BOOLEAN is
		do
			Result := same_marginable (other)
		end

	same_marginable (other: like Current) : BOOLEAN is
		do
			Result := margins.is_equal (other.margins)
		end

invariant
	margins_exist: margins /= Void

end
