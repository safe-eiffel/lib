indexing
	description: "Objects that can be aligned, with different strategies if they are at the start or inside a collection, or as last element."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	FO_ALIGN_ABLE

feature -- Access

	align_last: FO_ALIGNMENT

	align: FO_ALIGNMENT

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	set_align_last (a_align_last: FO_ALIGNMENT) is
			-- Set `align_last' to `a_align_last'.
		require
			a_align_last_not_void: a_align_last /= Void
		do
			align_last := a_align_last
		ensure
			align_last_assigned: align_last = a_align_last
		end

	set_align (a_align: FO_ALIGNMENT) is
			-- Set `align' to `a_align'.
		require
			a_align_not_void: a_align /= Void
		do
			align := a_align
		ensure
			align_assigned: align = a_align
		end

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here
	align_not_void: align /= Void
	align_last_not_void: align_last /= Void

end -- class FO_ALIGN_ABLE
