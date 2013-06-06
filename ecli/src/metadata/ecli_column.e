note

	description:

			"Objects that describe a SQL column in a table."

	library: "ECLI : Eiffel Call Level Interface (ODBC) Library. Project SAFE."
	Copyright: "Copyright (c) 2001-2012, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class ECLI_COLUMN

inherit

	ECLI_NULLABLE_METADATA
		redefine
			out
		end

	ECLI_NAMED_METADATA
		rename
			make as make_metadata
		export {NONE} make_metadata
		undefine
			out
		end

create

	{ECLI_COLUMNS_CURSOR} make

feature {NONE} -- Initialization

	make (cursor : ECLI_COLUMNS_CURSOR)
			-- create from `cursor' current position
		require
			cursor_not_void: cursor /= Void --FIXME: VS-DEL
			cursor_not_off: not cursor.off
		do
			set_catalog (cursor.buffer_table_cat)
			set_schema (cursor.buffer_table_schem )
			if cursor.buffer_table_name.is_null then
				table := ""
			else
				table := cursor.buffer_table_name.as_string
			end
			set_name (cursor.buffer_column_name)
			type_code := cursor.buffer_data_type.as_integer
			type_name := cursor.buffer_type_name.as_string
			if not cursor.buffer_column_size.is_null then
				size := cursor.buffer_column_size.as_integer
				is_size_applicable := True
			end
			if not cursor.buffer_buffer_length.is_null then
				transfer_length := cursor.buffer_buffer_length.as_integer
				is_transfer_length_applicable := True
			end
			if not cursor.buffer_decimal_digits.is_null then
				decimal_digits := cursor.buffer_decimal_digits.as_integer
				is_decimal_digits_applicable := True
			end
			if not cursor.buffer_num_prec_radix.is_null then
				precision_radix := cursor.buffer_num_prec_radix.as_integer
				is_precision_radix_applicable := True
			end
			nullability := cursor.buffer_nullable.as_integer
			if not cursor.buffer_remarks.is_null then
				description := cursor.buffer_remarks.as_string
				is_description_applicable := True
			else
				create description.make_empty
			end
		end

feature -- Access

	table : STRING
			-- table name

	type_code : INTEGER
			-- ODBC code of SQL type

	type_name : STRING
			-- Datasource dependant type name

	size : INTEGER
			-- size, display length, number of bits, ... depending on actual datatype

	transfer_length : INTEGER
			-- maximum number of bytes to read for a transfer

	decimal_digits : INTEGER
			-- number of decimal digits if numeric type

	precision_radix : INTEGER
			-- 10 or 2 if numeric type

	description : STRING
			-- optional comments, remarks, or description regarding this column

feature -- Measurement

	is_size_applicable : BOOLEAN
			-- is this a type parameterized by a size ?

	is_transfer_length_applicable : BOOLEAN
			-- does a transfer length apply ?

	is_decimal_digits_applicable : BOOLEAN
			-- is 'decimal_digits' applicable for this type ?

	is_precision_radix_applicable : BOOLEAN
			-- is this a numeric type, where 'precision_radix' is applicable ?

	is_description_applicable : BOOLEAN
			-- is the description applicable ?
			
feature -- Conversion

	out : STRING
			-- terse visual representation
		do
			create Result.make (0)
			Result.append_string (name); Result.append_string ("%T")
			Result.append_string (type_code.out); Result.append_string ("%T")
			Result.append_string (type_name); Result.append_string ("%T")
			if is_size_applicable then
				Result.append_string ("(") Result.append_string (size.out) Result.append_string (")")
			end
			Result.append_string ("%T")
			if is_transfer_length_applicable then
				Result.append_string (transfer_length.out)
			end
			Result.append_string ("%T")
			if is_decimal_digits_applicable then
				Result.append_string (decimal_digits.out)
			end
			Result.append_string ("%T")
			if is_known_nullability then
				if is_nullable then
					Result.append_string ("NULLABLE")
				elseif is_not_nullable then
					Result.append_string ("NOT NULL")
				end
			else
				Result.append_string ("?NULLABLE?")
			end
			Result.append_string ("%T")
			if is_precision_radix_applicable then
				Result.append_string (precision_radix.out)
			end
			Result.append_string ("%T")
			if is_description_applicable then
				Result.append_string (description)
			end
		end

end

