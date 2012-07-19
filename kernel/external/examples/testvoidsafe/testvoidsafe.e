note
	description : "testvoidsafe application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TESTVOIDSAFE

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			--| Add your code here
			print ("Hello Eiffel World!%N")
			test_arrayint16
			test_arrayint32
			test_arrayint8
			test_b
			test_int8
			test_int16
			test_int32
			test_int64
			test_memrout
			test_ptr
			test_str
			test_u32
			test_imp32
			test_ur32
		end

feature -- test arrays

	test_arrayint16
				--test_arrayint16
		do
			arrayint16.put (-1, 1)
			check
				arrayint16.item (1) = -1
			end
			arrayint16.put (0x0, 2)
			check
				arrayint16.item (2) = 0
			end
			arrayint16.put (-16384, 3)
			check
				arrayint16.item (3) = - 16384
			end
		end

	test_arrayint8
				--test_arrayint8
		do
			arrayint8.put (-1, 1)
			check
				arrayint8.item (1) = -1
			end
			arrayint8.put (0x0, 2)
			check
				arrayint8.item (2) = 0
			end
			arrayint8.put (-128, 3)
			check
				arrayint8.item (3) = - 128
			end
		end

	test_arrayint32
				--test_arrayint32
		do
			arrayint32.put (-1, 1)
			check
				arrayint32.item (1) = -1
			end
			arrayint32.put ({INTEGER_32}.min_value, 2)
			check
				arrayint32.item (2) = {INTEGER_32}.min_value
			end
			arrayint32.put ({INTEGER_32}.max_value, 3)
			check
				arrayint32.item (3) = {INTEGER_32}.max_value
			end
		end

feature -- test scalar

	test_b
		do
			b.put (true)
			check
				b.item = True
			end
			b.put (false)
			check
				b.item = False
			end
		end

	test_int8
				--test_int8
		do
			int8.put (-1)
			check
				int8.item = -1
			end
		end

	test_int16
				--test_int16
		do
			int16.put (-1)
			check
				int16.item = -1
			end
		end

	test_int32
				--test_int32
		do
			int32.put (-1)
			check
				int32.item = -1
			end
		end

	test_int64
				--test_int64
		do
			int64.put (-1)
			check
				int64.item = -1
			end
		end

	test_memrout
				--test_memrout
		do

		end

	test_ptr
				--test_ptr
		do

		end

	test_str
				--test_str
		do
			create str.make_from_string ("Ceci est un essai")
			check
				str.as_string ~ "Ceci est un essai"
			end
		end

	test_u32
				--test_u32
		do
		end

	test_imp32
				--test_imp32
		do
			check
				ishex1: imp32.uint32_.is_hexadecimal_string ("abcdef0123456")
				ishex2: imp32.uint32_.is_hexadecimal_string ("12349")
			end
			check
				hex_10: imp32.uint32_.hexadecimal_to_integer ("a") = 10
				hex_min1: imp32.uint32_.hexadecimal_to_integer ("FFFFFFFF") = -1
			end

		end

	test_ur32
				--test_ur32
		do
		end

feature -- Access

	arrayint16: XS_C_ARRAY_INT16 attribute create Result.make(10) end
	arrayint8: XS_C_ARRAY_INT8 attribute create Result.make(10) end
	arrayint32: XS_C_ARRAY_INT32 attribute create Result.make(10) end
	b : XS_C_BOOLEAN attribute create Result.make end
	int8: XS_C_INT8 attribute create Result.make end
	int16: XS_C_INT16 attribute create Result.make end
	int32: XS_C_INT32 attribute create Result.make end
	int64: XS_C_INT64 attribute create Result.make end
	memory : XS_C_MEMORY attribute create Result end
	memrout: XS_C_MEMORY_ROUTINES attribute create Result end
	ptr: XS_C_POINTER attribute create Result.make end
	str: XS_C_STRING attribute create Result.make (32) end
	u32: XS_C_UINT32 attribute create Result.make end
	imp32: XS_IMPORTED_UINT32_ROUTINES attribute create Result end
	ur32: XS_UINT32_ROUTINES attribute create Result end

end
