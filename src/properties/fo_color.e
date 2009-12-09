indexing

	description:

		"Objects that are 24 bit RGB colors"

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_COLOR

inherit

	ANY
		redefine
			is_equal
		end

create
	make_rgb

feature {NONE} -- Initialization

	make_rgb (new_red, new_green, new_blue : INTEGER) is
			-- Initialize `Current'.
		require
			new_red_valid: red >= 0 and red <= 255
			new_green_valid: green >= 0 and green <= 255
			new_blue_valid: blue >= 0 and blue <= 255
		do
			red := new_red
			green := new_green
			blue := new_blue
		ensure
			red_set: red = new_red
			green_set: green = new_green
			blue_set: blue = new_blue
		end

feature -- Access

	blue: INTEGER
		-- Blue level.

	green: INTEGER
		-- Green level.

	red: INTEGER
		-- Red level.

feature -- Element change

	set_blue (a_blue: INTEGER) is
			-- Set `blue' to `a_blue'.
		require
			a_blue_within_bounds: a_blue > 0 and a_blue <= 255
		do
			blue := a_blue
		ensure
			blue_assigned: blue = a_blue
		end

	set_green (a_green: INTEGER) is
			-- Set `green' to `a_green'.
		require
			a_green_within_bounds: a_green > 0 and a_green <= 255
		do
			green := a_green
		ensure
			green_assigned: green = a_green
		end

	set_red (a_red: INTEGER) is
			-- Set `red' to `a_red'.
		require
			a_red_within_bounds: a_red > 0 and a_red <= 255
		do
			red := a_red
		ensure
			red_assigned: red = a_red
		end

feature -- Comparison

	is_equal (other : like Current) : BOOLEAN is
		do
			Result := blue = other.blue and red = other.red and green = other.green
		ensure then
			definition: Result = (blue = other.blue and red = other.red and green = other.green)
		end

invariant
	red_within_bounds: red >= 0 and red <= 255
	green_within_bounds: green >= 0 and green <= 255
	blue_within_bounds: blue >= 0 and blue <= 255

end
