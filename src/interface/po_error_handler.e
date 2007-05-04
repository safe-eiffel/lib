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

	report_datastore_error (an_adapter, an_access_name : STRING; a_code : INTEGER; a_message : STRING) is
			-- Datastore error in `an_adapter_class'.`an_access_name' : error `a_code' with `a_message'.
		require
			an_adapter_not_void: an_adapter /= Void
			an_access_name_not_void: an_access_name /= Void
			a_message_not_void: a_message /= Void
		local
			error : PO_ERROR
		do
			create error.make_datastore_error (an_adapter, an_access_name, a_code, a_message)
			report_error (error)
		end

	report_non_conformant_pid (an_adapter, an_access_name, expected_class_name, actual_class_name : STRING) is
			-- Non conformant pid in `an_adapter_class'.`an_access_name' : got `actual_class_name' instead of `expected_class_name'.
		require
			an_adapter_not_void: an_adapter /= Void
			an_access_name_not_void: an_access_name /= Void
			expected_class_name_not_void: expected_class_name /= Void
			actual_class_name_not_void: actual_class_name /= Void
		local
			error : PO_ERROR
		do
			create error.make_non_conformant_pid (an_adapter, an_access_name, expected_class_name, actual_class_name)
			report_error (error)
		end

	report_could_not_create_object (an_adapter, an_access_name, persistent_class_name : STRING) is
			-- Could not create instance of `persistent_class_name' in `an_adapter'.`an_access_name'.
		require
			an_adapter_not_void: an_adapter /= Void
			an_access_name_not_void: an_access_name /= Void
			persistent_class_name_not_void: persistent_class_name /= Void
		local
			error : PO_ERROR
		do
			create error.make_could_not_create_object (an_adapter, an_access_name, persistent_class_name)
			report_error (error)
		end

	report_could_not_find_adapter (a_persistent_class_name, a_class, a_routine : STRING) is
			-- Could not find adapter for `a_persistent_class_name' in {`a_class'}.`a_routine'.
		require
			a_persistent_class_name_not_void: a_persistent_class_name /= Void
			a_class_not_void: a_class /= Void
			a_routine_not_void: a_routine /= Void
		local
			error : PO_ERROR
		do
			create error.make_could_not_find_adapter (a_persistent_class_name, a_class, a_routine)
			report_error (error)
		end

	report_could_not_refresh_object (an_adapter : STRING; object : PO_PERSISTENT) is
			-- Could not refresh `object' in `an_adapter' because no data have been found.
		require
			an_adapter_not_void: an_adapter /= Void
			object_not_void: object /= Void
			object_is_persistent: object.is_persistent
		local
			error : PO_ERROR
		do
			create error.make_could_not_refresh_object (an_adapter, object)
		end

end
