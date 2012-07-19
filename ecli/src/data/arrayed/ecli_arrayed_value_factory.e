indexing

	description:

			"Factory of ECLI_ARRAYED_VALUE descendant instances."

	nota_bene: "Supported SQL data types currently are : sql_char, sql_decimal, sql_double, sql_float, sql_integer, sql_longvarchar, sql_numeric, sql_real, sql_smallint, sql_type_date, sql_type_time, sql_type_timestamp,	sql_varchar"

	library: "ECLI : Eiffel Call Level Interface (ODBC) Library. Project SAFE."
	copyright: "Copyright (c) 2001-2006, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class ECLI_ARRAYED_VALUE_FACTORY

inherit

	ECLI_VALUE_FACTORY
		rename
			make as make_value
		export {NONE}
			make_value
		redefine
			last_result,
			create_double_value,
			create_real_value,
			create_integer_value,
			create_integer_64_value,
			create_time_value,
			create_timestamp_value,
			create_date_value,
			create_char_value,
			create_varchar_value,
			create_decimal_value
		end

create

	make

feature {NONE} -- Initialization

	make (a_row_count : INTEGER) is
		do
			row_count := a_row_count
		ensure
			row_count_set: row_count = a_row_count
		end

feature -- Access

	last_result : ECLI_ARRAYED_VALUE
			-- last result of `create_instance'

feature -- Measurement

	row_count : INTEGER
			-- default capacity of arrayed values

feature {NONE} -- Implementation

	create_double_value is
		do
			create {ECLI_ARRAYED_DOUBLE}last_result.make (row_count)
		end

	create_real_value is
		do
			create {ECLI_ARRAYED_REAL}last_result.make (row_count)
		end

	create_integer_value is
		do
			create {ECLI_ARRAYED_INTEGER}last_result.make (row_count)
		end

	create_integer_64_value is
		do
			create {ECLI_ARRAYED_INTEGER_64}last_result.make (row_count)
		end

	create_char_value (column_precision : INTEGER) is
		do
			create {ECLI_ARRAYED_CHAR}last_result.make (column_precision,row_count)
		end

	create_varchar_value (column_precision : INTEGER) is
		do
			if column_precision > 254 then
				create {ECLI_ARRAYED_LONGVARCHAR}last_result.make (column_precision,row_count)
			else
				create {ECLI_ARRAYED_VARCHAR}last_result.make (column_precision, row_count)
			end
		end

	create_date_value is
		do
			create {ECLI_ARRAYED_DATE}last_result.make (row_count)
		end

	create_timestamp_value is
		do
			create {ECLI_ARRAYED_TIMESTAMP}last_result.make (row_count)
		end

	create_time_value is
		do
			create {ECLI_ARRAYED_TIME}last_result.make (row_count)
		end

	create_decimal_value (precision, decimal_digits: INTEGER_32) is
		do
			create {ECLI_ARRAYED_DECIMAL} last_result.make (row_count, precision, decimal_digits)
		end

end
