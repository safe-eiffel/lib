indexing

	description:

		"Adapters using ECLI that implement refresh access"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class ECLI_ADAPTER_REFRESH_SKELETON[G->PO_PERSISTENT]

inherit

	ECLI_ADAPTER_COMMON_SKELETON[G]

feature -- Status report

	can_refresh : BOOLEAN is 
		do 
			Result := True 
		ensure then
			can_refresh: Result
		end

feature -- Basic operations

	refresh (object: like last_object) is
			-- Refresh `object' using `refresh_cursor'.
		do 
			status.reset
			last_pid ?= object.pid
			if last_pid /= Void then
				init_parameters_for_refresh (last_pid)
				refresh_cursor.start
				if refresh_cursor.is_ok then
					if not refresh_cursor.off then
						fill_from_refresh_cursor (object)
						if not status.is_error then
							object.disable_modified
						end
					else
						status.set_framework_error (status.Error_could_not_refresh_object)
					end
				else
					status.set_datastore_error (refresh_cursor.native_code, refresh_cursor.diagnostic_message						)
				end
			else
				status.set_framework_error (status.Error_non_conformant_pid)
			end		
		end
	
feature {PO_ADAPTER} -- Basic operations

	init_parameters_for_refresh (a_pid : like last_pid) is
			-- Initialize parameters of `refresh_cursor' with information from `a_pid'.
		deferred
		ensure
			bound_parameters: refresh_cursor.bound_parameters
		end

	fill_from_refresh_cursor (object : like last_object) is
			-- Fill `last_object' using `refresh_cursor' results.
		require
			read_cursor_not_void: refresh_cursor /= Void
			object_not_void: object /= Void
		deferred
		end

feature {PO_ADAPTER} -- Implementation

	refresh_cursor : ECLI_CURSOR is
		deferred
		end

end
