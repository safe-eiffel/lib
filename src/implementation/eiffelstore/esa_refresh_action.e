indexing

	description:

		"Actions for PO_ADAPTER.refresh"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class ESA_REFRESH_ACTION

inherit

	ESA_ACTION
		redefine
			execute
		end

creation

	make
	
feature -- Basic operations

	execute is
		do
			adapter.execute_refresh_procedure (adapter.row)
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

end
