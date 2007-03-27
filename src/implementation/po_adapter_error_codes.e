indexing

	description:

		"Error codes for PO_ADAPTER_IMPL descendants."

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class PO_ADAPTER_ERROR_CODES

feature {NONE} -- Implementation

	lower_error_code : INTEGER is do Result := po_error_none end
	upper_error_code : INTEGER is do Result := po_error_no_data_found end

	po_error_code_within_bounds (a_code : INTEGER) : BOOLEAN is
			--
		do
			Result := (a_code >= lower_error_code and then a_code <= upper_error_code)
		ensure
			definition: Result = (a_code >= lower_error_code and then a_code <= upper_error_code)
		end

	po_error_none : INTEGER is 0
	po_error_query_failed : INTEGER is 1			-- Datastore query failed
	po_error_non_conformant_pid : INTEGER is 2  	-- Pid type does not conform to expected one
	po_error_invalid_pid_content : INTEGER is 3 	-- Pid contains information of invalid type
	po_error_could_not_create_object : INTEGER is 4 -- Precondition to create object has not been met, or error while creating it
	po_error_could_not_find_adapter: INTEGER is 5 	-- Searched adapter does not exist.
	po_error_no_data_found: INTEGER is 6 			-- No data found for pid.

	po_error_meaning (a_code : INTEGER) : STRING is
			--
		require
			valid_code: po_error_code_within_bounds (a_code)
		do
			inspect a_code
			when po_error_none then Result := po_meaning_none
			when po_error_query_failed then Result := po_meaning_query_failed
			when po_error_non_conformant_pid then Result := po_meaning_non_conformant_pid
			when po_error_invalid_pid_content then Result := po_meaning_invalid_pid_content
			when po_error_could_not_create_object then Result := po_meaning_could_not_create_object
			when po_error_could_not_find_adapter then Result := po_meaning_could_not_find_adapter
			when po_error_no_data_found then Result := po_meaning_no_data_found
			else
				Result := "Unknown"
			end
		end

	po_meaning_none : STRING is "NONE"
	po_meaning_query_failed : STRING is "Datastore query failed"
	po_meaning_non_conformant_pid : STRING is "object.pid does not conform to Current.last_pid"
	po_meaning_invalid_pid_content : STRING is "object.pid contains information of invalid type"
	po_meaning_could_not_create_object : STRING is "last_object not created : creation precondition not met"
	po_meaning_could_not_find_adapter: STRING is "Could not find adapter"
	po_meaning_no_data_found: STRING is "No data found for pid"

end
