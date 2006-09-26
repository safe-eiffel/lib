indexing

	description: 
	
		"Objects that can be colored"

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_COLORABLE

inherit
	
	ANY
		redefine
			is_equal
		end
		
feature -- Access

	foreground_color: FO_COLOR

	background_color: FO_COLOR

feature -- Element change

	set_foreground_color (a_foreground_color: FO_COLOR) is
			-- Set `foreground_color' to `a_foreground_color'.
		require
			a_foreground_color_not_void: a_foreground_color /= Void
		do
			foreground_color := a_foreground_color
		ensure
			foreground_color_assigned: foreground_color = a_foreground_color
		end

	set_background_color (a_background_color: FO_COLOR) is
			-- Set `background_color' to `a_background_color'.
		require
			a_background_color_not_void: a_background_color /= Void
		do
			background_color := a_background_color
		ensure
			background_color_assigned: background_color = a_background_color
		end

feature -- Comparison

	is_equal (other : like Current) : BOOLEAN is
		do
			Result := same_colorable (other)
		end

	same_colorable (other : like Current) : BOOLEAN is		
		do
			Result := background_color.is_equal (other.background_color) and
			 foreground_color.is_equal (other.foreground_color)
		end
		
invariant

	background_color_not_void: background_color /= Void
	foreground_color_not_void: foreground_color /= Void

end
