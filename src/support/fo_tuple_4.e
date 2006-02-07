indexing

	description: 
	
		"4-uples"

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_TUPLE_4
	
inherit
	ANY
		redefine
			is_equal
		end

feature {NONE} -- Initialization

	make is
		do
			create left.points (0)
			create right.points (0)
			create top.points (0)
			create bottom.points (0)
		end

feature -- Initialization

	set (a_left, a_bottom, a_right, a_top  : FO_MEASUREMENT) is
		require
			valid_rectangle: valid_rectangle (a_left, a_bottom, a_right, a_top)
		do
			left := a_left
			right := a_right
			top := a_top
			bottom := a_bottom
		ensure
			left_set: left = a_left
			bottom_set: bottom = a_bottom
			right_set: right = a_right
			top_set: top = a_top
		end
		
feature -- Access

	right: FO_MEASUREMENT
		-- right coordinate of top right corner.

	left: FO_MEASUREMENT
		-- left coordinate of left bottom corner.

	bottom: FO_MEASUREMENT
		-- bottom coordinate of left bottom corner.
		
	top: FO_MEASUREMENT
		-- top coordinate of top right corner.
		
feature -- Status report

	valid_right (new_right: FO_MEASUREMENT) : BOOLEAN is
			-- is new_right a valid right ?
		do
			Result := new_right /= Void
		ensure
			definition: Result = (new_right /= Void)
		end

	valid_left (new_left: FO_MEASUREMENT) : BOOLEAN is
			-- is new_left a valid left ?
		do
			Result := new_left /= Void
		ensure
			definition: Result =( new_left /= Void)
		end

	valid_bottom (new_bottom: FO_MEASUREMENT) : BOOLEAN is
			-- is new_bottom a valid bottom ?
		do
			Result := new_bottom /= Void
		ensure
			definition: Result = (new_bottom /= Void)
		end

	valid_top (new_top: FO_MEASUREMENT) : BOOLEAN is
			-- is new_top a valid top ?
		do
			Result := new_top /= Void
		ensure
			definition: Result = (new_top /= Void)
		end

	valid_rectangle (new_left, new_bottom, new_right, new_top : FO_MEASUREMENT) : BOOLEAN is
			-- Is this a valid rectangle ?
		do
--			if new_left /= Void and new_bottom /= Void and new_right /= Void and new_top /= Void then
--				Result := new_left <= new_right and new_bottom <= new_top
--			end
			Result := True
		end
		
feature -- Element change

	set_right (new_right: FO_MEASUREMENT) is
			-- Set `right' to `new_right'.
		require
			valid_new_right: valid_right (new_right)
		do
			right := new_right
		ensure
			right_assigned: right = new_right
		end

	set_left (new_left: FO_MEASUREMENT) is
			-- Set `left' to `new_left'.
		require
			valid_new_left: valid_left (new_left)
		do
			left := new_left
		ensure
			left_assigned: left = new_left
		end

	set_bottom (new_bottom: FO_MEASUREMENT) is
			-- Set `bottom' to `new_bottom'.
		require
			valid_new_bottom: valid_bottom (new_bottom)
		do
			bottom := new_bottom
		ensure
			bottom_assigned: bottom = new_bottom
		end

	set_top (new_top: FO_MEASUREMENT) is
			-- Set `top' to `new_top'.
		require
			valid_new_top: valid_top (new_top)
		do
			top := new_top
		ensure
			top_assigned: top = new_top
		end

feature -- Comparison

	is_equal (other : like Current) : BOOLEAN is
		do
			Result := right.is_equal (other.right) and left.is_equal (other.left) and bottom.is_equal (other.bottom) and top.is_equal (other.top)
		end
		
invariant

	top_not_void: top /= Void
	bottom_not_void: bottom /= Void
	left_not_void: left /= Void
	right_not_void: right /= Void
	
end
