indexing
	description: "Objects that test XS_UINT32 class"
	author: "Paul G. Crismer"
	
	library: "XS_C : eXternal Support C"
	
	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"
class
	TEST_UINT32

inherit
	KL_SHARED_STANDARD_FILES
	
creation
	make

feature
	
	make is
		local
			test_ascii85 : TEST_ASCII85
		do
			test_byte
			test_read_binary ("binary", "101")
			test_read_hexa ("hex1","FE1")
			test_read_hexa ("hex2","FFFFFFFE")
			test_plus
			test_minus
			test_divide
			test_less_than
			test_shift_left
			test_shift_right
			test_and
			test_or
			test_xor
			test_remainder
			test_is_equal
			test_not
			create test_ascii85
			test_ascii85.test_ascii85
		end
	
	value : XS_C_UINT32

	res, other : XS_C_UINT32
	
	one : XS_C_UINT32 is once create Result.make_from_integer (1) end

	test_read_hexa (tag, s : STRING) is
			--	to_hexadecimal_string: STRING
			--	make_from_hexadecimal_string (s: STRING)
		local
			hexa : STRING
		do
			create value.make_from_hexadecimal_string (s)
			hexa := value.to_hexadecimal_string
			check_equal (tag, s, hexa)
		end

	test_read_binary (tag, s : STRING) is
			--	to_binary_string: STRING
 			--	make_from_binary_string (s: STRING)
		local
			binary : STRING
		do
			create value.make_from_binary_string (s)
			binary := value.to_binary_string
			check_equal (tag, s, binary)
		end

	test_read_integer (i : INTEGER) is
			--	make_from_integer (value: INTEGER) 
		do
			create value.make_from_integer (i)
			check_equal ("from_integer", i.out, value.item.out)
		end
		
	test_byte is
			--	byte (index: INTEGER): INTEGER 
			--	put_byte (v, index: INTEGER)
		local
			byte : INTEGER
		do
			create value.make
			value.put_byte (255, 1)
			check_equal ("byte1", (255).out, value.byte (1).out)
			check_equal ("byte_as_signed", "-1", value.as_signed_8(value.byte(1)).out)
		end

	test_plus is
			--	infix "+" (other: [like Current] XS_C_UINT32): [like Current] XS_C_UINT32 
		do
			create value.make_from_integer (5)
			res := value + value
			check_equal ("plus1", "10", res.item.out)
			create value.make_from_hexadecimal_string ("80000000")
			res := value + value
			check_equal ("plus2", "0", res.item.out)
			create value.make_from_hexadecimal_string ("7FFFFFFF")
			res := value + one
			check_equal ("plus3", "80000000", res.to_hexadecimal_string)
		end

	test_minus is
			--	infix "-" (other: [like Current] XS_C_UINT32): [like Current] XS_C_UINT32
		do
			create value.make_from_integer (5)
			res := value - value
			check_equal ("minus1", "0", res.item.out)
			create value.make_from_hexadecimal_string ("80000000")
			res := one - value
			check_equal ("minus2", "80000001", res.to_hexadecimal_string)
			create value.make_from_hexadecimal_string ("80000000")
			res := value - one
			check_equal ("minus3", "7FFFFFFF", res.to_hexadecimal_string)
		end
		
	test_divide is
			--	infix "//" (other: [like Current] XS_C_UINT32): [like Current] XS_C_UINT32
		do
			create value.make_from_integer (5)
			create other.make_from_integer (2)
			res := value // other
			check_equal ("divide1", "2", res.item.out)
			create value.make_from_integer (-1)
			res := value // other
			check_equal ("divide2", "7FFFFFFF", res.to_hexadecimal_string)
			create other.make_from_integer (2)
			create value.make_from_hexadecimal_string ("EEEEEEEE")
			res := value // other
			check_equal ("divide3", "77777777", res.to_hexadecimal_string)
			create other.make_from_integer (3)
			create value.make_from_hexadecimal_string ("99999999")
			res := value // other
			check_equal ("divide4", "33333333", res.to_hexadecimal_string)
		end
		
	test_less_than is
			--	infix "<" (other: [like Current] XS_C_UINT32): BOOLEAN
		do
			create value.make_from_integer (2)
			check_equal ("<1", (True).out, (one < value).out)
		end
		
	test_shift_left is		
			--	infix "@<<" (n: INTEGER): [like Current] XS_C_UINT32
		do
			res := one @<< 31
			check_equal ("<<31", "80000000", res.to_hexadecimal_string)
			res := one @<< 16
			check_equal ("<<16", "10000", res.to_hexadecimal_string)
		end
		
	test_shift_right is		
			--	infix "@>>" (n: INTEGER): [like Current] XS_C_UINT32
		do
			create value.make_from_hexadecimal_string ("00010000")
			res := value @>> 16
			check_equal (">>31", "1", res.to_hexadecimal_string)
			res := value @>> 17
			check_equal (">>17", "0", res.to_hexadecimal_string)
		end
		
	test_and is		
			--	infix "@and" (other: [like Current] XS_C_UINT32): [like Current] XS_C_UINT32
		do
			create value.make_from_hexadecimal_string ("EEEEEEEE")
			create other.make_from_hexadecimal_string ("11111111")
			res := value @and other
			check_equal ("@and1", "0", res.to_hexadecimal_string)
		end
		
	test_or is		
			--	infix "@or" (other: [like Current] XS_C_UINT32): [like Current] XS_C_UINT32
		do
			create value.make_from_hexadecimal_string ("EEEEEEEE")
			create other.make_from_hexadecimal_string ("11111111")
			res := value @or other
			check_equal ("@or1", "FFFFFFFF", res.to_hexadecimal_string)
		end
		
	test_xor is		
			--	infix "@xor" (other: [like Current] XS_C_UINT32): [like Current] XS_C_UINT32
		do
			create value.make_from_hexadecimal_string ("F1111111")
			res := value @xor one
			check_equal ("xor1", "F1111110", res.to_hexadecimal_string)
			res := value @xor value
			check_equal ("xor2", "0", res.item.out)
			other := value @xor one
			res := value
			res := res @xor other
			other := other @xor res
			res := res @xor other
			check_equal ("xorswap1", (value @xor one).to_hexadecimal_string, res.to_hexadecimal_string)
			check_equal ("xorswap2", (value).to_hexadecimal_string, other.to_hexadecimal_string)
		end
		
	test_remainder is		
			--	infix "\\" (other: [like Current] XS_C_UINT32): [like Current] XS_C_UINT32
		do
			create value.make_from_integer (3)
			create other.make_from_integer (2)
			res := value \\ other
			check_equal ("rem1","1", res.to_hexadecimal_string)
			create value.make_from_integer (1001)
			res := value \\ other
			check_equal ("rem2", "1",res.to_hexadecimal_string)
		end
		
	test_is_equal is		
			--	is_equal (other: [like Current] XS_C_UINT32): BOOLEAN
		do
			create value.make_from_integer (1)
			check_equal ("is_equal", (True).out, (one.is_equal (value)).out)
		end
		
	test_not is		
		--	prefix "@not": [like Current] XS_C_UINT32
		do
			check_equal ("not1","FFFFFFFE", (@not one).to_hexadecimal_string)
		end
		

	check_equal (tag, expected, got : STRING) is
			-- 
		do
			print (tag)
			print (": '")
			print (got)
			print ("'%T")
			if expected.is_equal (got) then
				print ("OK")
			else
				print ("FAILED - expected : ")
				print (expected)
			end
			print ("%N")
		end
	
		
end -- class TEST_UINT32