indexing
	description: "Objects that let threads synchronize "

	usage: "Coordinating mutually exclusive access to a shared resource. "
	refactoring: ""

	status: "see notice at end of class";
	date: "$ Date: $";
	revision: "$ Revision: $";
	author: ""

class
	WIN_MUTEX

creation
	make
	
feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Initialize with `a_name'.
		do
			name := a_name
		ensure
			shared_name: name = a_name
			not_is_open: not is_open
			not_is_owner: not is_owner
		end		

feature -- Access

	name: STRING
			-- Name of system mutex.
			
feature -- Measurement

feature -- Comparison

feature -- Status report

	is_open: BOOLEAN
			-- Is the mutex open
			
	is_owner: BOOLEAN
			-- Does the current process own the mutex?
			
	last_status: INTEGER
			-- Last status.
			
feature -- Status setting
	
feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations


	create_and_own is
			-- Create and own the mutex.
		require
			not_is_open: not is_open
		local
			p: POINTER
			a: ANY
		do
			a := name.to_c
			p := $a
			handle := ipc_mutex_create_and_lock (p)
			is_open := True
			is_owner := True
		ensure
			is_open: is_open
			is_owner: is_owner
		end


	create_only is
			-- Create (without owning)
		require
			not_is_open: not is_open
		local
			p: POINTER
			a: ANY
		do
			a := name.to_c
			p := $a
			handle := ipc_mutex_create (p)
			is_open := True
		ensure
			is_open: is_open
		end
		

	wait_for_ownership is
			-- Wait for ownership.
		require
			is_open: is_open
		do
			last_status := ipc_wait_for_lock (handle)
			is_owner := True
		ensure
			is_open: is_open
			is_owner: is_owner
		end
		
	release is
			-- Release lock.
		require
			is_open: is_open
			is_owner: is_owner
		do
			last_status := ipc_mutex_release (handle)
			is_owner := False
		ensure
			is_open: is_open
			not_is_owner: not is_owner
		end
	
	open is
			-- Open mutex.
		require
			not_is_open: not is_open
		local
			p: POINTER
			a: ANY
		do
			a := name.to_c
			p := $a
			last_status := ipc_mutex_open (p)
			if  last_status /= 0 then
				is_open := True
			end
		ensure
			-- mutex exists implies is_open
		end
		
	close is
			-- Close.
		require
			is_open: is_open
		do
			last_status := ipc_close (handle)
			is_open := False
		ensure
			closed: not is_open
		end

feature -- Obsolete

feature -- Inapplicable

feature -- Constants

feature {NONE} -- Implementation
  
	ipc_mutex_create_and_lock (c_name: POINTER): INTEGER is
		external "C" 
		end

	ipc_mutex_create (c_name: POINTER): INTEGER is
		external "C" 
		end

	ipc_mutex_open (c_name: POINTER): INTEGER is
		external "C" 
		end

	ipc_wait_for_lock (c_handle: INTEGER): INTEGER is
		external "C"
		end
	
	ipc_mutex_release (c_handle: INTEGER): INTEGER is
		external "C"
		end

	ipc_close (c_handle: INTEGER): INTEGER is
		external "C"
		end

	handle: INTEGER
			-- Handle to system mutex.
			
invariant
	is_owner implies is_open
	
end -- class WIN_MUTEX

--
--    copyright: "Groupe S (c) 1997-2002"
--    licence: "All rights reserved. Duplication and distribution prohibited."
--
--    source: "$ Source: $";
-- $ Log: $

