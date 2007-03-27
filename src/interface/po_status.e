indexing

	description:

		"Objects that give status information about latest persistance operation."

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class PO_STATUS

inherit

	ANY
		redefine
			is_equal,
			copy
		end

feature -- Access

	is_ok : BOOLEAN is
			-- was the last operation a success ?
		do
			Result := (status = status_ok or else is_warning)
		ensure
			definition: Result = (status = status_ok or else is_warning)
		end

	is_error : BOOLEAN is
			-- has the last operation led to an error ?
		do
			Result := (status = Status_error)
		ensure
			definition: Result = (status = Status_error)
		end

	is_warning : BOOLEAN is
			-- has the last operation issued a warning ?
		do
			Result := (status = status_warning)
		ensure
			definition: Result = (status = status_warning)
		end

	is_datastore : BOOLEAN is
			-- is the current description related to a datastore operation ?
		do
			Result := impl_is_datastore
		end

	code : INTEGER is
			-- Code describing the current error or warning.
		do
			Result := impl_code
		end

	message : STRING is
			-- Message describing the current status.
		do
			if is_datastore then
				Result := impl_message
			elseif is_error then
				Result := error_meaning (code)
			else
				Result := meaning_none
			end
		ensure
			definition: Result /= Void
		end

feature -- Status report

	valid_framework_error_code (some_code : INTEGER) : BOOLEAN is
		do
			Result := (some_code >= error_none and then some_code <= error_could_not_find_adapter)
		ensure
			definition: Result = (some_code >= error_none and then some_code <= error_could_not_find_adapter)
		end

feature {PO_STATUS_MANAGEMENT}-- Status setting

	reset is
			-- Reset status.
		do
			set_ok
			set_is_datastore (False)
			reset_message
			set_code (error_none)
		ensure
			ok: is_ok
			no_datastore: not is_datastore
			error_none: code = error_none
			no_message: message.is_equal ("")
		end

	set_datastore_warning (warning_code : INTEGER; warning_message : STRING) is
		require
			message_not_void: message /= Void
		do
			set_is_datastore (True)
			set_warning
			set_code (warning_code)
			set_message (warning_message)
		ensure
			code_set: code = warning_code
			is_warning: is_warning
			message_set: message.is_equal (warning_message)
			is_datastore: is_datastore
		end

	set_framework_warning (warning_code : INTEGER; warning_message : STRING) is
		require
			message_not_void: message /= Void
		do
			set_is_datastore (False)
			set_warning
			set_code (warning_code)
			set_message (warning_message)
		ensure
			code_set: code = warning_code
			is_warning: is_warning
			message_set: message.is_equal (warning_message)
			not_is_datastore: not is_datastore
		end

	set_datastore_error (error_code : INTEGER; error_message : STRING) is
		require
			message_not_void: message /= Void
		do
			set_is_datastore (True)
			set_error
			set_code (error_code)
			set_message (error_message)
		ensure
			code_set: code = error_code
			is_error: is_error
			message_set: message.is_equal (error_message)
			is_datastore: is_datastore
		end

	set_framework_error (error_code : INTEGER) is
		require
			error_code_within_bounds: valid_framework_error_code (error_code)
		do
			set_is_datastore (False)
			set_error
			set_code (error_code)
		ensure
			code_set: code = error_code
			is_error: is_error
			not_is_datastore: not is_datastore
		end

feature -- Duplication

	copy (other : like Current) is
		do
			if other.is_ok then
				set_ok
			elseif other.is_warning then
				set_warning
			else
				set_error
			end
			set_is_datastore (other.is_datastore)
			set_code (other.code)
			if is_datastore or else is_warning then
				set_message (other.message)
			end
		end

feature -- Comparison

	is_equal (other : like Current) : BOOLEAN is
		do
			if  status = other .status
					and then is_datastore = other.is_datastore
					and then code = other.code
					and then equal (message, other.message) then

				Result := True
			end
		end

feature -- Constants

	error_none : INTEGER is 0

	error_non_conformant_pid : INTEGER is 1
			-- Pid type does not conform to expected one

	error_invalid_pid_content : INTEGER is 2
			-- Pid contains information of invalid type

	error_could_not_create_object : INTEGER is 3
			-- Precondition to create object has not been met, or error while creating it

	error_could_not_refresh_object : INTEGER is 4
			-- No data found while refreshing objects

	error_could_not_find_adapter: INTEGER is 5
			-- Searched adaptor does not exists.

feature {PO_STATUS} -- Implementation

	status : INTEGER

feature {NONE} -- Implementation

	status_ok : INTEGER is 0
	status_warning : INTEGER is 1
	status_error : INTEGER is 2

	impl_is_datastore : BOOLEAN

	impl_message : STRING

	set_message (new_message : STRING) is
		do
			impl_message := new_message
		ensure
			definition: impl_message = new_message
		end

	reset_message is do set_message (Meaning_none) end

	set_is_datastore (value : BOOLEAN) is
		do
			impl_is_datastore := value
		ensure
			is_datastore = Value
		end

	set_warning is do status := status_warning end
	set_ok is do status := status_ok end
	set_error is do status := status_error end

	impl_code : INTEGER

	set_code (value : INTEGER) is
		do
			impl_code := value
		ensure
			definition: code = value
		end

	error_meaning (a_code : INTEGER) : STRING is
			-- Error meaning for a non-datastore code.
		require
			not_is_datastore: not is_datastore
			is_error: is_error
			valid_code: valid_framework_error_code (a_code)
		do
			inspect a_code
			when error_none then Result := meaning_none
			when error_non_conformant_pid then Result := meaning_non_conformant_pid
			when error_invalid_pid_content then Result := meaning_invalid_pid_content
			when error_could_not_create_object then Result := meaning_could_not_create_object
			when error_could_not_find_adapter then Result := meaning_could_not_find_adapter
			when error_could_not_refresh_object then Result := meaning_could_not_refresh_object
			end
		end

	meaning_none : STRING is ""
	meaning_non_conformant_pid : STRING is "object.pid does not conform to Current.last_pid"
	meaning_invalid_pid_content : STRING is "object.pid contains information of invalid type"
	meaning_could_not_create_object : STRING is "last_object not created : creation precondition not met"
	meaning_could_not_find_adapter: STRING is "Could not find adapter"
	meaning_could_not_refresh_object : STRING is "Could not refresh object : nothing found in datastore"

invariant

	ok: is_ok implies not is_error
	warning: is_warning implies is_ok
	framework_error_code: (not is_datastore and is_error) implies valid_framework_error_code (code)
	valid_status: status >= status_ok and then status <= status_error

end
