indexing
	description	: "System's root class"
    cluster: 	"ecurses, spec, remote_access, server"
    status: 	"See notice at do end of class"
    refactor:   "common features with socket implementation should be factored out"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	ROOT_CLASS
	
inherit
	CURSES_APPLICATION
		rename
			last_error as ectk_application_last_error
		export
			{NONE} all
		undefine
			default_rescue							
		end

	KL_SHARED_ARGUMENTS
		undefine
			default_rescue							
		end

		
	UT_APPLICATION_STATUS_SINGLETON_ACCESSOR		
		export
			{NONE} all
		end

	UT_APPLICATION_LAUNCHER
		export
			{NONE} all
		undefine
			default_rescue							
		end
		
	KL_IMPORTED_OUTPUT_STREAM_ROUTINES
		export
			{NONE} all
		undefine
			default_rescue				
		end
		
	ANY
		undefine
			default_rescue
		end
		   
creation
   make

feature {ANY} 
   
   make is 
   			-- Initialize
      do
      			parse_arguments
      			application_status_singleton.enable_error_stack_trace
      			initialize_error_file
      	
      			if is_trace_enabled then
      				trace_file := OUTPUT_STREAM_.make_file_open_write ("server.tra")
      			end
      
			!!curses_adapter.make
		
	  		from
				!!client_turn.make ("ECURSES_CLIENT_TURN")
			until
				client_turn.is_open
			loop
				client_turn.open
			end

	  		from
				!!server_turn.make ("ECURSES_SERVER_TURN")
			until
				server_turn.is_open
			loop
				server_turn.open
			end

			!!shared_memory.make ("ECURSES_SHARED_MEMORY")
			shared_memory.open_map
			
			from
				
			until
				false
			loop
				process_request 	 
			end
			
      end


	process_request is
			-- Send a request for feature `a_feature_identifier' with `arguments'.
		local
			client_message: RCURSES_CLIENT_MESSAGE
			server_message: RCURSES_SERVER_MESSAGE
			request: STRING
		do
			server_turn.wait
			request := shared_memory.item

			!!client_message.make_from_string (request)
			if is_trace_enabled then
				trace_call (client_message)
			end
			
        		curses_adapter.call_feature (client_message)

			server_message := curses_adapter.last_server_message
			if is_trace_enabled then
				trace_results (server_message)
				trace_server_state
			end
			shared_memory.put (server_message.to_string)
			
			client_turn.release (1)
		end


feature {NONE} --Implementation

	parse_arguments is
		local
			index : INTEGER
			current_argument : STRING
		do
			from
				index := 1
			until
				index > Arguments.argument_count
			loop
				current_argument := Arguments.argument (index)
				if current_argument.item (1) = '-' then					
					if current_argument.is_equal ("-trace") then
						is_trace_enabled := True
					end
				end
				index := index + 1
			end
		end		


	initialize_error_file is
			-- Initialize the file for the error messages.
		local
			file: like OUTPUT_STREAM_TYPE
		do
			file := OUTPUT_STREAM_.make_file_open_write ("server.log")
			application_status_singleton.shared_error_handler.set_error_file (file)
			application_status_singleton.shared_error_handler.set_warning_file (file)
			application_status_singleton.shared_error_handler.set_message_file (file)
		end


	trace_call (a_client_message: RCURSES_CLIENT_MESSAGE) is
		require
			message_defined: a_client_message /= Void
		do
			trace_file.put_string (a_client_message.trace_output)
		end

	trace_results (a_server_message: RCURSES_SERVER_MESSAGE) is
		require
			message_defined: a_server_message /= Void
		do
			trace_file.put_string (" = ")
			trace_file.put_string (a_server_message.trace_output)
			trace_file.put_string ("%N")
		end

	trace_server_state is
			-- Dump the state of the server.
		do
			trace_file.put_string ("  pointers table = " + curses_adapter.pointers_table_dump)
			trace_file.put_string ("%N")
		end


	is_trace_enabled: BOOLEAN
			-- Is the trace option enabled.

	trace_file: like OUTPUT_STREAM_TYPE
			-- Trace file for feature calls.
			
	client_turn: WIN_SEMAPHORE
			-- Semaphore for client turn.
			
	server_turn: WIN_SEMAPHORE
			-- Semaphore for server turn.
			
	shared_memory: WIN_SHARED_MEMORY
			-- Shared memory for message exchange.
	
	curses_adapter: RCURSES_ADAPTER
			-- Adapter from client messages to feature calls.
	
end -- class ROOT_CLASS

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
