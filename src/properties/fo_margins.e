indexing

	description: 
	
		"Margins"

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_MARGINS

inherit
	FO_TUPLE_4
	
create
	make, set

feature -- Measurement

	content_region (box : FO_RECTANGLE) : FO_RECTANGLE is
			-- content region of margins applied to `box'
		do
			create Result.set (
			box.left + left,
			box.bottom + bottom,
			box.right - right,
			box.top - top)
		ensure
			content_region_not_void: Result /= Void
			content_region_left: Result.left.is_equal (box.left + left)
			content_region_right: Result.right.is_equal (box.right - right)
			content_region_top: Result.top.is_equal (box.top - top)
			content_region_bottom: Result.bottom.is_equal (box.bottom + bottom)
		end

end

