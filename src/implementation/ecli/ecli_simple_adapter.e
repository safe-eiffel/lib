 indexing

	description:

		"Ecli partial implementation of PO_ADAPTERs.%
	%	
	%	Caches all read objects until `clear_cache' is called.%
	%	When `is_enabled_cache_on_write' is True then written object%
	%	also are inserted in the cache.%
	%"
	
	author: "Eric Fafchamps"
	
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

deferred class ECLI_SIMPLE_ADAPTER[G->PO_PERSISTENT]

obsolete "Use ECLI_GENERAL_ADAPTER descendants instead"

inherit

	PO_ADAPTER[G]
			
	PO_SHARED_MANAGER
		export
			{NONE} all
		end

	PO_ADAPTER_ERROR_CODES
		rename
			po_error_code_within_bounds as error_code_within_bounds			
		export
			{NONE} all
		end
		
feature {NONE} -- Initialization

	make (a_datastore : ECLI_DATASTORE) is
			-- make using `datastore'
		require
			a_datastore_not_void: a_datastore /= Void
		do
			datastore := a_datastore
			datastore.register_adapter (Current)
			create cache.make (10)
			create last_cursor.make
		ensure
			datastore_set: a_datastore /= Void
			no_cache_on_write: not is_enabled_cache_on_write
		end

feature -- Access
	
	datastore: ECLI_DATASTORE
		-- current datastore

	last_cursor: PO_REFERENCE_LIST_CURSOR [G]
		-- Cursor the handles a linked list of PO_REFERENCE, i.e implementing load-on-demand of objects
		

	last_pid: PO_PID
		-- Last created pid

feature {PO_ADAPTER} -- Access

	last_object: G
		-- Last created object

feature -- Status report
		
	error_code : INTEGER

	error_meaning : STRING is
			-- Human readable meaning for current `error_code'
		do
			!!Result.make(0)
			Result.append (status.message)
			if error_code = Po_error_query_failed then
				Result.append ("%N")
				Result.append (query_error_message)
			end
		end
		
	is_enabled_cache_on_write : BOOLEAN
			-- Are written objects inserted in cache ?

	is_enabled_cache_on_read : BOOLEAN
			-- Are read objects inserted in cache ?

	can_read : BOOLEAN is do Result := True end
	can_write : BOOLEAN is do Result := True end
	can_update : BOOLEAN is do Result := True end
	can_delete : BOOLEAN is do Result := True end
	can_refresh : BOOLEAN is do Result := True end

	
feature -- Status setting

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
		end
		
feature -- Basic operations

	exists (a_pid: like last_pid): BOOLEAN is
			-- Does an object identified by `a_pid' exist? Uses `Sql_exists'
		do
			status.reset
			create row_cursor.open (datastore.session, Sql_exists)
			init_parameters_for_exists (a_pid)
			row_cursor.bind_parameters
			row_cursor.start
			if row_cursor.is_ok then
				if not row_cursor.off then
					if row_cursor.item ("EXISTS_COUNT").to_integer > 0 then
						Result := True
					end
				end
				status.reset
			else
				status.set_datastore_error (row_cursor.native_code, row_cursor.diagnostic_message)
			end
			row_cursor.close
		end

	read (a_pid: like last_pid) is
			-- Read an object identified by `a_pid'.  Uses `Sql_read'
		do
			last_object := Void
			create last_cursor.make
			status.reset
			if is_enabled_cache_on_read then
				cache.search (a_pid.to_string)
				if cache.found then
					last_cursor.add_object (cache.found_item)
				end
			end
			if not is_enabled_cache_on_read or else not cache.found then
				!!row_cursor.open (datastore.session, Sql_read)
				init_parameters_for_read (a_pid)
				row_cursor.bind_parameters
				row_cursor.start
				if row_cursor.is_ok then
					if not row_cursor.off then
						create_object_from_row_cursor
						if last_object /= Void then
							fill_object_from_row_cursor				
							last_object.set_pid (a_pid)
							if is_enabled_cache_on_read then
								cache.force (last_object, a_pid.to_string)
							end
							last_cursor.add_object (last_object)
						else
							status.set_framework_error (status.error_could_not_create_object)
						end
					else
						do_nothing
					end
				else
					status.set_datastore_error (row_cursor.native_code, row_cursor.diagnostic_message)
				end
				row_cursor.close
			end
		end

	refresh (object: like last_object) is
			-- Refresh `object'.  Uses `Sql_refresh'
		do 
			last_object := Void
			
			status.reset
			last_pid ?= object.pid
			last_object := object
			if last_pid /= Void then
				!!row_cursor.open (datastore.session, Sql_refresh)
				init_parameters_for_refresh (last_pid)
				row_cursor.bind_parameters
				row_cursor.start
				if row_cursor.is_ok then
					if not row_cursor.off then
						fill_object_from_row_cursor
					else
						status.set_framework_error (status.Error_could_not_refresh_object)
					end
				else
					status.set_datastore_error (row_cursor.native_code, row_cursor.diagnostic_message)
				end
				row_cursor.close
			else
				status.set_framework_error (status.error_non_conformant_pid)
			end		
		end

	delete (object: like last_object) is
			-- Delete `object' from datastore.  Uses `Sql_delete'
		do  
			last_object := Void
			
			status.reset
			last_pid ?= object.pid
			last_object := object
			if last_pid /= Void then
				!!change.make (datastore.session)
				change.set_sql (Sql_delete)
				init_parameters_for_delete (last_pid)
				change.bind_parameters
				change.execute
				if change.is_ok then
					status.reset
				else
					status.set_datastore_error (row_cursor.native_code, row_cursor.diagnostic_message)
				end
				change.close
			else
				status.set_framework_error (status.error_non_conformant_pid)
			end
		end

	update (object: like last_object) is
			-- Update `object' on datastore. Uses `Sql_update'
		do  
			last_object := Void
			
			status.reset
			if object.is_volatile then
				create_pid_from_object (object)
			else
				last_pid ?= object.pid
			end
			last_object := object
			if last_pid /= Void then
				!!change.make (datastore.session)
				change.set_sql (Sql_update)
				init_parameters_for_update (object, last_pid)
				change.bind_parameters
				change.execute
				if change.is_ok then
					object.set_pid (last_pid)
				else
					--| query failed
					status.set_datastore_error (row_cursor.native_code, row_cursor.diagnostic_message)
				end
				change.close
			else
				--| non_conformant_pid 
				status.set_framework_error (status.error_non_conformant_pid)
			end		
		end

	write (object: like last_object) is
			-- Write `object' on datastore. Uses `Sql_write'
		do
			last_object := Void
			
			status.reset
			create_pid_from_object (object)
			last_object := object
			if last_pid /= Void then
				!!change.make (datastore.session)
				change.set_sql (Sql_write)
				init_parameters_for_write (object, last_pid)
				change.bind_parameters
				change.execute
				if change.is_ok then
					object.set_pid (last_pid)
					if is_enabled_cache_on_write then
						cache.force (last_object, last_pid.to_string)
					end
				else
					status.set_datastore_error (row_cursor.native_code, row_cursor.diagnostic_message)
				end
				change.close
			else
				status.set_framework_error (status.error_non_conformant_pid)
			end		
		end

feature {PO_ADAPTER} -- Implementation

	query_error_message: STRING
			-- Error message associated with last error

	set_query_error_message (a_string : STRING) is
			-- 
		require
			a_string_not_void: a_string /= Void
		do
			query_error_message := a_string		
		ensure
			query_error_message_set: query_error_message = a_string
		end

	init_parameters_for_exists (a_pid : like last_pid) is
			-- Initialize parameters of `Sql_exists' with information from `a_pid'
		deferred
		end

	init_parameters_for_read (a_pid : like last_pid) is
			-- Initialize parameters of `Sql_read' with information from `a_pid'
		deferred
		end

	init_parameters_for_refresh (a_pid : like last_pid) is
			-- Initialize parameters of `Sql_refresh' with information from `a_pid'
		deferred
		end

	init_parameters_for_delete (a_pid : like last_pid) is
			-- Initialize parameters of `Sql_delete' with information from `a_pid'
		deferred
		end

	init_parameters_for_write (object : like last_object; a_pid : like last_pid) is
			-- Initialize parameters of `Sql_write' with information from `object' and `a_pid'
		deferred
		end

	init_parameters_for_update (object : like last_object; a_pid : like last_pid) is
			-- Initialize parameters of `Sql_update' with information from `object' and `a_pid'
		deferred
		end

	create_pid_from_object (an_object: G) is
			-- Create `last_pid' based on the content of `an_object'
		deferred
		end

	create_pid_from_row_cursor is
			-- Create `last_pid' based on the content of the row_cursor
		require
			last_pid_void: last_pid = Void
			row_not_void:  row_cursor /= Void and then not row_cursor.off
		deferred
		end

	create_object_from_row_cursor is
			-- Create object and just ensure invariant

		require
			last_object_void: last_object = Void
			row_not_void:  row_cursor /= Void and then not row_cursor.off
		deferred
		ensure
			last_objet_is_persistent: last_object /= Void implies last_object.is_persistent
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

	fill_object_from_row_cursor is
			-- Fill `last_object' using `row' content
		require
			row_cursor_not_void: row_cursor /= Void
			last_object_not_void: last_object /= Void
		deferred
		end

	row_cursor : ECLI_ROW_CURSOR
			-- Cursor on virtual rows.
		
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

feature  {NONE} -- Implementation facilities for descendants

	read_object_collection is
			-- Read a collection of objects from current row_cursor
		require
			row_cursor_ready: row_cursor /= Void
		do
			last_object := Void
			
			row_cursor.start
			if row_cursor.is_ok then				
				from
					status.reset
					!!last_cursor.make
				until
					row_cursor.off
				loop
					last_object := Void
					create_object_from_row_cursor
					if last_object /= Void then
						fill_object_from_row_cursor
						add_object_to_cursor
					end
					row_cursor.forth
				end
			else
				status.set_datastore_error (row_cursor.native_code, row_cursor.diagnostic_message)
			end

			if not is_error then
				if last_cursor.count = 1 then
					last_cursor.start
					last_object := last_cursor.item
				else
					last_object := Void
				end
			end
		end

	read_pid_collection is 
			-- Read a collection of pid from current row_cursor
		require
			row_cursor_ready: row_cursor /= Void
		do
			last_object := Void
			
			row_cursor.start
			if row_cursor.is_ok then				
				from
					status.reset
					!!last_cursor.make
				until
					row_cursor.off
				loop
					last_pid := Void
					create_pid_from_row_cursor
					if last_pid /= Void then
						add_pid_to_cursor
					end
					row_cursor.forth
				end
			else
				status.set_datastore_error (row_cursor.native_code, row_cursor.diagnostic_message)
			end
			
			if not is_error then
				if last_cursor.count = 1 then
					last_cursor.start
					last_object := last_cursor.item
				else
					last_object := Void
				end
			end
		end
		
feature  {NONE} -- Implementation	
	
	set_error (a_code : INTEGER) is 
			-- set `error_code' to `a_code'
		do 
			error_code := a_code 
		end
	
	change : ECLI_STATEMENT
			-- Ecli change object
		
invariant

	datastore_not_void: datastore /= Void
	
end
