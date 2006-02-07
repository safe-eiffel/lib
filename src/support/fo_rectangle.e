indexing

	description: 
	
		"Measurement rectangles"

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_RECTANGLE

inherit
	FO_TUPLE_4
		redefine
			valid_bottom,
			valid_left,
			valid_right,
			valid_top
		end
		
creation
	make, set, copy
	
feature -- Measurement

	width : FO_MEASUREMENT is
		do
			Result := right - left
		ensure
			width_not_negative: Result /= Void and then Result.sign >= 0
		end
		
	height : FO_MEASUREMENT is
		do
			Result := top - bottom
		ensure
			height_not_negative: Result /= Void and then Result.sign >= 0
		end
		
feature -- Status report

	is_empty : BOOLEAN is
			-- Is this rectangle empty?
		do
			Result := width.sign = 0 and height.sign = 0
		ensure
			definition: Result = (width.sign = 0 and height.sign = 0)
		end
		
	valid_right (new_right: FO_MEASUREMENT) : BOOLEAN is
			-- is new_right a valid right ?
		do
			Result := Precursor (new_right) and then new_right >= left
		ensure then
			greater_left: Result implies (new_right >= left)
		end

	valid_left (new_left: FO_MEASUREMENT) : BOOLEAN is
			-- is new_left a valid left ?
		do
			Result := Precursor (new_left) and then new_left <= right
		ensure then
			less_right: Result implies ( new_left <= right)
		end

	valid_bottom (new_bottom: FO_MEASUREMENT) : BOOLEAN is
			-- is new_bottom a valid bottom ?
		do
			Result := Precursor (new_bottom) and then new_bottom <= top
		ensure then
			less_top: Result implies (new_bottom <= top)
		end

	valid_top (new_top: FO_MEASUREMENT) : BOOLEAN is
			-- is new_top a valid top ?
		do
			Result := Precursor (new_top) and then new_top >= bottom
		ensure then
			greater_bottom: Result implies (new_top >= bottom)
		end

--	valid_rectangle (new_left: FO_MEASUREMENT; new_bottom: FO_MEASUREMENT; new_right: FO_MEASUREMENT; new_top: FO_MEASUREMENT) : BOOLEAN is 
--		do
--			if new_left /= Void and then new_bottom /= Void and then new_right /= Void and then new_top /= Void then
--				Result := (new_right - new_left).as_points > 0
--				Result := Result and then (new_top - new_bottom).as_points > 0
--			end
--		ensure then
--			points_exist: Result implies (new_left /= Void and then new_bottom /= Void and then new_right /= Void and then new_top /= Void)
--			width_positive: Result implies (new_right - new_left).as_points > 0
--			height_positive: Result implies (new_top - new_bottom).as_points > 0
--		end
		
feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation


feature -- Conversion

	as_pdf : PDF_RECTANGLE is
		local
		
		do
			create Result.set(left.as_points, 
							bottom.as_points, 
							right.as_points, 
							top.as_points)
		end

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	merged (other : like Current) : like Current is
			-- Merge Current and other.
		do
			create Result.set (
				left.min (other.left),
				bottom.min (other.bottom),
				right.max (other.right),
				top.max (other.top))
		ensure
			merged_not_void: Result /= Void
		end
		
	shrinked_top (h : FO_MEASUREMENT) : FO_RECTANGLE is
		do
			create Result.set (left, bottom, right, top - h)
		ensure
			result_not_void: Result /= Void
			same_left: Result.left.is_equal (left)
			same_bottom: Result.bottom.is_equal (bottom)
			same_right: Result.right.is_equal (right)
			top_shrinked: Result.top.is_equal (top - h)
		end

	shrinked_bottom (h : FO_MEASUREMENT) : FO_RECTANGLE is
		do
			create Result.set (left, bottom - h, right, top)
		ensure
			result_not_void: Result /= Void
			same_left: Result.left.is_equal (left)
			same_top: Result.top.is_equal (top)
			same_right: Result.right.is_equal (right)
			bottom_shrinked: Result.bottom.is_equal (bottom - h)
		end
		
feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant

	not_negative_width: width /= Void and width.sign >= 0
	not_negative_height: height /= Void and height.sign >= 0
	
end
