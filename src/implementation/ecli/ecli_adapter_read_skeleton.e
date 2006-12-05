indexing

	description:

		"Adapters using ECLI that implement read access"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class ECLI_ADAPTER_READ_SKELETON[G->PO_PERSISTENT]

inherit

	ECLI_ADAPTER_COMMON_SKELETON[G]

feature -- Status report

	can_read : BOOLEAN is
		do
			Result := True
		ensure then
			can_read: Result
		end

feature -- Basic operations

	read (a_pid: like last_pid) is
			-- Read an object identified by `a_pid' using `read_cursor'.
		do
			last_object := Void
			create last_cursor.make
			status.reset
			if is_enabled_cache_on_read then
				cache.search (a_pid)
				if cache.found then
					if cache.found_item /= Void then
						last_cursor.add_object (cache.found_item)
					end
				end
			end
			if not is_enabled_cache_on_read or else not cache.found then
				init_parameters_for_read (a_pid)
				read_cursor.execute
				if read_cursor.is_ok then
					load_results (read_cursor, a_pid)
				else
					status.set_datastore_error (read_cursor.native_code, read_cursor.diagnostic_message)
				end
			end
		end

feature {PO_ADAPTER} -- Basic operations

	init_parameters_for_read (a_pid : like last_pid) is
			-- Initialize parameters of `read_cursor' with information from `a_pid'.
		require
			a_pid_not_void: a_pid /= Void
		deferred
		ensure
			bound_parameters: read_cursor.bound_parameters
		end

feature {NONE} -- Factory

	create_object_from_read_cursor  (a_cursor : like read_cursor; a_pid : like last_pid) is
			-- Create object and just ensure invariant.

		require
			last_object_void: last_object = Void
			a_cursor_not_void: a_cursor /= Void
			a_pid_not_void: a_pid /= Void
			something_read : not a_cursor.off
		deferred
		ensure
			last_object_created_if_no_error: not status.is_error implies last_object /= Void
		end

	fill_object_from_read_cursor (a_cursor : like read_cursor; object : like last_object) is
			-- Fill `last_object' using `read_cursor' results.
		require
			a_cursor_not_void: a_cursor /= Void
			object_not_void: object /= Void
		deferred
		end

feature {PO_ADAPTER} -- Implementation

	read_cursor : ECLI_CURSOR is
		deferred
		end

feature {NONE} -- Implementation

	load_results (a_cursor : like read_cursor; a_pid : like last_pid) is
			-- Load results from a cursor.
		require
			a_cursor_not_void: a_cursor /= Void
			a_cursor_executed: a_cursor.is_executed
			a_cursor_before: a_cursor.before
			a_pid_not_void: a_pid /= Void
		do
			a_cursor.start
			if a_cursor.is_ok then
				if not a_cursor.off then
					create_object_from_read_cursor (a_cursor, a_pid)
					if last_object /= Void then
						fill_object_from_read_cursor (a_cursor, last_object)
						if status.is_ok then
							last_object.set_pid (a_pid)
							if is_enabled_cache_on_read then
								cache.put (last_object)
							end
							last_cursor.add_object (last_object)
							a_cursor.go_after
						else
							last_cursor.wipe_out
						end
					else
						status.set_framework_error (status.error_could_not_create_object)
					end
				else
					if is_enabled_cache_on_read then
						cache.put_void (a_pid)
					end
				end
			else
				status.set_datastore_error (a_cursor.native_code, a_cursor.diagnostic_message)
			end
		end

end
