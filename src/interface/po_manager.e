indexing
	description: "Objects that are brokers for persistence adapters."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PO_MANAGER

inherit
	PO_STATUS_USE
	PO_STATUS_MANAGEMENT

feature -- Access

	last_adapter : PO_ADAPTER [PO_PERSISTENT]
			-- last adapter found by `search_adapter'

	adapters : DS_LIST[PO_ADAPTER[PO_PERSISTENT]] is
			-- known adapters
		deferred
		end
		
feature -- Measurement

	count : INTEGER is
			-- number of known adapters
		deferred
		end
		
feature -- Status report
	
	found : BOOLEAN is
			-- has the last search_adapter operation succeeded ?
		deferred
		ensure
			status: not Result implies status.is_error
		end

	has_adapter (class_name : STRING) : BOOLEAN is
			-- has the POM an adapter for  `class_name'?
		require
			class_name_not_void: class_name /= Void
		deferred
		ensure
			side_effect: Result implies (last_adapter /= Void and then last_adapter.class_name.is_equal (class_name))
		end
		
feature {PO_LAUNCHER} -- Status setting

	add_adapter (an_adapter : PO_ADAPTER[PO_PERSISTENT]) is
			-- add `an_adapter'
		require
			adapter_not_void: an_adapter /= Void
			no_adapter_for_class: not has_adapter (an_adapter.class_name)
		deferred
		ensure
			registered: has_adapter (an_adapter.class_name) and then last_adapter = an_adapter
		end
		
feature -- Basic operations

	search_adapter (class_name : STRING) is
			-- search of adapter for class of `class_name'
		require
			class_name_not_void: class_name /= Void
		deferred
		ensure
			found_definition : found implies (last_adapter /= Void and then last_adapter.class_name.is_equal (class_name))
		end

invariant

	adapters_collection_not_void: adapters /= Void
	
end -- class PO_MANAGER
