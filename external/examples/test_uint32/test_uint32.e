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
		do
			test_from_integer
			test_from_hex
			test_is_equal
		end

	value : UNSIGNED_32

	res, other : UNSIGNED_32

	one : UNSIGNED_32 is once Result := Result.from_integer (1) end

	test_from_integer is
			-- from_integer (a_value: INTEGER): like Current
		do
			value := value.from_integer (123)
			check_equal ("from_integer", "123", value.as_integer.out)
			value := value.from_integer (-1)
			check_equal ("from_integer_2", "-1", value.as_integer.out)
			
		end

	test_from_hex is
			-- from_hex (a_string: STRING): like Current
		do
			value := value.from_hex ("80000001")
			check_equal ("from_hex", "80000001", value.as_hexadecimal_string)
			value := value.from_hex ("FFFFFFFF")
			check_equal ("from_hex2", "-1", value.as_integer.out)
			value := value.from_hex ("1e")
			check_equal ("from_hex3", "1e", value.as_hexadecimal_string)
		end

	test_is_equal is
			-- --		is_equal (other: like Current): BOOLEAN
		do
			res := value
			check_equal ("is_equal", (True).out, (res.is_equal (value)).out)
			check_equal ("equal", (True).out, (res = value).out)
			res := value.from_integer (3)
			check_equal ("is_equal2", (False).out, (res.is_equal (value)).out)
			check_equal ("equal2", (False).out, (res = value).out)
		end

		
--		item (index: INTEGER): INTEGER
--				-- `index'-th bit.

--		infix "@" (index: INTEGER): INTEGER
--				-- `index'-th bit.

--		is_hexadecimal_string (string: STRING): BOOLEAN
--				-- Is `string' composed of [0-9A-Fa-f]+ ?

--		infix "<" (other: like Current): BOOLEAN

--		as_hexadecimal_string: STRING

--		as_integer: INTEGER

--		as_integer_16: INTEGER

--		as_integer_8: INTEGER

--		out: STRING

--		infix "*" (other: like Current): like Current

--		infix "+" (other: like Current): like Current

--		infix "-" (other: like Current): like Current

--		infix "//" (other: like Current): like Current

--		infix "\\" (other: like Current): like Current

--		infix "and" (other: like Current): like Current

--		prefix "not": like Current

--		infix "or" (other: like Current): like Current

--		infix "xor" (other: like Current): like Current

--		infix "|<<" (count: INTEGER): like Current
--		left_shifted (count: INTEGER): like Current

--		infix "|>>" (count: INTEGER): like Current
--		right_shifted (count: INTEGER): like Current

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
