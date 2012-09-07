note
	description: "Routines that give access to C memory."
	author: "Paul G. Crismer"

	library: "XS_C : eXternal Support C"

	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	XS_C_MEMORY_ROUTINES

feature {NONE} -- Implementation

	c_memory_put_char (pointer : POINTER; c : CHARACTER)
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_put_char"
		ensure
			char_set: c_memory_get_char (pointer) = c
		end

	c_memory_put_int8 (pointer : POINTER; v : INTEGER)
		require
			valid_pointer: pointer /= default_pointer
			int8_limits: v >= -128 and v < 128
		external "C"
		alias "c_memory_put_int8"
		ensure
			int8_set: c_memory_get_int8 (pointer) = v
		end

	c_memory_put_int16 (pointer : POINTER; v : INTEGER)
		require
			valid_pointer: pointer /= default_pointer
			int16_limits: v >= -16384 and v < 16384
		external "C"
		alias "c_memory_put_int16"
		ensure
			int16_set: c_memory_get_int16 (pointer) = v
		end

	c_memory_put_uint8 (pointer : POINTER; v : INTEGER)
		require
			valid_pointer: pointer /= default_pointer
			uint8_limits: v >= 0 and v < 256
		external "C"
		alias "c_memory_put_uint8"
		ensure
			uint8_set: c_memory_get_uint8 (pointer) = v
		end

	c_memory_put_uint16 (pointer : POINTER; v : INTEGER)
		require
			valid_pointer: pointer /= default_pointer
			uint16_limits: v >= 0 and v < 65536
		external "C"
		alias "c_memory_put_uint16"
		ensure
			uint16_set: c_memory_get_uint16 (pointer) = v
		end

	c_memory_put_uint32 (pointer : POINTER; v : NATURAL_32)
		require
			valid_pointer: pointer /= default_pointer
			uint32_limits: v >= {NATURAL_32}.min_value and v <= {NATURAL_32}.max_value
		external "C"
		alias "c_memory_put_uint32"
		ensure
			uint32_set: c_memory_get_uint32 (pointer) = v
		end

	c_memory_put_int32 (pointer : POINTER; v : INTEGER)
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_put_int32"
		ensure
			int32_set: c_memory_get_int32 (pointer) = v
		end

	c_memory_put_int64 (pointer : POINTER; v : INTEGER_64)
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_put_int64"
		ensure
			int64_set: c_memory_get_int64 (pointer) = v
		end

	c_memory_put_real (pointer : POINTER; v : REAL)
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_put_real"
		ensure
			real_set: c_memory_get_real (pointer) = v
		end

	c_memory_put_double (pointer : POINTER; v : DOUBLE)
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_put_double"
		ensure
			double_set: c_memory_get_double (pointer) = v
		end

	c_memory_put_pointer (pointer : POINTER; v : POINTER)
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_put_pointer"
		ensure
			pointer_set: c_memory_get_pointer (pointer) = v
		end

	c_memory_get_char (pointer : POINTER) : CHARACTER
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_get_char"
		end

	c_memory_get_int8 (pointer : POINTER) : INTEGER
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_get_int8"
		ensure
			int8: Result >= -128 and Result < 128
		end

	c_memory_get_int16 (pointer : POINTER) : INTEGER
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_get_int16"
		ensure
			int16: Result >= -16384 and Result < 16384
		end

	c_memory_get_uint8 (pointer : POINTER) : INTEGER
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_get_uint8"
		ensure
			uint8: Result >= 0 and Result < 256
		end

	c_memory_get_uint16 (pointer : POINTER) : INTEGER
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_get_uint16"
		ensure
			uint16: Result >= 0 and Result < 32768
		end

	c_memory_get_uint32 (pointer : POINTER) : NATURAL_32
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_get_uint32"
		ensure
			uint32: Result >= {NATURAL_32}.min_value and Result < {NATURAL_32}.max_value
		end

	c_memory_get_int32 (pointer : POINTER) : INTEGER
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_get_int32"
		end

	c_memory_get_int64 (pointer : POINTER) : INTEGER_64
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_get_int64"
		end

	c_memory_get_real (pointer : POINTER) : REAL
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_get_real"
		end

	c_memory_get_double (pointer : POINTER) : DOUBLE
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_get_double"
		end

	c_memory_get_pointer (pointer : POINTER) : POINTER
		require
			valid_pointer: pointer /= default_pointer
		external "C"
		alias "c_memory_get_pointer"
		end

end -- class XS_C_MEMORY_ROUTINES
--
-- Copyright: 2003-2012, Paul G. Crismer, <pgcrism@users.sourceforge.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
