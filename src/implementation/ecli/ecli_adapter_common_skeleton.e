indexing

	description:

		"Common features of adapters using ECLI"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class ECLI_ADAPTER_COMMON_SKELETON[G->PO_PERSISTENT]

inherit

	PO_ADAPTER[G]
		undefine
			on_adapter_connected, on_adapter_disconnect
		redefine
			error_handler
		end

	PO_SHARED_MANAGER
		export
			{NONE} all
		end

	PO_CACHE_USE [G]

feature {NONE} -- Initialization

	make (a_datastore : ECLI_DATASTORE) is
			-- Make using `datastore'.
		require
			a_datastore_not_void: a_datastore /= Void
		do
			set_datastore (a_datastore)
			create {PO_HASHED_CACHE[G]}cache.make (10)
			create last_cursor.make
			create_error_handler
		ensure
			datastore_set: a_datastore /= Void
		end

	make_with_cache (a_datastore : ECLI_DATASTORE; a_cache : PO_CACHE[G]) is
			-- Make using `a_datastore' and `a_cache'.
		require
			a_datastore_not_void: a_datastore /= Void
			a_cache_not_void: a_cache /= Void
		do
			set_datastore (a_datastore)
			cache := a_cache
			create last_cursor.make
			create_error_handler
		ensure
			datastore_set: datastore = a_datastore
			cache_set: cache = a_cache
		end

feature -- Access

	error_handler : PO_ECLI_ERROR_HANDLER is
		deferred
		end

feature {PO_ADAPTER, PO_CURSOR, PO_REFERENCE, PO_PERSISTENT, PO_REFERENCE_ACCESS} -- Framework - Access

	last_pid: PO_PID
		-- Last created pid

feature {PO_ADAPTER} -- Framework - Access

	last_object: G
		-- Last created object

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
			datastore.register_adapter (as_adapter_persistent)
			if datastore.is_connected then
				on_adapter_connected
			end
		end

feature -- Basic operations

	exists (a_pid: PO_PID): BOOLEAN is
			-- Does an object identified by `a_pid' exist? Uses `Sql_exists'.
		local
			pid_like_last_pid : like last_pid
		do
			create last_cursor.make
			last_object := default_value

			check
				exists_cursor_not_void: exists_cursor /= Void
			end

			status.reset
			pid_like_last_pid ?= a_pid
			if pid_like_last_pid /= Void then
				init_parameters_for_exists (pid_like_last_pid)
				exists_cursor.execute
				if exists_cursor.is_ok then
					Result :=  exists_test (exists_cursor)
				end
				if not exists_cursor.is_ok then
					status.set_datastore_error (exists_cursor.native_code, exists_cursor.diagnostic_message)
					error_handler.report_datastore_error (generator, "exists", exists_cursor.native_code, exists_cursor.diagnostic_message)
				end
			else
				status.set_framework_error (status.error_non_conformant_pid)
				error_handler.report_non_conformant_pid (generator, "exists", "[like last_pid]", a_pid.generator)
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
			is_enabled_cache_on_write := False
		end

feature {NONE} -- Framework - Basic operations

	create_error_handler is
			-- Create `error_handler'.
		deferred
		ensure
			error_handler_not_void: error_handler /= Void
		end

	init_parameters_for_exists (a_pid : like last_pid) is
			-- Initialize parameters of `Sql_exists' with information from `a_pid'.
		require
			a_pid_not_void: a_pid /= Void
		deferred
		end

feature {NONE} -- Implementation

	query_error_message: STRING is
			-- Error message associated with last error
		obsolete
			"[2007-04-17]"
		do
		end

	set_query_error_message (a_string : STRING) is
			-- Set `query_error_message' to `a_string'.
		obsolete
			"[2007-04-17] Use `error_handler'.report_datastore_error"
		require
			a_string_not_void: a_string /= Void
		do
			error_handler.report_datastore_error (generator, "", 0, a_string)
		end

feature {NONE} -- Framework - Access

	exists_cursor : ECLI_CURSOR is
		deferred
		end

feature {NONE} -- Framework - Status report

	exists_test (a_cursor : like exists_cursor) : BOOLEAN is
		require
			a_cursor_not_void: a_cursor /= Void
			a_cursor_executed: a_cursor.is_executed
			a_cursor_before: a_cursor.before
		deferred
		ensure
			a_cursor_after: a_cursor.after
		end

	default_value : G is do  end

end
