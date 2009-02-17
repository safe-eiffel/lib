indexing

	description:

		"Adapters using ECLI that implement delete access"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class ECLI_ADAPTER_DELETE_SKELETON[G->PO_PERSISTENT]

inherit

	ECLI_ADAPTER_COMMON_SKELETON[G]

feature -- Status report

	can_delete : BOOLEAN is
		do
			Result := True
		ensure then
			can_delete: Result
		end

feature -- Basic operations

	delete (object: like object_anchor) is
			-- Delete `object' from datastore using `delete_query'.
		do
			status.reset
			last_pid ?= pid_for_object (object)

			last_object := default_value
			if last_pid /= Void then
				init_parameters_for_delete (last_pid)
				delete_query.execute
				if delete_query.is_ok then
					status.reset
					cache.search (last_pid)
					if cache.found then
						cache.remove (last_pid)
					end
					object.set_deleted
				else
					status.set_datastore_error (delete_query.native_code, delete_query.diagnostic_message)
					error_handler.report_query_error (generator, "delete", delete_query)
				end
			else
				status.set_framework_error (status.error_non_conformant_pid)
				error_handler.report_non_conformant_pid (generator, "delete", persistent_class_name, object.persistent_class_name)
			end
		end

feature {NONE} -- Framework - Access

	delete_query : ECLI_QUERY is
		deferred
		end

feature {PO_ADAPTER} -- Framework - Basic operations

	init_parameters_for_delete (a_pid : like last_pid) is
			-- Initialize parameters of `delete_query' with information from `a_pid'.
		require
			a_pid_not_void: a_pid /= Void
		deferred
		ensure
			bound_parameters: delete_query.bound_parameters
		end

end
