indexing

	description:

		"EPOM error handlers."

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	PO_ERROR_HANDLER

inherit
	UT_ERROR_HANDLER
		export
			{NONE} all;
			{ANY} is_equal, copy
		end

create
	make_standard, make_null

feature -- Basic operations

	report_datastore_error (a_adapter, a_access_name : STRING; a_code : INTEGER; a_message : STRING) is
			-- Datastore error in `a_adapter_class'.`a_access_name' : error `a_code' with `a_message'.
		do
			do_nothing
		end

	report_non_conformant_pid (a_adapter, a_access_name, expected_class_name, actual_class_name : STRING) is
			-- Non conformant pid in `a_adapter_class'.`a_access_name' : got `actual_class_name' instead of `expected_class_name'.
		do
			do_nothing
		end

	report_could_not_create_object (a_adapter, a_access_name, class_name : STRING) is
			-- Could not create instance of `class_name' in `a_adapter'.`a_access_name'.
		do
			do_nothing
		end

	report_could_not_find_adapter (a_class, a_routine : STRING) is
			-- Could not find adapter for `a_class' in `a_routine'.
		do
			do_nothing
		end

	report_could_not_refresh_object (object : PO_PERSISTENT) is
			-- Could not refresh object because no data have been found.
		do
			do_nothing
		end

end
