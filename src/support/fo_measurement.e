indexing

	description:

		"Objects that represent a length measurement."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_MEASUREMENT

inherit
	KL_NUMERIC
		undefine
			is_equal, out
		end

	COMPARABLE
		redefine
			is_equal, out
		end

create
	centimeters, millimeters, points, inches, make_zero

feature {NONE} -- Initialization

	centimeters (v : DOUBLE) is
			-- Set current to `v' centimeters.
		do
			value := v * points_in_centimeters
		ensure
			set: is_equal_centimeters (v)
		end

	millimeters (v : DOUBLE) is
			-- Set Current to `v' millimeters.
		do
			value := v * points_in_millimeters
		ensure
			set: is_equal_millimeters (v)
		end

	points (v : DOUBLE) is
			-- Set Current to `v' points.
		do
			value := v
		ensure
			set: is_equal_points (v)
		end

	inches (v : DOUBLE) is
			-- Set Current to `v' inches.
		do
			value := v * points_in_inches
		ensure
			set: is_equal_inches (v)
		end

	make_zero is
			-- Make Zero.
		do
			value := 0
		ensure
			is_zero: is_zero
		end

feature -- Access

	tolerance : DOUBLE is 1.0e-6
			-- Numeric tolerance for comparisons.

	sign : INTEGER is
			-- Sign.
		do
			if value > 0 then
				Result := 1
			elseif value = 0 then
				Result := 0
			else
				Result := -1
			end
		ensure
			one_strictly_positive: as_points > 0 implies Result = 1
			zero_is_zero: as_points = 0 implies Result = 0
			minus_one_negative: as_points < 0 implies Result = 1
		end

feature -- Measurement

feature -- Status report

	is_zero : BOOLEAN is
		do
			Result := value.abs < tolerance
		end

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Comparison

	is_equal_points (v : DOUBLE) : BOOLEAN is
			-- Is `v' points equal to Current ?
		do
			Result := tolerant_equal (as_points, v)
		end

	is_equal_inches (v : DOUBLE) : BOOLEAN is
			-- Is `v' inches equal to Current ?
		do
			Result := tolerant_equal (as_inches, v)
		end

	is_equal_centimeters (v : DOUBLE) : BOOLEAN is
			-- Is `v' centimeters equal to Current ?
		do
			Result := tolerant_equal (as_centimeters, v)
		end

	is_equal_millimeters (v : DOUBLE) : BOOLEAN is
			-- Is `v' millimeters equal to Current.
		do
			Result := tolerant_equal (as_millimeters, v)
		end

feature -- Transformation

feature -- Conversion

	as_points : DOUBLE is
			-- Current in points (1/72 inch)
		do
			Result := value
		end

	as_centimeters : DOUBLE is
			-- Current in centimeters
		do
			Result := value / points_in_centimeters
		end

	as_millimeters : DOUBLE is
			-- Current in millimeters
		do
			Result := value / points_in_millimeters
		end

	as_inches : DOUBLE is
			-- Current is inches
		do
			Result := value / points_in_inches
		end

feature -- Duplication

feature -- Miscellaneous

	is_equal (other : like Current) : BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := (as_points = other.as_points)
		end

	infix "<" (other : like Current) : BOOLEAN is
			-- Is `other' less than Current ?
		do
			Result := (as_points < other.as_points)
		end

feature -- Basic operations

	prefix "-" : like Current is
			-- Current negated.
		do
			Create Result.points (-as_points)
		end

	prefix "+" : like Current is
			-- Current plussed.
		do
			Create Result.points (as_points)
		end

	infix "/" (other : like Current) : like Current is
			-- Current divided by `other'.
		do
			Create Result.points (as_points / other.as_points)
		end
		
	infix "*" (other : like Current) : like Current is
			-- Current multiplied by `other'.
		do
			Create Result.points (as_points * other.as_points)
		end

	infix "+" (other : like Current) : like Current is
			-- Current added with `other'.
		do
			Create Result.points (as_points + other.as_points)
		end

	infix "-" (other : like Current) : like Current is
			-- Current substracted with `other'.
		do
			Create Result.points (as_points - other.as_points)
		end

	exponentiable (other : like Current) : BOOLEAN is
			-- Is Current exponentiable by `other'?
		do
			Result := False
		end

	divisible (other: like Current): BOOLEAN is
			-- Is Current divisible by `other' ?
		do
			Result := other.as_points /= 0.
		end

	zero : like Current is do create result.points (0) end

	one : like Current is do create result.points (1) end

feature -- Obsolete

feature -- Conversion

	out : STRING is
		do
			create Result.make (20)
			Result.append_double (as_points)
			Result.append_string ("pts")
		end


feature {NONE} -- Implementation

	value : DOUBLE

	inches_in_centimeters : DOUBLE is 2.54
	points_in_inches : DOUBLE is 72.0
	points_in_centimeters : DOUBLE is once Result := points_in_inches / inches_in_centimeters end
	points_in_millimeters : DOUBLE is once Result := points_in_centimeters / 10 end

	tolerant_equal (u, v : DOUBLE) : BOOLEAN is
			-- Are `u' and `v' distant from less than `tolerance'?
		do
			Result := (u - v).abs <= tolerance
		end

end
