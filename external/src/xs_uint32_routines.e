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

	KL_IMPORTED_CHARACTER_ROUTINES

feature -- Basic operations

	c_add (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' + `e2'
		external "C"
		alias "c_u_add32"
		end

	c_subtract (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' - `e2'
		external "C"
		alias "c_u_subtract32"
		end

	c_divide (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' / `e2'
		external "C"
		alias "c_u_divide32"
		end

	c_multiply (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' * `e2'
		external "C"
		alias "c_u_multiply32"
		end

	c_remainder (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' \\ `e2'
		external "C"
		alias "c_u_remainder32"
		end

	c_left_shift (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' << `e2'
		external "C"
		alias "c_u_left_shift32"
		end

	c_right_shift (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' >> `e2'
		external "C"
		alias "c_u_right_shift32"
		end

	c_u_and (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' & `e2'
		external "C"
		alias "c_u_and32"
		end

	c_u_or (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' | `e2'
		external "C"
		alias "c_u_or32"
		end

	c_u_xor (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' ^ `e2'
		external "C"
		alias "c_u_xor32"
		end

	c_u_not  (e1 : INTEGER)  : INTEGER is
			-- Unsigned ~`e1'
		external "C"
		alias "c_u_not32"
		end

	c_lt (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' < `e2'
		external "C"
		alias "c_u_lt32"
		end

	c_eq (e1 : INTEGER; e2 : INTEGER)  : INTEGER is
			-- Unsigned `e1' = `e2'
		external "C"
		alias "c_u_eq32"
		end

	c_set_bit (el,  n : INTEGER) : INTEGER is
			-- set n-th bit of e1
		external "C"
		alias "c_u_setbit32"
		end

	c_get_bit (el,  n : INTEGER) : INTEGER is
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
			fits_in_32_bits: hexadecimal_string.count <= 8
		local
			nibble, i, count : INTEGER
		do
			from
				count := hexadecimal_string.count
				i := 1
			until
				i > count
			loop
				nibble := hexadecimal_digits.index_of (CHARACTER_.as_lower (hexadecimal_string.item (i)), 1) - 1
				Result := c_left_shift (Result, 4)
				Result := c_u_or (Result, nibble)
				i := i + 1
			end
		end

	append_hexadecimal_integer (integer : INTEGER; string : STRING; upper_case : BOOLEAN) is
			-- Append 'value' as hexadecimal in `string' in upper/lower case.
		local
			s : STRING
			nibble : INTEGER
			v : INTEGER
			mask : INTEGER
		do
			create s.make (8)
			from
				v := integer
				mask := 15
			until
				v = 0
			loop
				nibble := c_u_and (v, mask)
				s.append_character (hexadecimal_digit (nibble, upper_case))
				v := c_right_shift (v, 4)
			end
			from
				v := s.count
			until
				v = 0
			loop
				string.append_character (s.item (v))
				v := v-1
			end
		end

feature -- Status report

	is_hexadecimal_string (string : STRING) : BOOLEAN is
			-- Is `string' composed of [0-9A-Fa-f]+ ?
		require
			string_not_void: string /= Void
		local
			c : CHARACTER
			i, count : INTEGER
		do
			from
				i := 1
				count := string.count
				Result := True
			until
				not Result or else i > count
			loop
				c := string.item (i)
				inspect c
				when '0'..'9', 'a'..'f', 'A'..'F' then
				else
					Result := False
				end
				i := i + 1
			end
		end

feature {NONE}  -- Implementation

	hexadecimal_digit (n : INTEGER; upper_case : BOOLEAN) : CHARACTER is
		require
			n_positive: n > 0
			n_less_16: n < 16
		do
			Result := hexadecimal_digits.item (n+1)
			if upper_case then
				Result := CHARACTER_.as_upper (Result)
			end
		end

	hexadecimal_digits : STRING is
		once
			Result := "0123456789abcdef" -- <<'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'>>
		end

end -- class XS_UINT32_ROUTINES
--
-- Copyright: 2003; Paul G. Crismer; <pgcrism@users.sourceforge.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
