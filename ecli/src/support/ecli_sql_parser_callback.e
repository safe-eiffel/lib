note

	description:

			"Objects that are called back by an ECLI_SQL_PARSER."

	library: "ECLI : Eiffel Call Level Interface (ODBC) Library. Project SAFE."
	Copyright: "Copyright (c) 2001-2012, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class ECLI_SQL_PARSER_CALLBACK

feature -- Status report

	is_valid : BOOLEAN
			--
		deferred
		end

feature -- Basic operations

	add_new_parameter (a_parameter_name : STRING; a_position : INTEGER)
		require
			valid_callback : is_valid
			a_parameter_name_not_void: a_parameter_name /= Void --FIXME: VS-DEL
			a_position_stricly_positive: a_position > 0
		deferred
		end

	on_parameter_marker (a_sql : STRING; index : INTEGER)
		require
			a_sql_not_void: a_sql /= Void --FIXME: VS-DEL
			index_positive: index > 0
			valid_index: index >= 1 and index <= a_sql.count
		deferred
		end

	on_string_literal (a_sql : STRING; i_begin, i_end : INTEGER)
		require
			a_sql_not_void: a_sql /= Void --FIXME: VS-DEL
			i_begin_positive: i_begin > 0
			i_end_positive: i_end > 0
			i_begin_le_end: i_begin <= i_end
			valid_indexes: i_begin >= 1 and i_end <= a_sql.count
		deferred
		end

	on_word (a_sql : STRING; i_begin, i_end : INTEGER)
		require
			a_sql_not_void: a_sql /= Void --FIXME: VS-DEL
			i_begin_positive: i_begin > 0
			i_end_positive: i_end > 0
			i_begin_le_end: i_begin <= i_end
			valid_indexes: i_begin >= 1 and i_end <= a_sql.count
		deferred
		end

	on_table_literal (a_sql : STRING; i_begin, i_end : INTEGER)
		require
			a_sql_not_void: a_sql /= Void --FIXME: VS-DEL
			i_begin_positive: i_begin > 0
			i_end_positive: i_end > 0
			i_begin_le_end: i_begin <= i_end
			valid_indexes: i_begin >= 1 and i_end <= a_sql.count
		deferred
		end

	on_parameter (a_sql : STRING; i_begin, i_end : INTEGER)
		require
			a_sql_not_void: a_sql /= Void --FIXME: VS-DEL
			i_begin_positive: i_begin > 0
			i_end_positive: i_end > 0
			i_begin_le_end: i_begin <= i_end
			valid_indexes: i_begin >= 1 and i_end <= a_sql.count
		deferred
		end

end
