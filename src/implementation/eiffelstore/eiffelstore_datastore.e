indexing

	description:

		"EiffelStore implementation of PO_DATASTORE."

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class EIFFELSTORE_DATASTORE

inherit

	PO_DATASTORE

	HANDLE_USE
		export 
			{NONE} all 
		end
		
creation

	make
	
feature {NONE} -- Initialization

	make is
		do
			create adapters_impl.make
		ensure
			adapters_not_void: adapters /= Void and then adapters.is_empty
		end
		
feature -- Access	

	adapters : DS_LIST[PO_ADAPTER [PO_PERSISTENT]] is
			-- 
		do
			Result := adapters_impl
		end
	
feature -- Measurement

feature -- Status report

	can_begin_transaction: BOOLEAN
		
	is_error: BOOLEAN is
			-- 
		do Result := not control.is_ok end
	
	valid_connection_parameters: BOOLEAN is
			-- 
		do
			Result := handle.login.data_source /= Void and handle.login.name /= Void and handle.login.passwd /= Void
		end

	is_connected : BOOLEAN is
		do
			Result := control.is_connected
		end
		
feature -- Status setting

feature -- Cursor movement

feature -- Element change

--	set_connection_parameters (a_datasource, a_user, a_password : STRING) is
--			-- 
--		require
--			a_datasource /= Void
--			a_user /= Void
--			a_password /= Void
--		do
--			--data_source := a_datasource
--			--user := a_user
--			--password := a_password
--			set_data_source (a_datasource)
--			login (a_user, a_password)
--		ensure
--			data_source_set: equal (session_login.data_source, a_datasource)
--			user_set: equal (session_login.name, a_user)
--			password_set: equal (session_login.passwd, a_password)	
--		end
		
feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	begin_transaction is
			-- 
		do
			control.begin
			transaction_level := transaction_level + 1
		end
		
	commit_transaction is
			-- 
		do
			control.commit
			transaction_level := transaction_level - 1
		end
		
	connect is
			-- 
		do
			control.connect
			transaction_level := transaction_level - 1
		end
		
	disconnect is
			-- 
		do
			control.disconnect
		end
		
	rollback_transaction is
			-- 
		do
			control.rollback
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	control : DB_CONTROL is
			-- 
		once
			!!Result.make
		end

	adapters_impl : DS_LINKED_LIST[PO_ADAPTER[PO_PERSISTENT]]
	

end
