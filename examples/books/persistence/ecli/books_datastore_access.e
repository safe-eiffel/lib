indexing
	description: "Access to persistence related objects of the BOOKS datastore"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	BOOKS_DATASTORE_ACCESS

inherit
	
	PO_SHARED_MANAGER 
	PO_LAUNCHER
	
feature {BOOKS_DATASTORE_ACCESS} -- Access

	book_adapter : BOOK_ADAPTER
	copy_adapter : COPY_ADAPTER
	borrower_adapter : BORROWER_ADAPTER

feature -- Status report

	is_persistence_framework_initialized : BOOLEAN
	
feature -- Basic operations

	initialize_persistence_framework is
		require
			not_initialized: not is_persistence_framework_initialized
		local
			adapter : PO_ADAPTER[PO_PERSISTENT]
			session : ECLI_SESSION
			manager : PO_MANAGER_IMPL
		do
			create session.make ("books", "","")
			create store.make (session)
			store.connect
			create manager.make
			set_manager (manager)
			if store.is_connected then
				create {BOOK_ADAPTER_ECLI}book_adapter.make (store)
				pom.add_adapter (book_adapter)
				create {BORROWER_ADAPTER_ECLI}borrower_adapter.make (store)
				pom.add_adapter (borrower_adapter)
				create {COPY_ADAPTER_ECLI}copy_adapter.make (store)
				pom.add_adapter (copy_adapter)
				is_persistence_framework_initialized := True
			else
				print ("Error connecting to database")
			end			
		end
		
feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	pom : PO_MANAGER is do Result := persistence_manager end

	store : ECLI_DATASTORE
	
invariant
	invariant_clause: True -- Your invariant here

end -- class BOOKS_DATASTORE_ACCESS
