indexing
	description: "Objects that handle communication with external objects"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XS_C_EXTERNAL_TOOLS_COMMON

inherit
	MEMORY

feature -- Status report


feature -- Basic operations

	string_to_pointer (s : STRING) : POINTER is
			-- pointer to "C" version of 's'
		require
			good_string: s /= Void
		deferred
		end

	pointer_to_string (p : POINTER) : STRING is
		require
			good_pointer: p /= default_pointer
		deferred
		end

	string_copy_from_pointer (s : STRING; p : POINTER) is
			-- copy 'C' string at `p' into `s'
		require
			s_not_void: s /= Void
			p_not_default: p /= default_pointer
		deferred
		end
		
end -- class XS_C_EXTERNAL_TOOLS_COMMON
