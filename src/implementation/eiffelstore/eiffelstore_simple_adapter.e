indexing

	description:

		"EiffelStore partial implementation of PO_ADAPTERs.%N%
	 % %N%
	 % Caches all read objects until `clear_cache' is called.%N%
	 % When `is_enabled_cache_on_write' is True then written object%N%
	 % also are inserted in the cache."
		
	author: "Paul G. Crismer"
	
	usage: "%N%
	%	* Inherit from it.%N% 
	%	* Implement deferred features. %N%
	%	* Redefine `last_pid'.%N%
	%	%N%
	%	Implement any other access (query) on objects.%N%
	%	Features `read_one' and `read_object_collection' can be used as facility routines for%N%
	%	exact-match or multiple-match queries, respectively."

	date: "$Date$"
	revision: "$Revision$"

deferred class EIFFELSTORE_SIMPLE_ADAPTER[G->PO_PERSISTENT]

inherit

	PO_ADAPTER[G]
		
	PO_SHARED_MANAGER

	ACTION
		rename
			status as action_status
		export
			{NONE} all
		redefine
			execute
		end
		
	DB_STATUS_USE
		rename 
			is_ok as query_ok
		end
		
feature {NONE} -- Initialization

	make (a_datastore : PO_DATASTORE) is
			-- make using `datastore'
		require
			a_datastore_not_void: a_datastore /= Void
		do
			datastore ?= a_datastore
			!! change.make
			!! selection.make
			!!cache.make (10)
			create last_cursor.make
			create_row
			create_pid_row
			datastore.register_adapter (Current)
		ensure
			datastore_set: a_datastore /= Void
			row_not_void:    row /= Void
			pid_row_not_void: pid_row /= Void
			no_cache_on_write: not is_enabled_cache_on_write
		end

feature {PO_ADAPTER, ESA_ACTION} -- Access

	last_object: G
		-- Last created object

	last_pid: PO_PID
		-- Last created pid

feature -- Access
	
	datastore: EIFFELSTORE_DATASTORE
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

	set_datastore (a_datastore: EIFFELSTORE_DATASTORE) is
		do
			datastore := a_datastore
			datastore.register_adapter (Current)
			if datastore.is_connected then
				on_adapter_connected
			end
		end
		
feature -- Basic operations

--	exists (a_pid: like last_pid): BOOLEAN is
--			-- Does an object identified by `a_pid' exist? Uses `Sql_exists'
--		do
--			last_object := Void
--			check
--				exists_cursor_not_void: exists_cursor /= Void
--			end
--			status.reset
--			init_parameters_for_exists (a_pid)
--			exists_cursor.execute
--			exists_cursor.start
--			if exists_cursor.is_ok then
--				if not exists_cursor.off then
--					if exists_value > 0 then
--						Result := True
--					end
--				end
--				status.reset
--			else
--				status.set_datastore_error (exists_cursor.native_code, exists_cursor.diagnostic_message)
--			end
--		end

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

feature -- Access

feature {PO_ADAPTER, ESA_ACTION} -- Access

	row : ANY is
			-- Virtual row for objects : exact match queries
		deferred
		end

	pid_row : ANY is
			-- Virtual row for pids : multiple match queries
		deferred
		end
			
feature {PO_ADAPTER} -- Access

	Sql_exists : STRING is
			-- SQL query for 'exists'
		 deferred 
		 end
		
	Sql_read : STRING  is
			-- SQL query for 'read'
		 deferred 
		 end

	Sql_refresh : STRING  is
			-- SQL query for 'refresh'
		 deferred 
		 end

	Sql_update : STRING  is
			-- SQL query for 'update'
		 deferred 
		 end

	Sql_write : STRING is
			-- SQL query for 'write'
		 deferred 
		 end

	Sql_delete : STRING is
			-- SQL query for 'delete'
		 deferred 
		 end

feature -- Status report

--	error_code : INTEGER

--	error_meaning : STRING is
--			-- Human readable meaning for current `error_code'
--		do
--			!!Result.make(0)
--			Result.append (po_error_meaning (error_code))
--			if error_code = Po_error_query_failed then
--				Result.append ("%N")
--				Result.append (query_error_message)
--			end
--		end

feature -- Status setting
		
feature -- Measurement

feature -- Basic operations

	create_pid_from_object (an_object: G) is
			-- Create `last_pid' based on the content of `an_object'
		deferred
		end

	exists (pid: like last_pid): BOOLEAN is
			-- Does an object identified by `pid' exist? Uses `Sql_exists'
		do
			status.reset
			create selection.make
			init_parameters_for_exists (pid)
			selection.query (Sql_exists)
			if selection.is_ok then
				selection.set_action (Current)
				current_action := Action_exists
				execute_agent := create {ESA_EXISTS_ACTION}.make (Current) --agent execute_exists_procedure (row, last_object)
				selection.load_result
				Result := exists_count > 0
				status.reset
				selection.terminate
			else
				status.set_datastore_error (error_code, error_message) --) row_cursor.native_code, row_cursor.diagnostic_message)
			end
--			if not selection.is_allocatable then selection.terminate end
		end

	read (pid: like last_pid) is
			-- Read an object identified by `pid'.  Uses `Sql_read'
		do
			last_object := Void
			create last_cursor.make
			status.reset
			if is_enabled_cache_on_read or else is_enabled_cache_on_write then
				cache.search (pid.to_string)
				if cache.found then
					last_cursor.add_object (cache.found_item)
				end
			end
			if not (is_enabled_cache_on_read or else is_enabled_cache_on_write) or else not cache.found then
				create selection.make
				init_parameters_for_read (pid)
				selection.query (Sql_read)
				if selection.is_ok then
					execute_agent := create {ESA_READ_ACTION}.make (Current) --agent execute_read_procedure(row, last_object)
					selection.set_action (execute_agent)
					last_object := Void
					selection.object_convert (row)
					selection.load_result
					if last_object /= Void then
						last_object.set_pid (pid)
						if is_enabled_cache_on_read then
							cache.force (last_object, pid.to_string)
						end
						last_cursor.add_object (last_object)
					else
						status.set_framework_error (status.error_could_not_create_object)
					end
				else
					status.set_datastore_error (error_code, error_message) --) row_cursor.native_code, row_cursor.diagnostic_message)
				end
				if not selection.is_allocatable then selection.terminate end
			end
		end

	refresh (object: like last_object) is
			-- Refresh `object'.  Uses `Sql_refresh'
		do 
			last_object := Void
			
			status.reset
			last_pid ?= object.pid
			last_object := object
			create selection.make
			if last_pid /= Void then
				init_parameters_for_refresh (last_pid)
				selection.query (Sql_refresh)
				if selection.is_ok then
					selection.set_action (Current)
					current_action := Action_refresh
					execute_agent := create {ESA_REFRESH_ACTION}.make (Current) -- agent execute_refresh_procedure (row)
					selection.load_result
				else
					status.set_datastore_error (error_code, error_message)--row_cursor.native_code, row_cursor.diagnostic_message)
				end
				if not selection.is_allocatable then selection.terminate end
--				row_cursor.close
			else
				status.set_framework_error (status.error_non_conformant_pid)
			end		
		end

	delete (object: like last_object) is
			-- Delete `object' from datastore.  Uses `Sql_delete'
		do  
			last_object := Void
			
			current_action := Action_none
			status.reset
			last_pid ?= object.pid
			last_object := object
			create change.make
			if last_pid /= Void then
				init_parameters_for_delete (last_pid)
				change.modify (sql_delete)
				if change.is_ok then
					status.reset
				else
					status.set_datastore_error (error_code, error_message)--row_cursor.native_code, row_cursor.diagnostic_message)
				end
			else
				status.set_framework_error (status.error_non_conformant_pid)
			end
		end

	update (object: like last_object) is
			-- Update `object' on datastore. Uses `Sql_update'
		do  
			current_action := Action_none
			last_object := Void
			
			status.reset
			create change.make
			if object.is_volatile then
				create_pid_from_object (object)
			else
				last_pid ?= object.pid
			end
			last_object := object
			if last_pid /= Void then
				init_parameters_for_update (object, last_pid)
				change.modify (sql_update)
				if change.is_ok then
					object.set_pid (last_pid)
				else
					--| query failed
					status.set_datastore_error (error_code, error_message)--row_cursor.native_code, row_cursor.diagnostic_message)
				end
			else
				--| non_conformant_pid 
				status.set_framework_error (status.error_non_conformant_pid)
			end		
		end

	write (object: like last_object) is
			-- Write `object' on datastore. Uses `Sql_write'
		do
			current_action := Action_none
			last_object := Void
			
			status.reset
			create_pid_from_object (object)
			last_object := object
			create change.make
			if last_pid /= Void then
				init_parameters_for_write (object, last_pid)
				change.modify (Sql_write)
				if change.is_ok then
					object.set_pid (last_pid)
					if is_enabled_cache_on_write then
						cache.force (last_object, last_pid.to_string)
					end
				else
					status.set_datastore_error (error_code, error_message)--row_cursor.native_code, row_cursor.diagnostic_message)
				end
			else
				status.set_framework_error (status.error_non_conformant_pid)
			end		
		end

	
feature {PO_ADAPTER} -- Basic operations

	init_parameters_for_exists (pid : like last_pid) is
			-- Initialize parameters of `Sql_exists' with information from `pid'
		deferred
		end

	init_parameters_for_read (pid : like last_pid) is
			-- Initialize parameters of `Sql_read' with information from `pid'
		deferred
		end

	init_parameters_for_refresh (pid : like last_pid) is
			-- Initialize parameters of `Sql_refresh' with information from `pid'
		deferred
		end

	init_parameters_for_delete (pid : like last_pid) is
			-- Initialize parameters of `Sql_delete' with information from `pid'
		deferred
		end

	init_parameters_for_write (object : like last_object; pid : like last_pid) is
			-- Initialize parameters of `Sql_write' with information from `object' and `pid'
		deferred
		end

	init_parameters_for_update (object : like last_object; pid : like last_pid) is
			-- Initialize parameters of `Sql_update' with information from `object' and `pid'
		deferred
		end

	create_object_from_row is
			-- Create object and just ensure invariant

		require
			last_object_void: last_object = Void
			row_not_void: row /= Void
		deferred
		ensure
			adapted_count: last_object /= Void
		end

	create_pid_from_pid_row is
			-- Create `last_object' and just ensure invariant

		require
			last_pid_void: last_pid = Void
			row_not_void: row /= Void
		deferred
		ensure
			adapted_count: last_pid /= Void
		end

	create_row is
			-- Create `row' object
		deferred
		ensure
			row_not_void: row /= Void
		end
		
	create_pid_row is
			-- Create `pid_row' object
		deferred
		ensure
			pid_row_not_void: pid_row /= Void
		end
		
	create_cursor is
			-- Create cursor on result-set
		do
			create last_cursor.make
		end
		
	add_pid_to_cursor is
			-- Extend last_cursor with a PO_REFERENCE p, with p.pid initialized to `last_pid'
		local
			ref : PO_REFERENCE[G]
		do
			create ref
			ref.set_pid_from_adapter (Current)
			last_cursor.add_reference (ref)
		end
		
	add_object_to_cursor is
			-- Extend last_cursor with a PO_REFERENCE p, with p.pid initialized to `last_pid'
		local
			ref : PO_REFERENCE[G]
		do
			create ref
			ref.set_item (last_object)
			last_cursor.add_reference (ref)
		end

	fill_object_from_row is
			-- Fill `last_object' using `row' content
		require
			row_not_void: row /= Void
			last_object_not_void: last_object /= Void
		deferred
		end

	read_one (sql : STRING) is 
			-- Exact-match reading facility.  Calls `create_object_from_row', `fill_object_from_row' for the result.
		do
			status.reset
			selection.query (sql)
			if selection.is_ok then
				selection.set_action (Current)
				current_action := Action_read
				execute_agent := create {ESA_READ_ACTION}.make (Current) -- agent execute_read_procedure (row,last_object)
				selection.object_convert (row)
				selection.load_result
				status.reset
			else
				--| query failed
				status.set_datastore_error (error_code, error_message) --) row_cursor.native_code, row_cursor.diagnostic_message)
			end		
		end
	
	read_pid_collection (sql : STRING) is
			-- Collection reading facility. A new cursor is created. Calls `create_pid_from_row', `add_pid_to_cursor' for each result.
			-- 
		require
			sql_not_void: sql /= Void
		do
			execute_and_load (sql, pid_row, create {ESA_READ_PID_COLLECTION_ACTION}.make (Current))--agent execute_read_collection_pid_procedure (row))
		end

	read_object_collection (sql : STRING) is
		require
			sql_not_void: sql /= Void
		do
			execute_and_load (sql, row, create {ESA_READ_COLLECTION_ACTION}.make (Current))--agent execute_read_collection_object_procedure (row))
		end
		
feature {ESA_ACTION} -- Callbacks

	execute_exists_procedure (a_row : like row; an_object : like last_object) is
			do
				selection.object_convert (Current)
				selection.cursor_to_object				
			end
	
	execute_read_procedure is
			do
				selection.object_convert (row)
				selection.cursor_to_object
				create_object_from_row
				if last_object /= Void then
					fill_object_from_row
--					create_pid_from_object (last_object)
--					last_object.set_pid (last_pid)
--					last_cursor.add_object (last_object)
				end
			end
	
	execute_read_collection_pid_procedure (a_row : like pid_row) is
			do
				selection.object_convert (a_row)
				selection.cursor_to_object
				last_pid := Void
				create_pid_from_pid_row
				if last_pid /= Void then
					add_pid_to_cursor
				end
			end
	
	execute_read_collection_object_procedure is --(a_row : like row) is
			do
--				selection.object_convert (a_row)
				selection.cursor_to_object
				last_object := Void
				create_object_from_row
				if last_object /= Void then
					fill_object_from_row
					add_object_to_cursor
				end
			end
	
	execute_refresh_procedure (a_row : like row) is
			do
				selection.object_convert (a_row)
				selection.cursor_to_object
				fill_object_from_row				
			end

feature  {NONE} -- Implementation
	
	change : DB_CHANGE
			-- EiffelStore change object
	
	selection : DB_SELECTION
			-- EiffelStore selection object
	
	execute is
		do
			-- execute does not allow enforcing its precondition (True)
			-- then delegate to a precondition-checked routine
			execute_agent.execute
		end
		
--	do_execute_agent is
--		require
--			execute_agent_not_void: execute_agent /= Void
--		do
--			execute_agent.call([])	
--		end

	execute_agent : ESA_ACTION -- PROCEDURE[like Current, TUPLE]

		
		
--	do_execute is
--			-- feature executed each time a row is available when reading
--		require
--			reading_action: current_action = Action_exists or else
--					current_action = Action_refresh or else
--					current_action = Action_read or else current_action = Action_read_collection_pid
--			row_not_void: row /= Void
--		do
--			inspect current_action 
--			when Action_exists then
--				selection.object_convert (Current)
--				selection.cursor_to_object
--			when Action_read then
--				selection.object_convert (row)
--				selection.cursor_to_object
--				create_object_from_row
--				fill_object_from_row
--			when Action_read_collection_pid then
--				selection.object_convert (pid_row)
--				selection.cursor_to_object
--				last_pid := Void
--				create_pid_from_pid_row
--				add_pid_to_cursor
--			when Action_read_collection_object then
--				selection.object_convert (row)
--				selection.cursor_to_object
--				last_object := Void
--				create_object_from_row
--				fill_object_from_row
--				add_object_to_cursor
--			when Action_refresh then
--				selection.object_convert (row)
--				selection.cursor_to_object
--				fill_object_from_row
--			else
--				-- invalid path	
--			end
--			
--		end

	exists_count : INTEGER

	Action_none, Action_exists, Action_read, Action_refresh, Action_read_collection_pid, Action_read_collection_object : INTEGER is unique
	
	current_action : INTEGER

feature -- other services

	execute_and_load (a_sql : STRING; a_row : ANY; a_procedure : like execute_agent) is
			-- execute 'a_sql' and load result-set using 'a_row' as row buffer,
			-- 'an_object' as business object to fill and, a_procedure as filling_procedure
		require
			a_sql_not_void: a_sql /= Void
			a_row_not_void: a_row /= Void
			a_procedure_not_void: a_procedure /= Void
		do
			status.reset
			selection.query (a_sql)
			if selection.is_ok then
				selection.set_action (Current)
				create_cursor
				execute_agent := a_procedure 
				selection.object_convert (a_row)
				selection.load_result
			else
				--| query failed
				status.set_datastore_error (error_code, error_message) --) row_cursor.native_code, row_cursor.diagnostic_message)
			end		
		end

	string_from (s : STRING) : STRING is
			-- create non-void string from s
		do
			if s = Void then
				create Result.make (0)
			else
				Result := clone (s)	
			end
		ensure
			result_not_void: Result /= Void
			void_creates_empty: s = Void implies Result.count = 0
		end
		
invariant

	change_not_void: change /= Void
	selection_not_void: selection /= Void
	datastore_not_void: datastore /= Void

end
