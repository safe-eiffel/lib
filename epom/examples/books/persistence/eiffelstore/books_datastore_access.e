indexing

	description:

		"Access to persistence related objects of the BOOKS datastore"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class BOOKS_DATASTORE_ACCESS

inherit

	PO_SHARED_MANAGER 
	PO_LAUNCHER
	DATABASE_APPL[ODBC]
	
	--store_ecli: DATABASE_APPLICATION
	
feature {BOOKS_DATASTORE_ACCESS} -- Access

	book_adapter : BOOK_ADAPTER
	copy_adapter : COPY_ADAPTER
	borrower_adapter : BORROWER_ADAPTER

feature -- Status report

	is_persistence_framework_initialized : BOOLEAN
	
feature -- Basic operations

	initialize_persistence_framework is
			-- 
		require
			not_initialized: not is_persistence_framework_initialized
		local
			session : DB_CONTROL
			manager : PO_MANAGER_IMPL
		do
			set_data_source ("books")
			login ("","")
			set_base
			create session.make
			create store.make
			store.connect
			create manager.make
			set_manager (manager)
			if store.is_connected then
				create {BOOK_ADAPTER_EIFFELSTORE}book_adapter.make (store)
				book_adapter.enable_cache_on_write
				pom.add_adapter (book_adapter)
				create {BORROWER_ADAPTER_EIFFELSTORE}borrower_adapter.make (store)
				pom.add_adapter (borrower_adapter)
				borrower_adapter.enable_cache_on_write
				create {COPY_ADAPTER_EIFFELSTORE}copy_adapter.make (store)
				pom.add_adapter (copy_adapter)
				copy_adapter.enable_cache_on_write
				is_persistence_framework_initialized := True
			else
				print ("Error connecting to database")
			end			
		end
		
feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	pom : PO_MANAGER is do Result := persistence_manager end

	store : EIFFELSTORE_DATASTORE
	
invariant

	invariant_clause: True -- Your invariant here

end
