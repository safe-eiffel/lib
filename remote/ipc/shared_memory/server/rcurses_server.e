indexing
	description	: "System's root class"
    cluster: 	"ecurses, spec, remote_access, server"
    status: 	"See notice at do end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	RCURSES_SERVER

inherit 
   YAES_HELPER
   
creation {ANY} 
   make

feature {ANY} 
   
   make is 
   			-- Initialize
      do      	
      		!!curses_adapter.make   		
      end


	process_request is
			-- Send a request for feature `a_feature_identifier' with `arguments'.
		local
			client_message: RCURSES_CLIENT_MESSAGE
			server_message: RCURSES_SERVER_MESSAGE
		do
		end


feature {NONE} -- Implementation

	input_buffer: STRING
	
	curses_adapter: CURSES_ADAPTER

end -- class ROOT_CLASS

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
