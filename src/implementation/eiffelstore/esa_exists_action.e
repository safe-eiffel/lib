indexing

	description:

		"Actions for EIFFELSTORE_SIMPLE_ADAPTER.exists"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class ESA_EXISTS_ACTION

inherit

	ESA_ACTION
		redefine
			execute
		end

create

	make
	
feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	execute is
		do
			adapter.execute_exists_procedure (adapter.row, adapter.last_object)
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant

	invariant_clause: True -- Your invariant here

end
