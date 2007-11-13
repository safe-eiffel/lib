indexing

	description:

		"Borders around a rectangular area."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_BORDER

inherit
	ANY
		redefine
			is_equal
		end

	FO_BORDER_STYLE
		undefine
			is_equal
		end

create

	make, make_none

feature {NONE} -- Initialization

	make (a_style : INTEGER; a_width : FO_MEASUREMENT; a_color : FO_COLOR) is
			-- make with `a_style', `a_width' and `a_color'.
		require
			valid_style: valid_style (a_style)
			a_width_not_void: a_width /= Void
			a_width_positive: a_width.sign = 1
			a_color_not_void: a_color /= Void
		do
			style := a_style
			width := a_width
			color := a_color
		ensure
			style_set: style = a_style
			width_set: width = a_width
			color_set: color = a_color
		end

	make_none is
			-- Make no border.
		do
			do_nothing
		ensure
			is_none: is_none
		end

feature -- Access

	width : FO_MEASUREMENT
		-- Line width.

	color : FO_COLOR
		-- Color.

feature -- Status report

	is_none : BOOLEAN is
			-- Is border inefficient?
		do
			Result := style = style_none
		end

feature -- Comparison

	is_equal (other : like Current) : BOOLEAN is
		do
			if other = Current then
				Result := True
			elseif is_none and other.is_none then
				Result := True
			elseif not is_none and not other.is_none then
				Result := style = other.style
				Result := Result and (color.is_equal (other.color))
				Result := Result and (width.is_equal (other.width))
			end
		end

invariant

	style_valid: style >= style_none and style <= style_double
	color_not_void: not is_none implies color /= Void
	width_not_void: not is_none implies width /= Void
	width_positive: not is_none implies width.sign = 1

end
