note
	description: "Summary description for {TTF_F2DOT14}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TTF_F2DOT14

inherit
	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (v : NATURAL_16)
		do
			item := v
		end

feature -- Access

	item : NATURAL_16

	mantissa : INTEGER_16
		local
			n, n1 : NATURAL_16
		do
			n := item.bit_and ({NATURAL_16}0xc000)
			if n.bit_test (15) then
				Result := -1
				n := n.bit_xor (0xffff)
				n := n+1
			else
				Result := 1
			end
			n1 := n.bit_shift_right (14)
			Result := Result * n1.as_integer_16
		end

	fraction_dividend : INTEGER_16
		do
			Result := item.bit_and ({NATURAL_16}0b0011111111111111).as_integer_16
		end

	fraction_divisor : INTEGER_32 = 16384


feature -- Conversion

	as_real_32 : REAL_32
		local
			res : REAL_64
		do
			Res := mantissa + (fraction_dividend / fraction_divisor)
			Result := res.truncated_to_real
		end

	debug_output : STRING
		do
			create Result.make (30)
			Result.append_character ('[')
			Result.append_integer_16 (mantissa)
			Result.append_character (',')
			Result.append_integer_16 (fraction_dividend)
			Result.append_character ('|')
			Result.append_string (as_real_32.out)
			Result.append_character (']')
		end
end
