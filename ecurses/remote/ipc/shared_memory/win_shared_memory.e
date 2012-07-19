indexing
	description: "Objects that shares memory between processes"

	library: "ECURSES : Eiffel Curses wrapping Library. Project SAFE."
	copyright: "Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
	license: "Eiffel Forum License v2 (see forum.txt)"

	date: "$Date$";
	revision: "$Revision$";
	author: "Fafchamps Eric"

class
	WIN_SHARED_MEMORY

inherit
	CURSES_EXTERNAL_TOOLS
	
create
	make
	
feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Initialise with `a_name'.
		require
			name_defined: a_name /= Void
		do
			name := a_name
		ensure
			name_shared: name = a_name
		end
		
feature -- Access

	name: STRING
			-- Name

	item: STRING is
			-- Shared item.
		local
			p: POINTER
		do
			p := ipc_shared_memory_item (file_view_address)	
			Result := pointer_to_string (p)
		end
		
feature -- Measurement

feature -- Comparison

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	put (a_string: STRING) is
			-- Put `a_string' in item.
		do
			ipc_shared_memory_put (file_view_address, string_to_pointer (a_string))
		end
		

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	create_map is
			-- Create map.
		do
			file_mapping_handle := ipc_create_file_mapping (0, 8001, string_to_pointer (name))
			file_view_address := ipc_map_view_of_file (file_mapping_handle, 8000)
		end
		
	open_map is
			-- Open existing map.
		do
			file_mapping_handle := ipc_open_file_mapping (string_to_pointer (name))
			file_view_address := ipc_map_view_of_file (file_mapping_handle, 8000)
		end
	
	close_map is
			-- Close.
		do
			ipc_unmap_view_of_file (file_view_address)		
		end
		
feature -- Obsolete

feature -- Inapplicable

feature -- Constants

feature {NONE} -- Implementation

	file_mapping_handle: INTEGER
	
	file_view_address: POINTER

	ipc_create_file_mapping (c_sizeHigh: INTEGER; c_sizeLow: INTEGER; c_name: POINTER): INTEGER is
		external "C"
		end

	ipc_map_view_of_file (c_hFileMappingObject: INTEGER; c_dwNumberOfBytesToMap: INTEGER): POINTER is
		external "C"
		end

	ipc_unmap_view_of_file (lpBaseAddress: POINTER) is
		external "C" 
		end
	
	ipc_shared_memory_put (c_file_view_address: POINTER; c_string: POINTER) is
		external "C" 
		end
		
	ipc_shared_memory_item (c_file_view_address: POINTER): POINTER is
		external "C" 
		end


	ipc_open_file_mapping (c_name: POINTER): INTEGER is
		external "C"
		end
		
end