indexing
	description: "UINT 32 routines"
	author: "Paul G. Crismer"
	
	library: "XS_C : eXternal Support C"
	
	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	XS_UINT32_ROUTINES
	
inherit
	KL_IMPORTED_STRING_ROUTINES
		
feature -- Basic operations

	add (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' + `e2'
		external "C"
		alias "c_u_add32"
		end

	subtract (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' - `e2'
		external "C"
		alias "c_u_subtract32"
		end

	divide (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' / `e2'
		external "C"
		alias "c_u_divide32"
		end

	multiply (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' * `e2'
		external "C"
		alias "c_u_multiply32"
		end

	remainder (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' \\ `e2'
		external "C"
		alias "c_u_remainder32"
		end

	left_shift (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' << `e2'
		external "C"
		alias "c_u_left_shift32"
		end

	right_shift (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' >> `e2'
		external "C"
		alias "c_u_right_shift32"
		end

	u_and (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' & `e2'
		external "C"
		alias "c_u_and32"
		end

	u_or (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' | `e2'
		external "C"
		alias "c_u_or32"
		end

	u_xor (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' ^ `e2'
		external "C"
		alias "c_u_xor32"
		end

	u_not  (e1 : INTEGER)  : INTEGER is
			-- Unsigned ~`e1'
		external "C"
		alias "c_u_not32"
		end

	lt (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' < `e2'
		external "C"
		alias "c_u_lt32"
		end

	eq (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' = `e2'
		external "C"
		alias "c_u_eq32"
		end

	set_bit (el,  n : INTEGER) : INTEGER is
			-- set n-th bit of e1
		external "C"
		alias "c_u_setbit32"
		end
		
	get_bit (el,  n : INTEGER) : INTEGER is
			-- get n-th bit of e1
		external "C"
		alias "c_u_getbit32"
		end

feature -- Conversion

	as_signed_8 (n : INTEGER) : INTEGER is
			-- `n' as a signed 8
		require
			n_unsigned8: n >= 0 and n <= 255
		external "C"
		alias "c_u_as_signed8"
		ensure
			result_signed8: Result >= - 128 and Result <= 127
		end

	as_signed_16 (n : INTEGER) : INTEGER is
			-- `n' as a signed 16
		require
			n_unsigned_16: n >= 0 and n <= 65535
		external "C"
		alias "c_u_as_signed16"
		ensure
			result_signed16: Result >= -32768 and Result <= 32767
		end

	hexadecimal_to_integer (hexadecimal_string : STRING) : INTEGER is
			-- `hexadecimal_string' as integer
		require
			hexadecimal_string_not_void: hexadecimal_string /= Void
			is_hexadecimal_string: is_hexadecimal_string (hexadecimal_string)
		do
			Result := STRING_.hexadecimal_to_integer (hexadecimal_string)
		end
		
feature -- Status report

	is_hexadecimal_string (string : STRING) : BOOLEAN is
			-- Is `string' composed of [0-9A-Fa-f]+ ?
		require
			string_not_void: string /= Void
		do
			Result := STRING_.is_hexadecimal (string)
		end
		
end -- class XS_UINT32_ROUTINES
--
-- Copyright: 2003; Paul G. Crismer; <pgcrism@users.sourceforge.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
