indexing
	description: "Common features of adapters using ECLI"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECLI_ADAPTER_COMMON_SKELETON[G->PO_PERSISTENT]

inherit
	PO_ADAPTER[G]
		undefine
			on_adapter_connected, on_adapter_disconnect
		end
			
	PO_SHARED_MANAGER
		export
			{NONE} all
		end
		
feature {NONE} -- Initialization

	make (a_datastore : ECLI_DATASTORE) is
			-- make using `datastore'
		require
			a_datastore_not_void: a_datastore /= Void
		do
			set_datastore (a_datastore)
			create cache.make (10)
			create last_cursor.make
		ensure
			datastore_set: a_datastore /= Void
			no_cache_on_write: not is_enabled_cache_on_write
		end

feature {PO_ADAPTER} -- Access

	last_object: G
		-- Last created object

	last_pid: PO_PID
		-- Last created pid

feature -- Access
	
	datastore: ECLI_DATASTORE
		-- current datastore

	last_cursor: PO_REFERENCE_LIST_CURSOR [G]
		-- Cursor the handles a linked list of PO_REFERENCE, i.e implementing load-on-demand of objects
		
feature -- Status report
		
	is_enabled_cache_on_write : BOOLEAN
			-- Are written objects inserted in cache ?

	is_enabled_cache_on_read : BOOLEAN
			-- Are read objects inserted in cache ?
			
feature -- Status setting
		
feature -- Measurement

	cache_count : INTEGER is
			-- Number of objects in cache.
		do
			Result := cache.count
		end

feature {PO_LAUNCHER} -- Element change

	set_datastore (a_datastore: ECLI_DATASTORE) is
		do
			datastore := a_datastore
			datastore.register_adapter (Current)
			if datastore.is_connected then
				on_adapter_connected
			end
		end
		
feature -- Basic operations

	exists (a_pid: like last_pid): BOOLEAN is
			-- Does an object identified by `a_pid' exist? Uses `Sql_exists'
		do
			create last_cursor.make
			last_object := Void
			
			check
				exists_cursor_not_void: exists_cursor /= Void
			end
			
			status.reset
			init_parameters_for_exists (a_pid)
			exists_cursor.execute
			if exists_cursor.is_ok then
				Result :=  exists_test (exists_cursor)
			end
			if not exists_cursor.is_ok then
				status.set_datastore_error (exists_cursor.native_code, exists_cursor.diagnostic_message)
			end
		end

	enable_cache_on_read is
		do
			is_enabled_cache_on_read := True
		end
		
	disable_cache_on_read is
		do
			is_enabled_cache_on_read := False
		end
		
	enable_cache_on_write is
		do 
			is_enabled_cache_on_write := True 
		end

	disable_cache_on_write is
		do 
			is_enabled_cache_on_write := True 
		end
	
feature {PO_ADAPTER} -- Basic operations

	create_pid_from_object (an_object: G) is
			-- Create `last_pid' based on the content of `an_object'
		deferred
		end

	init_parameters_for_exists (a_pid : like last_pid) is
			-- Initialize parameters of `Sql_exists' with information from `a_pid'
		deferred
		end

feature {PO_ADAPTER} -- Implementation

	query_error_message: STRING
			-- Error message associated with last error

	set_query_error_message (a_string : STRING) is
			-- set `query_error_message' to `a_string'
		require
			a_string_not_void: a_string /= Void
		do
			query_error_message := a_string		
		ensure
			query_error_message_set: query_error_message = a_string
		end

feature {PO_ADAPTER} -- Implementation
	
	exists_cursor : ECLI_CURSOR is
		deferred
		end

	exists_test (a_cursor : like exists_cursor) : BOOLEAN is
		require
			a_cursor_not_void: a_cursor /= Void
			a_cursor_executed: a_cursor.is_executed
			a_cursor_before: a_cursor.before
		deferred
		ensure
			a_cursor_after: a_cursor.after
		end
	
end -- class ECLI_ADAPTER_COMMON_SKELETON
