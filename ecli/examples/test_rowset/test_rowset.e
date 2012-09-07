note
	description: "ECLI test of arrayed value classes. It allows bulk insert/retrieve in a single query execution.";
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"
class
	TEST_ROWSET

inherit

	KL_SHARED_ARGUMENTS

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all
		end
		
create

	make

feature -- Initialization

	make
		do			
			-- session opening
			parse_arguments
			if error_message /= Void then
				print_usage
			else
				-- check for mandatory parameters
				if user = Void then
					set_error ("Missing user.  Specify parameter","-user")
					print_usage
				elseif password = Void then
					set_error ("Missing password. Specify parameter","-pwd")
					print_usage
				elseif dsn = Void then
					set_error ("Missign data source name. Specify parameter", "-dsn")
					print_usage
				else
					create  session.make (dsn, user, password)
					session.connect
					if session.is_connected then
						io.put_string ("+ Connected %N")
						do_tests

						-- disconnecting and closing session
						session.disconnect
					else
						print_error (session)
					end
					session.close
				end
			end;
		end


feature -- Access

	dsn : STRING
	user: STRING
	password : STRING
	sql : STRING
	
	session : ECLI_SESSION
	
	statement : ECLI_STATEMENT
		
	error_message : STRING

	rowset_cursor: ECLI_ROWSET_CURSOR
	
feature -- Status Report

feature -- Status setting

feature -- Element change

feature -- Basic Operations

	do_tests
		local
			test : ROWSET_MODIFIER_TEST
		do
				if session.is_bind_arrayed_parameters_capable then
					create test.make (session)
				else
					io.put_string ("The current datasource does not support operations with arrayed parameters%N")
				end
		end
		
feature {NONE} -- Implementation

	parse_arguments
		local
			index : INTEGER
			current_argument : STRING
		do
			from
				index := 1
				error_message := Void
			until
				error_message /= Void or else index > Arguments.argument_count
			loop
				current_argument := Arguments.argument (index)
				if current_argument.item (1) = '-' then
					if (index + 1) <= Arguments.argument_count then
						if current_argument.is_equal ("-dsn") then
							dsn := Arguments.argument (index + 1)
						elseif current_argument.is_equal ("-user") then
							user := Arguments.argument (index + 1)
						elseif current_argument.is_equal ("-pwd") then
							password := Arguments.argument (index + 1)
						end
						index := index + 2
					else
						set_error ("Missing value for parameter",current_argument)
					end
				else
					index := index + 1
				end
			end
		end		
	
	set_error (message, value : STRING)
		do
			create error_message.make (0)
			error_message.append_string (message)
			error_message.append_string (" '")
			error_message.append_string (value)
			error_message.append_string ("'")		
		ensure
			error_message /= Void
		end
			
	print_usage
		do
			if error_message /= Void then
				io.put_string (error_message)
			io.put_new_line
			end
			io.put_string ("Usage: test_rowset -dsn <data_source> -user <user_name> -pwd <password>%N%
						%%T-dsn data_source%T%TODBC data source name%N%
						%%T-user user_name%T%Tuser name for database login%N%
						%%T-pwd password%T%Tpassword for database login%N")
		end

		
	print_error (stmt : ECLI_STATUS)
		do
			io.put_string ("** ERROR **%N")
			io.put_string (stmt.diagnostic_message)
			io.put_character ('%N')
		end
		
end -- class TEST_ROWSET
--
-- Copyright (c) 2000-2012, Paul G. Crismer, <pgcrism@users.sourceforge.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
