indexing

	description:

		"Objects that can be aligned, with different strategies if they are at the start or inside a collection, or as last element."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_ALIGNABLE

feature -- Access

	align: FO_ALIGNMENT

feature -- Element change

	set_align (a_align: FO_ALIGNMENT) is
			-- Set `align' to `a_align'.
		require
			a_align_not_void: a_align /= Void
		do
			align := a_align
		ensure
			align_assigned: align = a_align
		end

invariant

	align_not_void: align /= Void

end
