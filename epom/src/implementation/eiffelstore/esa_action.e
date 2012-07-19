indexing

	description:

		"Actions for EIFFELSTORE_SIMPLE_ADAPTER"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class ESA_ACTION

inherit

	ACTION

feature -- Initialization

	make (an_adapter : like adapter) is
		require
			an_adapter_not_void: an_adapter /= Void
		do
			adapter := an_adapter
		ensure
			adapter_set: adapter = an_adapter
		end
		
feature -- Access

	adapter : EIFFELSTORE_SIMPLE_ADAPTER[PO_PERSISTENT]
	
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

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant

	adapter_not_void: adapter /= Void
	
end
