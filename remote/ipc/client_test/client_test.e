indexing
	description	: "System's root class"
    cluster: 	"ecurses, spec, remote_access, server"
    status: 	"See notice at do end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	CLIENT_TEST

   
create {ANY} 
   make

feature {ANY} 
   
   make is 
   			-- Initialize
		local
			client_turn, server_turn: WIN_SEMAPHORE
			i: INTEGER
			shared_memory: WIN_SHARED_MEMORY
			s: STRING
      do		
	  	from
	  		i := 0
	  	
	  		create server_turn.make ("ECURSES_SERVER_TURN")
			server_turn.create_only (1,  1)
			
			server_turn.wait
			
			create client_turn.make ("ECURSES_CLIENT_TURN")
		  	client_turn.create_only (1, 1)

			create shared_memory.make ("ECURSES_SHARED_MEMORY")
			shared_memory.create_map
			
		until
			i = 10
		loop
			i := i + 1

			client_turn.wait
			io.print ("Client: send request: " + i.out + "%N")
			shared_memory.put ("request " + i.out + "%N")
			server_turn.release (1)

			client_turn.wait
			print ("Client: got " + shared_memory.item)  
			client_turn.release (1)
		end

			client_turn.wait
			shared_memory.put ("EXIT")
			server_turn.release (1)

			shared_memory.close_map
			
			io.read_line
			
      end



end -- class CLIENT_TEST

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
