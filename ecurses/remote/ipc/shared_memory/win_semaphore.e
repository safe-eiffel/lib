indexing
	description: "Objects that let threads synchronize using a semaphore "

	usage: "Controlling a shared ressource"
	refactoring: ""

	library: "ECURSES : Eiffel Curses wrapping Library. Project SAFE."
	copyright: "Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
	license: "Eiffel Forum License v2 (see forum.txt)"

	date: "$Date$";
	revision: "$Revision$";
	author: "Eric Fafchamps"

class
	WIN_SEMAPHORE

inherit
	CURSES_EXTERNAL_TOOLS
	
create
	make
	
	
feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Initialize with `a_name'.
		do
			name := a_name
		ensure
			shared_name: name = a_name
			not_is_open: not is_open
		end		

feature -- Access

	name: STRING
			-- Name of system semaphore.
			
feature -- Measurement

feature -- Comparison

feature -- Status report

	is_open: BOOLEAN is
			-- Is the semaphore open
		do
			Result := handle /= 0
		end
		
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

	create_only (an_initial_count, a_maximum_count: INTEGER) is
			-- Create (without owning)
		require
			not_is_open: not is_open
			consistent: an_initial_count >= 0 and an_initial_count <= a_maximum_count
		do
			handle := ipc_semaphore_create (an_initial_count, a_maximum_count, string_to_pointer (name))
		ensure
			is_open: is_open
		end

	wait is
			-- Wait for semaphore.
		require
			is_open: is_open
		do
			last_status := ipc_wait_for_lock (handle)
		ensure
			is_open: is_open
		end
		
	release (count: INTEGER) is
			-- Release lock.
		require
			is_open: is_open
		do
			last_status := ipc_semaphore_release (handle, count)
		ensure
			is_open: is_open
		end
	
	open is
			-- Open semaphore.
		require
			not_is_open: not is_open
		do
			handle := ipc_semaphore_open ( string_to_pointer (name))
		ensure
			-- semaphore exists implies is_open
		end
		
	close is
			-- Close.
		require
			is_open: is_open
		do
			last_status := ipc_close (handle)
			handle := 0
		ensure
			closed: not is_open
		end

feature -- Obsolete

feature -- Inapplicable

feature -- Constants

feature {NONE} -- Implementation

	ipc_semaphore_create (c_initial_count: INTEGER; c_maximum_count: INTEGER; c_name: POINTER): INTEGER is
		external "C" 
		end

	ipc_semaphore_open (c_name: POINTER): INTEGER is
		external "C" 
		end

	ipc_wait_for_lock (c_handle: INTEGER): INTEGER is
		external "C"
		end
	
	ipc_semaphore_release (c_handle: INTEGER; c_release_count: INTEGER): INTEGER is
		external "C"
		end

	ipc_close (c_handle: INTEGER): INTEGER is
		external "C"
		end

	handle: INTEGER
			-- Handle to system semaphore.
	
end