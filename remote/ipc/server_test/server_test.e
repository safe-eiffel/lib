indexing
	description	: "System's root class"
    cluster: 	"ecurses, spec, remote_access, server"
    status: 	"See notice at do end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	SERVER_TEST

   
create {ANY} 
   make

feature {ANY} 
   
	make is 
   			-- Initialize
		local
			client_turn: WIN_SEMAPHORE
			server_turn: WIN_SEMAPHORE
			shared_memory: WIN_SHARED_MEMORY
			i: INTEGER
			request: STRING
			terminate: BOOLEAN
		do
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
				i := 0
				terminate := False
			until
				terminate
			loop
				i := i + 1
				server_turn.wait
				request := shared_memory.item
				io.print ("Server: got " + request)
				if request.is_equal ("EXIT")  then
					terminate := True
				else
					print ("Server: return result " + i.out+ "%N")					
					shared_memory.put ("result " + i.out+ "%N")
				end
				client_turn.release (1)
			end

			shared_memory.close_map
			
			io.read_line
		
      end


end -- class SERVER_TEST

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
