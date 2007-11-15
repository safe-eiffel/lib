indexing
	description	: "System's root class"
    cluster: 	"ecurses, spec, remote_access, server"
    status: 	"See notice at do end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	ROOT_CLASS

inherit 
   YAES_HELPER
   
create {ANY} 
   make

feature {ANY} 
   
   make is 
   			-- Initialize
      do      	
      		!!curses_adapter.make   		
            !!server_socket.make(port, 1);
            io.put_string("waiting...%N");
            client_socket := server_socket.wait_for_new_connection;
            io.put_string("got client...%N");
            
            from
            	!!input_buffer.make (4000)
		        input_buffer.fill_blank 	
            until
            	false
            loop
				process_request
            end

            client_socket.disconnect;                   
      end


	process_request is
			-- Send a request for feature `a_feature_identifier' with `arguments'.
		local
			client_message: RCURSES_CLIENT_MESSAGE
			server_message: RCURSES_SERVER_MESSAGE
		do
			client_socket.receive_string (input_buffer)
			!!client_message.make_from_string (input_buffer.substring(1,client_socket.bytes_received))
			
            		curses_adapter.call_feature (client_message)
		
			client_socket.send_string (curses_adapter.last_server_message.to_string)
		end


feature {NONE} -- Implementation

	input_buffer: STRING
	
	curses_adapter: CURSES_ADAPTER

    port: INTEGER is 4000

    server_socket: TCP_SERVER_SOCKET

    client_socket: TCP_SOCKET

end -- class ROOT_CLASS

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
