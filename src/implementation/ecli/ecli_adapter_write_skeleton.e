indexing

	description:

		"Adapters using ECLI that implement write access"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class ECLI_ADAPTER_WRITE_SKELETON[G->PO_PERSISTENT]

inherit

	ECLI_ADAPTER_COMMON_SKELETON[G]

feature -- Status report

	can_write : BOOLEAN is 
		do 
			Result := True 
		end

feature -- Basic operations

	write (object: like object_anchor) is
			-- Write `object' on datastore.
		do
			status.reset
			create_pid_from_object (object)
			last_object := object
			if last_pid /= Void then
				init_parameters_for_write (object, last_pid)
				write_query.execute
				if write_query.is_ok then
					object.set_pid (last_pid)
					object.disable_modified
					if is_enabled_cache_on_write then
						cache.put (last_object)
					end
				else
					status.set_datastore_error (write_query.native_code, write_query.diagnostic_message)
				end
			else
				status.set_framework_error (status.Error_non_conformant_pid)
			end		
		end
	
feature {PO_ADAPTER} -- Basic operations

	init_parameters_for_write (object : like last_object; a_pid : like last_pid) is
			-- Initialize parameters of `write_query' with information from `object' and `a_pid'.
		deferred
		ensure
			bound_parameters: write_query.bound_parameters
		end

feature {PO_ADAPTER} -- Implementation

	write_query : ECLI_QUERY is
		deferred
		end

end
