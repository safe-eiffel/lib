indexing

class PO_ERROR

inherit
	UT_ERROR

create
	make_datastore_error,
	make_non_conformant_pid,
	make_could_not_create_object,
	make_could_not_find_adapter,
	make_could_not_refresh_object,
	make_connection_error

feature {NONE} -- Initialization

	make_datastore_error (an_adapter, an_access_name : STRING; a_code : INTEGER; a_message : STRING) is
			-- Datastore error in `an_adapter_class'.`an_access_name' : error `a_code' with `a_message'.
		require
			an_adapter_not_void: an_adapter /= Void
			an_access_name_not_void: an_access_name /= Void
			a_message_not_void: a_message /= Void
		do
			default_template := tpl_datastore_error
			code := code_datastore_error
			create parameters.make (1, 5)
			parameters.put (code, 1)
			parameters.put (an_adapter, 2)
			parameters.put (an_access_name, 3)
			parameters.put (a_code.out, 4)
			parameters.put (a_message, 5)
		ensure
			default_template_set: default_template = tpl_datastore_error
			code_set: code = code_datastore_error
		end

	make_non_conformant_pid (an_adapter, an_access_name, expected_class_name, actual_class_name : STRING) is
			-- Non conformant pid in `an_adapter_class'.`an_access_name' : got `actual_class_name' instead of `expected_class_name'.
		require
			an_adapter_not_void: an_adapter /= Void
			an_access_name_not_void: an_access_name /= Void
			expected_class_name_not_void: expected_class_name /= Void
			actual_class_name_not_void: actual_class_name /= Void
		do
			default_template := tpl_non_conformant_pid
			code := code_non_conformant_pid
			create parameters.make (1, 5)
			parameters.make (1, 5)
			parameters.put (code, 1)
			parameters.put (an_adapter, 2)
			parameters.put (an_access_name, 3)
			parameters.put (expected_class_name, 4)
			parameters.put (actual_class_name, 5)
		ensure
			default_template_set: default_template = tpl_non_conformant_pid
			code_set: code = code_non_conformant_pid
		end

	make_could_not_create_object (an_adapter, an_access_name, persistent_class_name : STRING) is
			-- Could not create instance of `persistent_class_name' in `an_adapter'.`an_access_name'.
		require
			an_adapter_not_void: an_adapter /= Void
			an_access_name_not_void: an_access_name /= Void
			persistent_class_name_not_void: persistent_class_name /= Void
		do
			default_template := tpl_could_not_create_object
			code := code_could_not_create_object
			create parameters.make (1, 4)
			parameters.put (code, 1)
			parameters.put (an_adapter, 2)
			parameters.put (an_access_name, 3)
			parameters.put (persistent_class_name, 4)
		ensure
			default_template_set: default_template = tpl_could_not_create_object
			code_set: code = code_could_not_create_object
		end

	make_could_not_find_adapter (a_persistent_class_name, a_class, a_routine : STRING) is
			-- Could not find adapter for `a_persistent_class_name' in {`a_class'}.`a_routine'.
		require
			a_persistent_class_name_not_void: a_persistent_class_name /= Void
			a_class_not_void: a_class /= Void
			a_routine_not_void: a_routine /= Void
		do
			default_template := tpl_could_not_find_adapter
			code := code_could_not_find_adapter
			create parameters.make (1, 4)
			parameters.put (code, 1)
			parameters.put (a_class, 2)
			parameters.put (a_routine, 3)
			parameters.put (a_persistent_class_name, 4)
		ensure
			default_template_set: default_template = tpl_could_not_find_adapter
			code_set: code = code_could_not_find_adapter
		end

	make_could_not_refresh_object (an_adapter : STRING; object : PO_PERSISTENT) is
			-- Could not refresh `object' in `an_adapter' because no data have been found.
		require
			an_adapter_not_void: an_adapter /= Void
			object_not_void: object /= Void
		do
			default_template := tpl_could_not_refresh_object
			code := code_could_not_refresh_object
			create parameters.make (1,3)
			parameters.put (code, 1)
			parameters.put (an_adapter, 2)
			parameters.put (object.pid.as_string, 3)
		ensure
			default_template_set: default_template = tpl_could_not_refresh_object
			code_set: code = code_could_not_refresh_object
		end

	make_connection_error (datastore_name : STRING; a_code : INTEGER; a_message : STRING) is
			-- Connection failed to `datastore_name' : error `a_code' with `a_message'.
		require
			datastore_name_not_void: datastore_name /= Void
			a_message_not_void: a_message /= Void
		do
			default_template := tpl_connection_error
			code := code_connection_error
			create parameters.make (1, 4)
			parameters.put (code, 1)
			parameters.put (datastore_name, 2)
			parameters.put (a_code.out, 3)
			parameters.put (a_message, 4)
		ensure
			default_template_set: default_template = tpl_connection_error
			code_set: code = code_connection_error
		end

feature {NONE} -- Implementation

	code : STRING

	default_template : STRING

	tpl_datastore_error : STRING is "[$1] {$2}.$3 : Datastore error $4 '$5'"
	tpl_non_conformant_pid : STRING	is "[$1] {$2}.$3 : Non conformant pid - got '$4' instead of '$5'"
	tpl_could_not_create_object : STRING is "[$1] {$2}.$3 : Could not create object of type {$4}"
	tpl_could_not_find_adapter : STRING is "[$1] {$2}.$3 : Could not find adapter for persistent class '$4'"
	tpl_could_not_refresh_object : STRING is "[$1] {$2}.refresh : Could not refresh object '$3' - No data found"
	tpl_connection_error : STRING is "[$1] Connection to '$2' failed : error $3 '$4'"

	code_datastore_error : STRING is 		    "EPOM-E-DSERR"
	code_non_conformant_pid : STRING is		    "EPOM-E-NCPID"
	code_could_not_create_object : STRING is	"EPOM-E-CNCOB"
	code_could_not_find_adapter : STRING is		"EPOM-E-CNFAD"
	code_could_not_refresh_object : STRING is	"EPOM-E-CNROB"
	code_connection_error : STRING is           "EPOM-E-CNXER"

end
