indexing
	description	: "System's root class"
    cluster: 	"ecurses, spec, remote_access, server"
    status: 	"See notice at do end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	ROOT_CLASS
   
creation {ANY} 
   make

feature {ANY} 
   
   make is 
   			-- Initialize
      do      	
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
--			client_socket.receive_string (input_buffer)
--			!!client_message.make_from_string (input_buffer.substring(1,client_socket.bytes_received))
--			
--          curses_adapter.call_feature (client_message.feature_identifier, client_message.arguments)
		
--			!!server_message.make (curses_adapter.last_results)
--			client_socket.send_string (server_message.to_string)


			server_turn.wait
			request := shared_memory.item
			!!client_message.make_from_string (request)
        	curses_adapter.call_feature (client_message.feature_identifier, client_message.arguments)

			!!server_message.make (curses_adapter.last_results)
			shared_memory.put (server_message.to_string)
			client_turn.release (1)
		end


feature {NONE} --Implementation
			
	client_turn: WIN_SEMAPHORE
			-- Semaphore for client turn.
			
	server_turn: WIN_SEMAPHORE
			-- Semaphore for server turn.
			
	shared_memory: WIN_SHARED_MEMORY
			-- Shared memory for message exchange.
	
	curses_adapter: RCURSES_ADAPTER

end -- class ROOT_CLASS

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
