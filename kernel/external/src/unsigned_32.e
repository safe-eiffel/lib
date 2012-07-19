note
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

	item, infix "@" (index : INTEGER) : INTEGER
			-- `index'-th bit.
		require
			index_within_bounds: index >= 1 and then index <= 32
		do
			Result := Uint32_.get_bit (value, index)
		end
		
feature -- Measurement

	is_hexadecimal_string (string : STRING) : BOOLEAN
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

	infix "<" (other : like Current) : BOOLEAN
			-- Is Current less than `other'?
		do
			if Uint32_.lt (value, other.value) /= 0 then
				Result := True
			end
		end

	is_equal (other: like Current) : BOOLEAN
		do
			if Uint32_.eq (value, other.value) /= 0 then
				Result := True
			end
		end

feature -- Conversion

	out : STRING
		do
			Result := as_hexadecimal_string
		end
		
	as_integer : INTEGER
			-- Current as a signed INTEGER
		do
			Result := value
		end
	
	as_integer_16 : INTEGER
			-- Current as a signed 16 bit INTEGER
		do
			Result := Uint32_.as_signed_16 (value)
		end
	
	as_integer_8 : INTEGER
			-- Current as a signed 8 bit INTEGER
		do
			Result := Uint32_.as_signed_8 (value)
		end

	as_hexadecimal_string : STRING
			-- Current as an hexadecimal string.
		do
			create Result.make (8)
			UINT32_.append_hexadecimal_integer (value, Result, False)
			
		ensure
			definition: Result /= Void and then UINT32_.hexadecimal_to_integer (Result) = as_integer
		end
		
	from_integer (a_value : INTEGER) : like Current
		local
			save : INTEGER
		do
			save := value
			set_value (a_value)
			Result := Current
			set_value (save)
		ensure
			definition: Result.as_integer = a_value
		end
		
	from_double (a_value : DOUBLE) : UNSIGNED_32
		do
			Result := from_integer (a_value.truncated_to_integer)
		ensure
			definition: Result.as_integer = a_value.truncated_to_integer
		end
		
	from_hex (a_string : STRING) : like Current
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

	infix "+" (other : like Current) : like Current
			-- Unsigned addition of Current with `other'.
		do
			Result.set_value (Uint32_.add (value, other.value))
		end

	infix "-" (other : like Current) : like Current
			-- Unsigned subtraction of Current with `other'.
		do
			Result.set_value (Uint32_.subtract (value, other.value))
		end

	infix "*" (other : like Current) : like Current
			-- Unsigned multiplication of Current with `other'.
		do
			Result.set_value (Uint32_.multiply (value, other.value))
		end

	infix "//" (other : like Current) : like Current
			-- Unsigned division of Current with `other'.
		do
			Result.set_value (Uint32_.divide (value, other.value))
		end
		
	infix "\\" (other : like Current) : like Current
			-- Unsigned remainder of dividing Current by `other'.
		do
			Result.set_value (Uint32_.remainder (value, other.value))
		end
		
	infix "and" (other : like Current) : like Current
			-- Unsigned and of Current with `other'.
		do
			Result.set_value (Uint32_.u_and (value, other.value))
		end
		
	infix "or" (other : like Current) : like Current
			-- Unsigned or of Current with `other'.
		do
			Result.set_value (Uint32_.u_or (value, other.value))
		end
		
	infix "xor" (other : like Current) : like Current
			-- Unsigned or of Current with `other'.
		do
			Result.set_value (Uint32_.u_xor (value, other.value))
		end

	prefix "not" : like Current
			-- binary complement of Current.
		do
			Result.set_value (Uint32_.u_not (value))
		end		
	
	left_shifted, infix "|<<" (count : INTEGER) : like Current
			-- Current left shifted by `count' bits.
		require
			count_within_limits: count >= 0 and then count <=32
		do
			Result.set_value (Uint32_.left_shift (value, count))
		end

	right_shifted, infix "|>>" (count : INTEGER) : like Current
			-- Current right shifted by `count' bits.
		require
			count_within_limits: count >= 0 and then count <=32
		do
			Result.set_value (Uint32_.right_shift (value, count))
		end

feature -- Obsolete

feature -- Inapplicable

feature {UNSIGNED_32} -- Implementation

	value : INTEGER
	
	set_value (a_value : INTEGER)
			-- Set `value' to `a_value'.
		do
			value := a_value
		ensure
			value_set: value = a_value
		end
		
end -- class UNSIGNED_32
