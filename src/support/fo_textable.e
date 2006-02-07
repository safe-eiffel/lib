indexing

	description: 
	
		"Objects that can render text."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class FO_TEXTABLE

inherit
	
	FO_RENDERABLE
		redefine
			is_equal
		end

	FO_FONT_ABLE
		undefine
			out, is_equal
		end
		
	FO_COLOR_ABLE
		undefine
			out
		redefine
			is_equal
		end

feature -- Comparison

	is_equal (other : like Current) : BOOLEAN is
		do
			Result := same_fontable (other) and same_colorable (other)
		end

end
