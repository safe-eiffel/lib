indexing
	description: "Objects that sends messages to an rcurses server using a socket implementation"
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
		do
	        print ("connecting...%N")
            !!socket.make_connecting_to_port("", 4000)
            print ("err: ")
            print (socket.last_error_code)
            print ("%N")
            socket.set_timeout(1000)
            !!input_buffer.make (4000)
            input_buffer.fill_blank
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
			!!client_message.make (a_feature_identifier, arguments)
			socket.send_string (client_message.to_string)

			socket.receive_string (input_buffer)
			!!server_message.make_from_string (input_buffer.substring( 1, socket.bytes_received))
			last_results := server_message.results
		end

feature {NONE} --Implementation

    socket: TCP_SOCKET;
			-- Socket
			
	input_buffer: STRING
			-- Buffer for received messages.
			
end -- class RCURSES_CLIENT

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
