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
			session : ECLI_SESSION
			simple_login : ECLI_SIMPLE_LOGIN
			manager : PO_MANAGER_IMPL
		do
			create session.make_default
			create simple_login.make("books", "","")
			session.set_login_strategy (simple_login)
			create store.make (session)
			store.connect
			verify_table_existence
			if not table_exists then
				create_table
			end
			if table_exists then
				create manager.make
				set_manager (manager)
				if store.is_connected then
					create {BOOK_ADAPTER_ECLI}book_adapter.make (store)
					book_adapter.enable_cache_on_write
					book_adapter.enable_cache_on_read
					pom.add_adapter (book_adapter)
					create {BORROWER_ADAPTER_ECLI}borrower_adapter.make (store)
					pom.add_adapter (borrower_adapter)
					create {COPY_ADAPTER_ECLI}copy_adapter.make (store)
					pom.add_adapter (copy_adapter)
					is_persistence_framework_initialized := True
				else
					print ("Error connecting to database%N")
				end			
			end
		end
		
feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	verify_table_existence is
		local
			cursor : ECLI_TABLES_CURSOR
			criteria : ECLI_NAMED_METADATA
		do
			create criteria.make (Void, Void, "book")
			create cursor.make (criteria, store.session)
			from
				cursor.start
			until
				cursor.off
			loop
				table_exists := True
				cursor.forth
			end
		end
		
	table_exists : BOOLEAN
	
	create_table is
		local
			ddl : ECLI_STATEMENT
		do
			create ddl.make (store.session)
			ddl.set_sql ("create table COPY (%
				% isbn varchar(14),%
				% serial_number integer,%
				% loc_store integer,%
				% loc_shelf integer,%
				% loc_row integer,%
				% borrower integer)")
			ddl.execute
			if ddl.is_ok then
				ddl.set_sql ("create table BORROWER (%
					% id integer,%
					% name varchar (30),%
					% address varchar (50))")
				ddl.execute
				if ddl.is_ok then
					ddl.set_sql ("create table BOOK (%
						% isbn varchar(14),%
						% title varchar(100),%
						% author varchar(30))")
					ddl.execute
					if ddl.is_ok then
						table_exists := True
					else
						print ("could not create table BOOK : " + ddl.diagnostic_message + "%N")
					end
				else
					print ("could not create table BORROWER : "+ ddl.diagnostic_message + "%N")
				end
			else
				print ("could not create table COPY : " + ddl.diagnostic_message + "%N")
			end
		end
		
	
	
		
	pom : PO_MANAGER is do Result := persistence_manager end

	store : ECLI_DATASTORE

end
