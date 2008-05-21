indexing
	description: "Objects that sends messages to an rcurses server using a shared memory implementation"
    cluster: 	"ecurses, spec, remote_access"
    status: 	"See notice at end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	RCURSES_CLIENT
	
create
	make
	
feature {NONE} -- Initialize

	make is
			-- Initialization
		local
			shell_command: UT_SHELL_COMMAND		
		do

--			create shell_command.make ("rcurses")
--			shell_command.execute 						

	  		create server_turn.make ("ECURSES_SERVER_TURN")
			server_turn.create_only (1,  1)
			server_turn.wait
			
			create client_turn.make ("ECURSES_CLIENT_TURN")
		  	client_turn.create_only (1, 1)

			create shared_memory.make ("ECURSES_SHARED_MEMORY")
			shared_memory.create_map

		end
	
feature -- Access

	last_results: ARRAY[STRING]
	
feature -- Basic operations
	
	send_request (a_feature_identifier: INTEGER; arguments: ARRAY [ANY]) is
			-- Send a request for feature `a_feature_identifier' with `arguments'.
		local
			client_message: RCURSES_CLIENT_MESSAGE
			server_message: RCURSES_SERVER_MESSAGE
		do
			client_turn.wait
			create client_message.make (a_feature_identifier, arguments)
			shared_memory.put (client_message.to_string)
			server_turn.release (1)
			
			client_turn.wait
			create server_message.make_from_string (shared_memory.item)
			last_results := server_message.results			
			client_turn.release (1)			
		end

feature {NONE} --Implementation
			
	client_turn: WIN_SEMAPHORE
			-- Semaphore for client turn.
			
	server_turn: WIN_SEMAPHORE
			-- Semaphore for server turn.
			
	shared_memory: WIN_SHARED_MEMORY
			-- Shared memory for message exchange.
			
end -- class RCURSES_CLIENT

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
