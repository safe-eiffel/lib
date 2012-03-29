note
	description: "C allocated 32 bits unsigned integer."
	author: "Paul G. Crismer"

	library: "XS_C : eXternal Support C"

	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	XS_C_UINT32

inherit
	XS_C_INT32
		undefine
			is_equal
		end

	XS_UINT32_ROUTINES
		export
			{NONE} all
		undefine
			is_equal
		end

	COMPARABLE
		redefine
			is_equal
		end

	KL_IMPORTED_CHARACTER_ROUTINES
		undefine
			is_equal
		end

	KL_IMPORTED_INTEGER_ROUTINES
		undefine
			is_equal
		end

	KL_IMPORTED_STRING_ROUTINES
		undefine
			is_equal
		end

create
	make, make_from_integer, make_from_hexadecimal_string, make_from_binary_string

feature -- Access

	make_from_integer (value : INTEGER)
			-- Create from `value'.
		do
			make
			put (value)
		ensure
			item_set: item = value
		end

	make_from_hexadecimal_string (s: STRING)
			-- Create from `s'.
		require
			s_exists: s /= Void
			s_hexadecimal: STRING_.is_hexadecimal (s)
			count_less_8: s.count >= 1 and s.count <= hexadecimal_count
		do
			make
			put (STRING_.hexadecimal_to_integer (s))
		end

	make_from_binary_string (s: STRING)
			-- Create from `s'.
		require
			s_exists: s /= Void
			count_less_32: s.count >= 1 and s.count <= bit_count
		local
			s_index, bit_index : INTEGER
		do
			make
			put (0)
			from
				s_index := s.count
				bit_index := 1
			until
				s_index = 0
			loop
				if s.item (s_index) /= '0' then
					put (c_set_bit (item, bit_index))
				end
				s_index := s_index - 1
				bit_index := bit_index + 1
			end
		end

feature -- Measurement

	bit_count : INTEGER = 32
	hexadecimal_count : INTEGER = 8

feature -- Element change

	put_natural_32 (v : NATURAL_32)
		do
			c_memory_put_uint32 (handle, v)
		ensure
			as_natural_32_set: as_natural_32 = v
		end

feature -- Conversion

	as_natural_32 : NATURAL_32
		do
			Result := c_memory_get_uint32 (handle)
		end

feature -- Comparison

	is_equal (other : like Current) : BOOLEAN
		do
			if other = Current then
				Result := True
			else
				Result := (c_eq(item, other.item) /= 0)
			end
		end

	is_less alias "<" (other : like Current) : BOOLEAN
		do
			Result := (c_lt (item, other.item) /= 0)
		end

feature -- Basic operations

	times alias "*" (other : like Current) : like Current
			-- Current multiplied by `other'.
		do
			create Result.make
			Result.put (c_multiply (item, other.item))
		end

	added alias "+" (other : like Current) : like Current
			-- Current added with `other'.
		do
			create Result.make
			Result.put (c_add (item, other.item))
		end

	subtracted alias "-" (other : like Current) : like Current
			-- Current - other.
		do
			create Result.make
			Result.put (c_subtract(item, other.item))
		end

	integer_divided alias "//" (other : like Current) : like Current
			-- Current // other.
		do
			create Result.make
			Result.put (c_divide (item, other.item))
		end

	remainder alias "\\" (other :like Current) : like Current
			-- Current \\ other.
		do
			create Result.make
			Result.put (c_remainder (item, other.item))
		end

	left_shifted alias "|<<" (n : INTEGER) : like Current
		require
			n_within_limits: n >= 0 and n <= bit_count
		do
			create Result.make
			Result.put (c_left_shift (item, n))
		end

	right_shifted alias "|>>" (n : INTEGER) : like Current
		require
			n_within_limits: n >= 0 and n <= bit_count
		do
			create Result.make
			Result.put (c_right_shift (item, n))
		end

	binary_and alias "and" (other : like Current) : like Current
		do
			create Result.make
			Result.put (c_u_and (item, other.item))
		end

	binary_or alias "or" (other : like Current) : like Current
		do
			create Result.make
			Result.put (c_u_or (item, other.item))
		end

	binary_xor alias "xor" (other : like Current) : like Current
		do
			create Result.make
			Result.put (c_u_xor (item, other.item))
		end

	unary_not alias "not" : like Current
		do
			create Result.make
			Result.put (c_u_not (item))
		end

feature -- Conversion

	to_binary_string : STRING
			-- Current to binary string.
		local
			bit_index : INTEGER
			significant_digit : BOOLEAN
		do
			create Result.make (32)
			from
				bit_index := 32
			until
				bit_index = 0
			loop
				if c_get_bit (item, bit_index) > 0 then
					Result.append_character ('1')
					significant_digit := True
				else
					if significant_digit then
						Result.append_character ('0')
					end
				end
				bit_index := bit_index - 1
			end
			if Result.count = 0 then
				Result.append_character ('0')
			end
		end

	to_hexadecimal_string : STRING
			-- Current to hexadecimal string.
		local
			significant_digit : BOOLEAN
			index, nibble, the_byte : INTEGER
		do
			create Result.make (8)
			from
				index := 4
			until
				index = 0
			loop
				the_byte := byte (index)
				nibble := the_byte // 16
				if nibble > 0 then
					significant_digit := True
				end
				if significant_digit then
					INTEGER_.append_hexadecimal_integer (nibble, Result, True)
				end
				nibble := the_byte \\ 16
				if nibble > 0 then
					significant_digit := True
				end
				if significant_digit then
					INTEGER_.append_hexadecimal_integer (nibble, Result, True)
				end
				index := index - 1
			end
			if Result.count = 0 then
				Result.append_character ('0')
			end
		ensure
			to_hexadecimal_string_not_void: Result /= Void
			to_hexadecimal_string_hexadecimal: STRING_.is_hexadecimal (Result)
		end

feature -- Element change

	put_byte ( v, index : INTEGER)
			-- put unsigned byte `v' at `index'.
		require
			valid_v: v >= 0 and v < 256
			valid_index: index >= 1 and index <= 4
		do
			c_memory_put_int8 (c_memory_pointer_plus (handle,index - 1),  v)
		ensure
			byte_set: byte (index) = v
		end

	byte (index : INTEGER) : INTEGER
			-- unsigned byte at `index'.
		require
			valid_index: index >= 1 and index <= 4
		do
			Result := c_memory_get_uint8 (c_memory_pointer_plus (handle,index - 1))
		ensure
			result_unsigned: Result >= 0 and Result <= 255
		end

end -- class XS_C_UINT32
--
-- Copyright: 2003; Paul G. Crismer; <pgcrism@users.sourceforge.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
