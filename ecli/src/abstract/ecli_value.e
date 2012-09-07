note

	description:

		"Objects that represent typed values to be exchanged with the database."

	library: "ECLI : Eiffel Call Level Interface (ODBC) Library. Project SAFE."
	Copyright: "Copyright (c) 2001-2012, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class ECLI_VALUE

inherit

	ECLI_TRACEABLE
		undefine
			is_equal
		end

	ECLI_HANDLE
		rename
			handle as buffer
		export
			{NONE} release_handle
		undefine
			is_equal
		end

	ECLI_EXTERNAL_API
		undefine
			is_equal
		end

	ECLI_TYPE_CONSTANTS
		undefine
			is_equal
		end

	ECLI_DATA_DESCRIPTION
		export
			{ANY} all
		undefine
			is_equal
		end

	ECLI_LENGTH_INDICATOR_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal
		end

feature -- Status report

	is_null : BOOLEAN
			-- Is this a NULL value (in RDBMS sense) ?
		do
			Result := ecli_c_value_get_length_indicator (buffer) = Sql_null_data
		end

	is_buffer_too_small : BOOLEAN
			-- Is buffer capacity too small for actual data?
		do
			Result := False
		end

	convertible_as_string : BOOLEAN
			-- Is this value convertible to a string ?
		deferred
		end

	convertible_as_character : BOOLEAN
			-- Is this value convertible to a character ?
		deferred
		end

	convertible_as_boolean : BOOLEAN
			-- Is this value convertible to a boolean ?
		deferred
		end

	convertible_as_decimal : BOOLEAN
			-- Is this value convertible to a boolean ?
		deferred
		end

	convertible_as_integer : BOOLEAN
			-- Is this value convertible to an integer ?
		deferred
		end

	convertible_as_integer_64 : BOOLEAN
			-- Is this value convertible to an integer_64 ?
		deferred
		end

	convertible_as_real : BOOLEAN
			-- Is this value convertible to a real ?
		deferred
		end

	convertible_as_double : BOOLEAN
			-- Is this value convertible to a double ?
		deferred
		end

	convertible_as_date : BOOLEAN
			-- Is this value convertible to a date ?
		deferred
		end

	convertible_as_time : BOOLEAN
			-- Is this value convertible to a time ?
		deferred
		end

	convertible_as_timestamp : BOOLEAN
			-- Is this value convertible to a timestamp ?
		deferred
		end


	can_trace : BOOLEAN
		do
			Result := True
		ensure then
			ok: Result
		end

feature {ECLI_VALUE, ECLI_STATEMENT} -- Status Report

	c_type_code : INTEGER
			-- (redefine in descendant classes)
		deferred
		end

	transfer_octet_length : INTEGER_64
			-- Actual buffer capacity for underlying data transfer.
			-- (redefine in descendant classes)
		deferred
		end

	display_size : INTEGER
			-- Display size.
			-- (redefine in descendant classes)
		deferred
		end

	length_indicator : INTEGER_64
			-- Length indicator for database Xfer.
		do
			if is_null then
				Result := 0
			else
				Result := ecli_c_value_get_length_indicator (buffer)
			end
		end

feature -- Element change

	set_null
			-- Set item to null.
		do
			ecli_c_value_set_length_indicator (buffer, Sql_null_data)
		ensure
			null_value: is_null
		end

feature -- Transformation

feature -- Conversion

	as_string : STRING
			-- Current converted to STRING.
		require
			convertible: convertible_as_string
			not_null: not is_null
		deferred
		ensure
			no_aliasing: True -- Result /= old Result
		end

	as_character : CHARACTER
			-- Current converted to CHARACTER .
		require
			convertible: convertible_as_character
			not_null: not is_null
		deferred
		end

	as_boolean : BOOLEAN
			-- Current converted to BOOLEAN.
		require
			convertible: convertible_as_boolean
			not_null: not is_null
		deferred
		end

	as_decimal : MA_DECIMAL
			-- Current converted to MA_DECIMAL.
		require
			convertible: convertible_as_decimal
			not_null: not is_null
		deferred
		end

	as_integer : INTEGER
			-- Current converted to INTEGER.
		require
			convertible: convertible_as_integer
			not_null: not is_null
		deferred
		end

	as_integer_64 : INTEGER_64
			-- Current converted to INTEGER_64
		require
			convertible: convertible_as_integer_64
			not_null: not is_null
		deferred
		end

	as_real : REAL
			-- Current converted to REAL.
		require
			convertible: convertible_as_real
			not_null: not is_null
		deferred
		end

	as_double : DOUBLE
			-- Current converted to DOUBLE.
		require
			convertible: convertible_as_double
			not_null: not is_null
		deferred
		end

	as_date : DT_DATE
			-- Current converted to DATE.
		require
			convertible: convertible_as_date
			not_null: not is_null
		deferred
		ensure
			no_aliasing: True -- Result /= old Result
		end

	as_time : DT_TIME
			-- Current converted to DT_TIME.
		require
			convertible: convertible_as_time
			not_null: not is_null
		deferred
		ensure
			no_aliasing: True -- Result /= old Result
		end

	as_timestamp : DT_DATE_TIME
			-- Current converted to DT_DATE_TIME.
		require
			convertible: convertible_as_timestamp
			not_null: not is_null
		deferred
		ensure
			no_aliasing: True -- Result /= old Result
		end

feature {NONE} -- Implementation

	release_handle
		do
			ecli_c_free_value (buffer)
			buffer := default_pointer
		end

	to_external : POINTER
			-- External 'C' address of value.
		do
			Result := ecli_c_value_get_value (buffer)
		ensure
			not_null: Result /= default_pointer
		end

	length_indicator_pointer : POINTER
			-- External 'C' address of length indicator.
		do
			Result := ecli_c_value_get_length_indicator_pointer (buffer)
		end

feature {ECLI_STATEMENT, ECLI_STATEMENT_PARAMETER} -- Basic operations

	read_result (stmt : ECLI_STATEMENT; index : INTEGER)
			-- Read value from current result column 'index' of 'stmt'.
		require
			stmt: stmt /= Void and then (stmt.is_executed and not stmt.off)
			positive_index: index > 0
		do
			stmt.set_status ("ecli_c_get_data", ecli_c_get_data (
					stmt.handle,
					index,
					c_type_code,
					to_external,
					transfer_octet_length,
					length_indicator_pointer)
				)
		end

	bind_as_result  (stmt : ECLI_STATEMENT; index: INTEGER)
			-- Bind Current as a result value.
		require
			stmt: stmt /= Void
			positive_index: index > 0
		do
			stmt.set_status ("ecli_c_bind_result", ecli_c_bind_result (
					stmt.handle,
					index,
					c_type_code,
					to_external,
					transfer_octet_length,
					length_indicator_pointer)
				)
		end

	bind_as_parameter (stmt : ECLI_STATEMENT; index: INTEGER)
			-- Bind this value as input parameter 'index' of 'stmt'.
		require
			stmt: stmt /= Void and then stmt.parameters_count > 0
			positive_index: index > 0
		do
			bind_parameter (stmt,
				index,
				Parameter_directions.Sql_param_input)
		end

	bind_as_input_output_parameter (stmt : ECLI_STATEMENT; index: INTEGER)
			-- Bind this value as input/output parameter 'index' of 'stmt'.
		require
			stmt: stmt /= Void and then stmt.parameters_count > 0
			positive_index: index > 0
		do
			bind_parameter (stmt,
				index,
				Parameter_directions.Sql_param_input_output)
		end

	bind_as_output_parameter (stmt : ECLI_STATEMENT; index: INTEGER)
			-- Bind this value as output parameter 'index' of 'stmt'.
		require
			stmt: stmt /= Void and then stmt.parameters_count > 0
			positive_index: index > 0
		do
			bind_parameter (stmt,
				index,
				Parameter_directions.Sql_param_output)
		end

	put_parameter (stmt : ECLI_STATEMENT; index : INTEGER)
			-- Put parameter `index' data at execution of `stmt'.
			-- Redefine in descendant classes if needed.
			-- Useful when length of data is not known before `stmt' execution.
		require
			stmt: stmt /= Void
			positive_index: index > 0
		do
		end

feature {NONE} -- Implementation values

	is_ready_for_disposal : BOOLEAN = True

	disposal_failure_reason : STRING do	end

	parameter_directions : ECLI_PROCEDURE_TYPE_METADATA_CONSTANTS
			-- Parameter direction constants.
		once
			create Result
		end

feature {NONE} -- Implementation

	bind_parameter (stmt : ECLI_STATEMENT; index : INTEGER; direction : INTEGER)
			-- Bind as `index'-th parameter in `stmt', for `direction' transfer.
		require
			stmt_not_void: stmt /= Void
			valid_index: index >= 1 and index <= stmt.parameters_count
			valid_direction: valid_directions.has (direction)
		do
			stmt.set_status ("ecli_c_bind_parameter", ecli_c_bind_parameter (stmt.handle,
				index,
				direction,
				c_type_code,
				sql_type_code,
				size,
				decimal_digits,
				to_external,
				transfer_octet_length,
				length_indicator_pointer))
		end

	valid_directions : ARRAY[INTEGER]
		once
			Result := << parameter_directions.sql_param_input,
						 parameter_directions.sql_param_input_output,
						 parameter_directions.sql_param_output >>
		end

invariant
	is_valid: is_valid

end
