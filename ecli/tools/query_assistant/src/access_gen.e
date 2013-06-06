note
	description	: "Access Modules generators"

	library: "Access_gen : Access Modules Generators utilities"

	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

	todo: "[
		* fully implement get_options
		* take into account -ecma367 execution flag
		]"


class
	ACCESS_GEN

inherit

	KL_SHARED_ARGUMENTS
	KL_SHARED_STANDARD_FILES
	KL_SHARED_FILE_SYSTEM

	SHARED_CATALOG_NAME
	SHARED_SCHEMA_NAME
	SHARED_COLUMNS_REPOSITORY
	SHARED_MAXIMUM_LENGTH
	SHARED_TYPE_USAGE

create

	make

feature {NONE} -- Initialization

	make
			-- generate access modules
		local
			adapter : ACCESS_MODULE_PERSISTENCE_ADAPTER
		do
			Arguments.set_program_name ("query_assistant")
			create_error_handler
			print_prologue
			process_arguments
			if not has_error then
				if default_catalog /= Void then
					set_shared_catalog_name (default_catalog)
				end
				if default_schema /= Void then
					set_shared_schema_name (default_schema)
				end
				create adapter.make (error_handler)
				adapter.read_from_file (in_filename)
				if not adapter.has_error then
					error_handler.report_processing_file (in_filename)
					module := adapter.last_object
					check_modules
					resolve_parent_classes
					generate_modules
				end
			end
		end

feature -- Access

	access_routines_prefix: STRING
			-- prefix for naming the access_routines class

	version : STRING = "v1.7.2"

feature -- Element change

	set_access_routines_prefix (a_access_routines_prefix: STRING)
			-- Set `access_routines_prefix' to `a_access_routines_prefix'.
		do
			access_routines_prefix := a_access_routines_prefix
		ensure
			access_routines_prefix_assigned: access_routines_prefix = a_access_routines_prefix
		end

feature -- Access (Command line arguments)

	in_filename: STRING
			-- Name of the input file

	option_in_filename : AP_STRING_OPTION

	out_directory: STRING
			-- Name of the output file (see use_std_out)

	option_out_directory : AP_STRING_OPTION

	dsn : STRING
			-- data source name

	option_dsn : AP_STRING_OPTION

	user : STRING
			-- user name

	option_user : AP_STRING_OPTION

	password : STRING
			-- password

	option_password  : AP_STRING_OPTION

	class_filter : STRING
			-- class name to generate

	option_class_filter : AP_STRING_OPTION

	default_catalog : STRING
			-- default catalog for metadata queries

	option_default_catalog  : AP_STRING_OPTION

	default_schema : STRING
			-- default schema for metadata queries

	option_default_schema  : AP_STRING_OPTION

	maximum_length_string : STRING
			-- maximum length for long data without length limit

	option_maximum_length : AP_INTEGER_OPTION

	default_parent_cursor : STRING
			-- default parent class name for cursors.

	option_default_parent_cursor  : AP_STRING_OPTION

	default_parent_modify : STRING
			-- default parent class name for modifiers.

	option_default_parent_modify : AP_STRING_OPTION

feature -- Status report

	is_verbose : BOOLEAN

	option_is_verbose : AP_BOOLEAN_OPTION

	is_ecma367v2 : BOOLEAN

	option_is_ecma367v2 : AP_BOOLEAN_OPTION

	no_prototypes : BOOLEAN
		-- Does Current not generate function prototypes in class skeletons?

	option_no_prototypes : AP_BOOLEAN_OPTION

	allow_integer_64 : BOOLEAN
		-- Does Current allow generation of INTEGER_64 ?

	option_allow_integer_64  : AP_BOOLEAN_OPTION

	allow_decimal : BOOLEAN
		-- Does Current allow generation of MA_DECIMAL ?

	option_allow_decimal  : AP_BOOLEAN_OPTION

	straigth_option : BOOLEAN
			-- straigth factory option (i.e. no intelligence in type resolution).

	option_straight_option  : AP_BOOLEAN_OPTION

	force_string_option : BOOLEAN
			-- force string factory option (i.e. STRING_LONGVARCHAR type for any *CHAR* data type)

	option_force_string_option : AP_BOOLEAN_OPTION

	option_force_decimal_option : AP_BOOLEAN_OPTION

feature -- Constants

	reasonable_maximum_length : INTEGER = 1_000_000

feature -- Access (generation)

	error_handler: QA_ERROR_HANDLER
			-- Error handler

	module : ACCESS_MODULE

	parent_parameter_sets : DS_HASH_TABLE[PARENT_COLUMN_SET[RDBMS_ACCESS_PARAMETER], STRING]

	parent_result_sets : DS_HASH_TABLE[PARENT_COLUMN_SET[RDBMS_ACCESS_RESULT],STRING]

	all_parents_set : DS_HASH_TABLE[PARENT_COLUMN_SET[RDBMS_ACCESS_METADATA], STRING]

	all_sets : DS_HASH_TABLE[COLUMN_SET[RDBMS_ACCESS_METADATA],STRING]

feature -- Status report

	has_error: BOOLEAN
			-- has an error occurred during processing?

feature -- Basic operations

	create_error_handler
		do
			create error_handler.make_standard
		end

	print_prologue
			-- print application prologue
		do
			error_handler.report_banner (version)
			error_handler.report_copyright ("Paul G. Crismer and others", "2001-2008")
			error_handler.report_license ("Eiffel Forum", "2.0")
		end

	process_arguments
			-- Read and check command line arguments.
		do
			parse_arguments
			verify_arguments
		ensure
			in_filename_not_void: not has_error implies in_filename /= Void
		end

	create_argument_parser
		do
				create option_in_filename.make_with_long_form("input")
				option_in_filename.set_description (" Name of the input file")
				option_in_filename.enable_mandatory
				argument_parser.options.force_last (option_in_filename)

				create option_out_directory.make_with_long_form("output_dir")
				option_out_directory.set_description (" Name of the output directory")
				option_out_directory.enable_mandatory
				argument_parser.options.force_last (option_out_directory)

				create option_dsn.make_with_long_form("dsn")
				option_dsn.set_description (" data source name")
				option_dsn.enable_mandatory
				argument_parser.options.force_last (option_dsn)

				create option_user.make_with_long_form("user")
				option_user.set_description (" user name")
				option_user.enable_mandatory
				argument_parser.options.force_last (option_user)

				create option_password.make_with_long_form("pwd")
				option_password.set_description (" password")
				option_password.enable_mandatory
				argument_parser.options.force_last (option_password)

				create option_class_filter.make_with_long_form("class")
				option_class_filter.set_description (" class name to filter and generate")
				argument_parser.options.force_last (option_class_filter)

				create option_default_catalog.make_with_long_form("catalog")
				option_default_catalog.set_description (" default catalog for metadata queries")
				argument_parser.options.force_last (option_default_catalog)

				create option_default_schema.make_with_long_form("schema")
				option_default_schema.set_description (" default schema for metadata queries")
				argument_parser.options.force_last (option_default_schema)

				create option_maximum_length.make_with_long_form("maximum_length")
				option_maximum_length.set_description (" maximum length for long data without length limit")
				argument_parser.options.force_last (option_maximum_length)

				create option_default_parent_cursor.make_with_long_form("parent_cursor")
				option_default_parent_cursor.set_description (" default parent class name for cursors.")
				argument_parser.options.force_last (option_default_parent_cursor)

				create option_default_parent_modify.make_with_long_form("parent_modify")
				option_default_parent_modify.set_description (" default parent class name for modifiers.")
				argument_parser.options.force_last (option_default_parent_modify)

				create option_is_verbose.make_with_long_form("verbose")
				argument_parser.options.force_last (option_is_verbose)

				create option_no_prototypes.make_with_long_form("no_prototypes")
				option_no_prototypes.set_description (" Does Current not generate function prototypes in class skeletons?")
				argument_parser.options.force_last (option_no_prototypes)

				create option_allow_integer_64.make_with_long_form("allow_integer_64")
				option_allow_integer_64.set_description (" Does Current allow generation of INTEGER_64 ?")
				argument_parser.options.force_last (option_allow_integer_64)

				create option_allow_decimal.make_with_long_form("allow_decimal")
				option_allow_decimal.set_description (" Does Current allow generation of MA_DECIMAL ?")
				argument_parser.options.force_last (option_allow_decimal)

				create option_straight_option.make_with_long_form("dumb")
				option_straight_option.set_description (" dumb factory option (i.e. no intelligence in type resolution).")
				argument_parser.options.force_last (option_straight_option)

				create option_force_string_option.make_with_long_form("force_string")
				option_force_string_option.set_description (" force string factory option (i.e. ECLI_STRING_LONGVARCHAR type for any *CHAR* data type)")
				argument_parser.options.force_last (option_force_string_option)

				create option_force_decimal_option.make_with_long_form ("force_decimal")
				option_force_decimal_option.set_description (" force MA_DECIMAL for all numeric types")
				argument_parser.options.force_last (option_force_decimal_option)

				create option_is_ecma367v2.make_with_long_form ("ecma367")
				option_is_ecma367v2.set_description (" use ECMA367v2 syntax for generated files")
				argument_parser.options.force_last (option_is_ecma367v2)

		end

	get_options
		do
				-- Mandatory
				in_filename := option_in_filename.parameter
				out_directory := option_out_directory.parameter
				dsn := option_dsn.parameter
				user := option_user.parameter
				password := option_password.parameter

				-- Optional
				if option_class_filter.was_found then
					class_filter := option_class_filter.parameter
				end
				if option_default_catalog.was_found then
					default_catalog := option_default_catalog.parameter
				end
				if option_default_schema.was_found then
					default_schema := option_default_schema.parameter
				end
				if option_maximum_length.was_found then
					if option_maximum_length.parameter < 200 then
						error_handler.report_invalid_argument ("maximum_length", "should be a positive integer greater or equal to 200")
					else
						set_maximum_length (option_maximum_length.parameter)
					end
				else
					set_maximum_length (reasonable_maximum_length)
				end

				create option_default_parent_cursor.make_with_long_form("parent_cursor")
				option_default_parent_cursor.set_description (" default parent class name for cursors.")
				argument_parser.options.force_last (option_default_parent_cursor)

				create option_default_parent_modify.make_with_long_form("parent_modify")
				option_default_parent_modify.set_description (" default parent class name for modifiers.")
				argument_parser.options.force_last (option_default_parent_modify)

				create option_is_verbose.make_with_long_form("verbose")
				argument_parser.options.force_last (option_is_verbose)

				create option_no_prototypes.make_with_long_form("no_prototypes")
				option_no_prototypes.set_description (" Does Current not generate function prototypes in class skeletons?")
				argument_parser.options.force_last (option_no_prototypes)

				create option_allow_integer_64.make_with_long_form("allow_integer_64")
				option_allow_integer_64.set_description (" Does Current allow generation of INTEGER_64 ?")
				argument_parser.options.force_last (option_allow_integer_64)

				create option_allow_decimal.make_with_long_form("allow_decimal")
				option_allow_decimal.set_description (" Does Current allow generation of MA_DECIMAL ?")
				argument_parser.options.force_last (option_allow_decimal)

				create option_straight_option.make_with_long_form("dumb")
				option_straight_option.set_description (" dumb factory option (i.e. no intelligence in type resolution).")
				argument_parser.options.force_last (option_straight_option)

				create option_force_string_option.make_with_long_form("force_string")
				option_force_string_option.set_description (" force string factory option (i.e. ECLI_STRING_LONGVARCHAR type for any *CHAR* data type)")
				argument_parser.options.force_last (option_force_string_option)

				create option_force_decimal_option.make_with_long_form ("force_decimal")
				option_force_decimal_option.set_description (" force MA_DECIMAL for all numeric types")
				argument_parser.options.force_last (option_force_decimal_option)

		end

	parse_arguments
			-- Parse command line arguments.
		local
			key : STRING
			arg_index : INTEGER
			value : STRING
		do
			from
				arg_index := 1
			until
				arg_index > Arguments.argument_count
			loop
				key := Arguments.argument (arg_index)
				if arg_index + 1 <= Arguments.argument_count then
					value := Arguments.argument (arg_index + 1).twin
				else
					value := Void
				end
				if key.is_equal ("-input") then
					in_filename := value
					arg_index := arg_index + 2
				elseif key.is_equal ("-expat") then
					arg_index := arg_index + 1
				elseif key.is_equal ("-eiffel") then
					arg_index := arg_index + 1
				elseif key.is_equal ("-verbose") then
					is_verbose := True
					arg_index := arg_index + 1
				elseif key.is_equal ("-dsn") then
					dsn := value
					arg_index := arg_index + 2
				elseif key.is_equal ("-user") then
					user := value
					arg_index := arg_index + 2
				elseif key.is_equal ("-pwd") then
					password := value
					arg_index := arg_index + 2
				elseif key.is_equal ("-output_dir") or else key.is_equal ("-output") then
					out_directory := value
					arg_index := arg_index + 2
				elseif key.is_equal ("-class") then
					class_filter := value
					arg_index := arg_index + 2
				elseif key.is_equal ("-schema") then
					default_schema := value
					arg_index := arg_index + 2
				elseif key.is_equal ("-catalog") then
					default_catalog := value
					arg_index := arg_index + 2
				elseif key.is_equal ("-access_routines_prefix") then
					set_access_routines_prefix (value)
					arg_index := arg_index + 2
				elseif key.is_equal ("-parent_cursor") then
					default_parent_cursor := value
					arg_index := arg_index + 2
				elseif key.is_equal ("-parent_modify") then
					default_parent_modify := value
					arg_index := arg_index + 2
				elseif key.is_equal ("-max_length") then
					maximum_length_string := value
					arg_index := arg_index + 2
				elseif key.is_equal ("-use_decimal") or else key.is_equal ("-force_decimal") then
					set_force_decimal (True)
					arg_index := arg_index + 1
				elseif key.is_equal ("-allow_integer_64") then
					allow_integer_64 := True
					arg_index := arg_index + 1
				elseif key.is_equal ("-allow_decimal") then
					allow_decimal := True
					arg_index := arg_index + 1
				elseif key.is_equal ("-straigth") then
					straigth_option := True
					arg_index := arg_index + 1
				elseif key.is_equal ("-force_string") then
					force_string_option := True
					arg_index := arg_index + 1
				elseif key.is_equal ("-no_prototypes") or else key.is_equal ("-no_prototype") then
					no_prototypes := True
					arg_index := arg_index + 1
				else
					arg_index := arg_index + 1
					error_handler.report_invalid_argument (key, "name unknown")
				end
			end
		end

	verify_arguments
			-- Verify parsed arguments.
		local
			error_message : STRING
			type_catalog : ECLI_TYPE_CATALOG
		do
			-- Create standard pipe holder and bind it to event parser.
			has_error := False
			create error_message.make (0)
			if user = Void then
				has_error := True
				error_handler.report_missing_argument ("-user", "a user name must be specified")
			end
			if password = Void then
				has_error := True
				error_handler.report_missing_argument ("-pwd", "a password must be specified")
			end
			if dsn = Void then
				has_error := True
				error_handler.report_missing_argument ("-dsn", "a data source name must be specified")
			end
			if in_filename = Void then
				has_error := True
				error_handler.report_missing_argument ("-input", "an input file name must be specified")
			elseif not File_system.file_exists (in_filename) then
				has_error := True
				error_handler.report_invalid_argument ("-input", "file '"+in_filename+"' does not exist")
			end
			if out_directory = Void then
				has_error := True
				error_handler.report_missing_argument ("-output", "an output directory must be specified")
			elseif not File_system.directory_exists (out_directory) then
				has_error := True
				error_handler.report_invalid_argument ("-output", "directory '"+out_directory+"' does not exist")

			end
			if dsn /= Void and then user /= Void and then password /= Void then
				create session.make_default
				session.set_login_strategy (create {ECLI_SIMPLE_LOGIN}.make(dsn, user, password))
				session.connect
				if session.is_connected then
					create repository.make (session)
					create type_catalog.make (session)
					set_shared_columns_repository (repository)
					if allow_decimal then
						set_use_decimal (type_catalog.can_bind (create {ECLI_DECIMAL}.make (10,2)))
					end
					if allow_integer_64 then
						set_use_integer_64 (type_catalog.can_bind (create {ECLI_INTEGER_64}.make))
					else
						set_use_integer_64 (False)
					end
				else
					error_handler.report_database_connection_failed (dsn)
					has_error := True
				end
			end
			if maximum_length_string /= Void then
				if not maximum_length_string.is_double or else maximum_length_string.to_double <= 0 then
					has_error := True
					error_handler.report_invalid_argument ("-maximum_length", "must be a strictly positive integer")
				else
					if maximum_length_string.to_double > reasonable_maximum_length then
						has_error := True
						error_handler.report_invalid_argument ("-maximum_length","Maximum length is not reasonable, the value provided is greater than "+reasonable_maximum_length.out)
					else
						set_maximum_length (maximum_length_string.to_integer)
					end
				end
			else
				set_maximum_length (reasonable_maximum_length)
			end
			if straigth_option then
				set_is_straigth_factory (straigth_option)
			end
			if force_string_option then
				set_is_string_forced (force_string_option)
			end
			if has_error and error_handler.has_missing_argument then
				error_handler.report_usage (False)
			end
			if not is_verbose then
				error_handler.disable_verbose
			end
		end

feature {NONE} -- Implementation

	argument_parser : AP_PARSER

	resolve_parent_classes
			-- resolve parent classes for parameters and result sets
		do
			resolve_parent_parameter_sets
			resolve_parent_result_sets
--			resolve_all_sets
		end

	resolve_parent_parameter_sets
			-- resolve parent classes for parameter sets
		local
			resolver : REFERENCE_RESOLVER[RDBMS_ACCESS_PARAMETER]
		do
			create resolver
			parent_parameter_sets := resolver.resolve_parents (module.parameter_sets, error_handler)
			resolver.resolve_descendants (module.parameter_sets)
		end

	resolve_parent_result_sets
			-- resolve parent classes for parameter sets
		local
			resolver : REFERENCE_RESOLVER[RDBMS_ACCESS_RESULT]
		do
			create resolver
			parent_result_sets := resolver.resolve_parents (module.result_sets, error_handler)
			resolver.resolve_descendants (module.result_sets)
		end

--	resolve_all_sets is
--			--
--		local
--			resolver : REFERENCE_RESOLVER[RDBMS_ACCESS_METADATA]
--			cursor : DS_HASH_TABLE_CURSOR[COLUMN_SET[RDBMS_ACCESS_METADATA], STRING]
--		do
--			create all_sets.make (module.result_sets.count + module.parameter_sets.count)
--			from
--				cursor := module.result_sets.new_cursor
--				cursor.start
--			until
--				cursor.off
--			loop
--				all_sets.force (cursor.item, cursor.key)
--				cursor.forth
--			end
--			from
--				cursor := module.parameter_sets.new_cursor
--				cursor.start
--			until
--				cursor.off
--			loop
--				all_sets.force (cursor.item, cursor.key)
--				cursor.forth
--			end
--			create resolver
--			all_parents_set := resolver.resolve_parents (all_sets, error_handler)
--			resolver.resolve_descendants (all_sets)
--		end


	check_modules
			-- check modules
		local
			cursor : DS_HASH_TABLE_CURSOR[RDBMS_ACCESS,STRING]
			l_name : STRING
		do
			from
				cursor := module.accesses.new_cursor
				cursor.start
			until
				cursor.off
			loop
				l_name := cursor.item.name
				if class_filter = Void or else class_filter.is_equal (cursor.item.name) then
					error_handler.report_start ("Analyzing "+cursor.item.name)
					cursor.item.check_validity (session, error_handler, Reasonable_maximum_length)
					if cursor.item.is_valid then
						error_handler.report_end ("Analyzing "+cursor.item.name,True)
						if cursor.item.has_result_set and cursor.item.is_results_valid then
							module.result_sets.force (cursor.item.results, cursor.item.results.name)
						else
							do_nothing
						end
					else
						error_handler.report_end ("Analyzing "+cursor.item.name,False)
						--| report error
					end
				end
				cursor.forth
			end
			if session.is_connected then
				session.disconnect
			else
--				error_handler.report_d ("! Error : Datasource not connected " + session.diagnostic_message)
--				Must we do something here ?
			end
			session.close
		end

	generate_modules
			-- generate modules
		local
			c : DS_HASH_TABLE_CURSOR[RDBMS_ACCESS,STRING]
			p : DS_HASH_TABLE_CURSOR[PARENT_COLUMN_SET[RDBMS_ACCESS_PARAMETER], STRING]
			r : DS_HASH_TABLE_CURSOR[PARENT_COLUMN_SET[RDBMS_ACCESS_RESULT], STRING]
		do
			error_handler.report_start ("Class generation")
			--| classes for modules
			from
				c := module.accesses.new_cursor
				c.start
			until
				c.off
			loop
				if c.item.is_valid then
					generate (c.item, error_handler)
				else
					error_handler.report_rejected (c.item.name)
				end
				c.forth
			end
			create gen.make (error_handler,version, in_filename)
			--| classes for parent parameters
			from
				p := parent_parameter_sets.new_cursor
				p.start
			until
				p.off
			loop
				if p.item.is_generatable then
					error_handler.report_start ("Generating " + p.item.name)
					gen.create_set_class (p.item)
					gen.write_class (gen.set_class, out_directory)
				else
					error_handler.report_rejected (p.item.name)
				end
				p.forth
			end
			--| classes for parent results
			from
				r := parent_result_sets.new_cursor
				r.start
			until
				r.off
			loop
				if r.item.is_generatable then
					error_handler.report_start ("Generating " + r.item.name)
					gen.create_set_class (r.item)
					gen.write_class (gen.set_class, out_directory)
				else
					error_handler.report_rejected (r.item.name)
				end
				r.forth
			end
--			--| classes for parent results
--			from
--				s := all_parents_set.new_cursor
--				s.start
--			until
--				s.off
--			loop
--				error_handler.report_start ("Generating " + s.item.name)
--				gen.create_set_class (s.item)
--				gen.write_class (gen.set_class, out_directory)
--				s.forth
--			end
			if access_routines_prefix /= Void then
				--| generate access routines
				gen.create_access_routines_class (access_routines_prefix, module.accesses, all_sets, no_prototypes)
				gen.write_class (gen.access_routines_class, out_directory)
			end
			--| FIXME : report if class generation has produced an error
			error_handler.report_end ("Class generation", True)
		end

	generate (access : RDBMS_ACCESS; a_error_handler : QA_ERROR_HANDLER)
			-- generate classes for `access', query + parameter_set + result_set classes
		require
			access_not_void: access /= Void
			access_is_generatable: access.is_generatable
		local
			parent_class : STRING
		do
			create gen.make (a_error_handler, version, in_filename)
			a_error_handler.report_generating (access.name)
			if access.has_result_set then
				parent_class := default_parent_cursor
			else
				parent_class := default_parent_modify
			end
			gen.create_cursor_class (access, parent_class)
			gen.write_class (gen.cursor_class,out_directory)
			if access.parameters.parent_name = Void or else access.parameters.local_items.count > 0 then
				if access.parameters.count > 0 then
					a_error_handler.report_generating (access.parameters.name)
					gen.create_parameters_class (access.parameters)
					gen.write_class (gen.parameters_class, out_directory)
				end
			end
			if access.has_result_set then
				if access.results.parent_name = Void or else access.results.local_items.count > 0 then
					a_error_handler.report_generating (access.results.name)
					gen.create_results_class (access.results)
					gen.write_class (gen.results_class, out_directory)
				end
			end
		end

	gen : RDBMS_ACCESS_GENERATOR

	session : ECLI_SESSION
	repository : COLUMNS_REPOSITORY

invariant

	error_handler_not_void: error_handler /= Void


end -- class ACCESS_GEN
--
-- Copyright (c) 2000-2012, Paul G. Crismer, <pgcrism@users.sourceforge.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
