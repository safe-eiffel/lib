indexing
	description:

		"Objects that search the database repository for columns of a table. %
		%Search criterias are (1) catalog name, (2) schema name, (3) table name.%
		%A Void criteria is considered as a wildcard."

	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	ECLI_COLUMNS_CURSOR

inherit
	ECLI_METADATA_CURSOR
		rename
			queried_name as queried_table
		redefine
			item, impl_item, make
		end

	ECLI_EXTERNAL_TOOLS
		export
			{NONE} all
		undefine
			dispose
		end

creation
	make_all_columns, make -- , make_by_type

feature {NONE} -- Initialization

	make_all_columns (a_session : ECLI_SESSION; a_table : STRING) is
			-- make cursor on all columns of `a_table'
		obsolete
			"Use `make' or `make_by_column'"
		require
			session_opened: a_session /= Void and then a_session.is_connected
			a_table_not_void: a_table /= Void
		local
			search_criteria : ECLI_NAMED_METADATA
		do
			!!search_criteria.make (Void, Void, a_table)
			make (search_criteria, a_session)
			queried_column := Void
		ensure
			executed: is_ok implies is_executed
		end

	make_one_column (a_search_criteria : ECLI_NAMED_METADATA; a_column_name : STRING; a_session : ECLI_SESSION) is
			-- search for column whose name matches `a_search_criteria' and `a_column_name'
			-- Void values are wildcards
		do
			make (a_search_criteria, a_session)
			queried_column := a_column_name
		end

	make (a_name: ECLI_NAMED_METADATA; a_session: ECLI_SESSION)	is
		do
			queried_column := Void
			Precursor (a_name, a_session)
		end

feature -- Access

	queried_column : STRING

	item : ECLI_COLUMN is
			-- current type description
		do
			Result := impl_item
		end

feature -- Cursor Movement

	create_item is
			--
		do
			if not off then
				!!impl_item.make (Current)
			else
				impl_item := Void
			end
		end

feature {ECLI_COLUMN} -- Access

		buffer_table_cat : ECLI_VARCHAR
		buffer_table_schem  : ECLI_VARCHAR
		buffer_table_name  : ECLI_VARCHAR
		buffer_column_name : ECLI_VARCHAR
		buffer_data_type : ECLI_INTEGER
		buffer_type_name : ECLI_VARCHAR
		buffer_column_size : ECLI_INTEGER
		buffer_buffer_length : ECLI_INTEGER
		buffer_decimal_digits : ECLI_INTEGER
		buffer_num_prec_radix : ECLI_INTEGER
		buffer_nullable : ECLI_INTEGER
		buffer_remarks : ECLI_VARCHAR
		buffer_column_def : ECLI_VARCHAR
		buffer_sql_data_type : ECLI_INTEGER
		buffer_sql_datetime_sub : ECLI_INTEGER
		buffer_char_octet_length : ECLI_INTEGER
		buffer_ordinal_position : ECLI_INTEGER
		buffer_is_nullable : ECLI_VARCHAR

feature -- Basic operations

feature {NONE} -- Implementation

		create_buffers is
				-- create buffers for cursor
		do
			create buffer_table_cat.make (255)
			create buffer_table_schem.make (255)
			create buffer_table_name.make (255)
			create buffer_column_name.make (255)
			create buffer_data_type.make
			create buffer_type_name.make (255)
			create buffer_column_size.make
			create buffer_buffer_length.make
			create buffer_decimal_digits.make
			create buffer_num_prec_radix.make
			create buffer_nullable.make
			create buffer_remarks.make (255)
			create buffer_column_def.make (255)
			create buffer_sql_data_type.make
			create buffer_sql_datetime_sub.make
			create buffer_char_octet_length.make
			create buffer_ordinal_position.make
			create buffer_is_nullable.make (255)

			set_cursor (<<
				buffer_table_cat,
				buffer_table_schem,
				buffer_table_name,
				buffer_column_name,
				buffer_data_type,
				buffer_type_name,
				buffer_column_size,
				buffer_buffer_length,
				buffer_decimal_digits,
				buffer_num_prec_radix,
				buffer_nullable,
				buffer_remarks,
				buffer_column_def,
				buffer_sql_data_type,
				buffer_sql_datetime_sub,
				buffer_char_octet_length,
				buffer_ordinal_position,
				buffer_is_nullable
				>>)
		end

	impl_item : like item

	definition : STRING is once Result := "SQLColumns" end

	do_query_metadata (a_catalog: POINTER; a_catalog_length: INTEGER; a_schema: POINTER; a_schema_length: INTEGER; a_name: POINTER; a_name_length: INTEGER) : INTEGER is
			--
		local
			a_column : POINTER
			a_column_length : INTEGER
		do
			check is_protected end
			if queried_column /= Void then
				a_column := string_to_pointer (queried_column)
				a_column_length := queried_column.count
			end
			Result := ecli_c_get_columns ( handle,
				a_catalog, a_catalog_length,
				a_schema, a_schema_length,
				a_name, a_name_length,
				a_column, a_column_length)
		end

end -- class ECLI_COLUMNS_CURSOR