indexing
	description: "Unsigned 32 values."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	UNSIGNED_32

inherit
	XS_IMPORTED_UINT32_ROUTINES
		export 
			{NONE} all
		undefine
			is_equal, out
		end

	KL_IMPORTED_STRING_ROUTINES
		undefine
			is_equal, out
		end
	
	KL_IMPORTED_INTEGER_ROUTINES
		undefine
			is_equal, out
		end
		
	COMPARABLE
		redefine
			is_equal, out
		end
		
feature -- Access

	item, infix "@" (index : INTEGER) : INTEGER is
			-- `index'-th bit.
		require
			index_within_bounds: index >= 1 and then index <= 32
		do
			Result := Uint32_.get_bit (value, index)
		end

feature -- Measurement

	is_hexadecimal_string (string : STRING) : BOOLEAN is
			-- Is `string' composed of [0-9A-Fa-f]+ ?
		require
			string_not_void: string /= Void
		do
			Result := Uint32_.is_hexadecimal_string (string)
		end

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Comparison

	infix "<" (other : like Current) : BOOLEAN is
			-- Is Current less than `other'?
		do
			if Uint32_.lt (value, other.value) /= 0 then
				Result := True
			end
		end

	is_equal (other: like Current) : BOOLEAN is
		do
			if Uint32_.eq (value, other.value) /= 0 then
				Result := True
			end
		end

feature -- Conversion

	out : STRING is
		do
			Result := as_hexadecimal_string
		end
		
	as_integer : INTEGER is
			-- Current as a signed INTEGER
		do
			Result := value
		end
	
	as_integer_16 : INTEGER is
			-- Current as a signed 16 bit INTEGER
		do
			Result := Uint32_.as_signed_16 (value)
		end
	
	as_integer_8 : INTEGER is
			-- Current as a signed 8 bit INTEGER
		do
			Result := Uint32_.as_signed_8 (value)
		end

	as_hexadecimal_string : STRING is
			-- Current as an hexadecimal string.
		do
			create Result.make (8)
			UINT32_.append_hexadecimal_integer (value, Result, False)
			
		ensure
			definition: Result /= Void and then UINT32_.hexadecimal_to_integer (Result) = as_integer
		end
		
	from_integer (a_value : INTEGER) : like Current is
		local
			save : INTEGER
		do
			save := value
			set_value (a_value)
			Result := Current
			set_value (save)
		ensure
			definition: as_integer = a_value
		end
		
	from_hex (a_string : STRING) : like Current is
		local
			save : INTEGER
		do
			save := value
			set_value (Uint32_.hexadecimal_to_integer (a_string))
			Result := Current
			set_value (save)
		ensure
			definition: Result.as_integer = STRING_.hexadecimal_to_integer (a_string)
		end
		
feature -- Basic operations

	infix "+" (other : like Current) : like Current is
			-- Unsigned addition of Current with `other'.
		do
			Result.set_value (Uint32_.add (value, other.value))
		end

	infix "-" (other : like Current) : like Current is
			-- Unsigned subtraction of Current with `other'.
		do
			Result.set_value (Uint32_.subtract (value, other.value))
		end

	infix "*" (other : like Current) : like Current is
			-- Unsigned multiplication of Current with `other'.
		do
			Result.set_value (Uint32_.multiply (value, other.value))
		end

	infix "//" (other : like Current) : like Current is
			-- Unsigned division of Current with `other'.
		do
			Result.set_value (Uint32_.divide (value, other.value))
		end
		
	infix "\\" (other : like Current) : like Current is
			-- Unsigned remainder of dividing Current by `other'.
		do
			Result.set_value (Uint32_.remainder (value, other.value))
		end
		
	infix "and" (other : like Current) : like Current is
			-- Unsigned and of Current with `other'.
		do
			Result.set_value (Uint32_.u_and (value, other.value))
		end
		
	infix "or" (other : like Current) : like Current is
			-- Unsigned or of Current with `other'.
		do
			Result.set_value (Uint32_.u_or (value, other.value))
		end
		
	infix "xor" (other : like Current) : like Current is
			-- Unsigned or of Current with `other'.
		do
			Result.set_value (Uint32_.u_xor (value, other.value))
		end

	prefix "not" : like Current is
			-- binary complement of Current.
		do
			Result.set_value (Uint32_.u_not (value))
		end		
	
	left_shifted, infix "|<<" (count : INTEGER) : like Current is
			-- Current left shifted by `count' bits.
		require
			count_within_limits: count >= 0 and then count <=32
		do
			Result.set_value (Uint32_.left_shift (value, count))
		end

	right_shifted, infix "|>>" (count : INTEGER) : like Current is
			-- Current left shifted by `count' bits.
		require
			count_within_limits: count >= 0 and then count <=32
		do
			Result.set_value (Uint32_.right_shift (value, count))
		end

feature -- Obsolete

feature -- Inapplicable

feature {UNSIGNED_32} -- Implementation

	value : INTEGER
	
	set_value (a_value : INTEGER) is
			-- Set `value' to `a_value'.
		do
			value := a_value
		ensure
			value_set: value = a_value
		end
		
end -- class UNSIGNED_32
