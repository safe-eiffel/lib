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
		
create

	make, make_none
	
feature {NONE} -- Initialization

	make (a_style : INTEGER; a_width : FO_MEASUREMENT; a_color : FO_COLOR) is
			-- make with `a_style', `a_width' and `a_color'.
		require
			valid_style: a_style >= style_solid and a_style <= style_double
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
		do
		end
		
feature -- Access

	style : INTEGER
	
	width : FO_MEASUREMENT
	
	color : FO_COLOR

	style_rule : DS_PAIR[ARRAY[INTEGER],INTEGER] is	
			-- Style rule: dash array, phase
		do
			inspect style
			when style_dashed then
				create Result.make (<<3,3>>, 0)
			when style_dotted then
				create Result.make (<<1, 3>>,0)
			when style_dot_dash then
				create Result.make (<<1, 3, 3, 3>>,0)
			else	
				create Result.make (<<>>,0)
			end
		ensure
			style_rule_not_void: Result /= Void
			dash_array_not_void: Result.first /= Void
		end
		
feature -- Measurement

feature -- Status report

	is_none : BOOLEAN is
		do
			Result := style = style_none
		end
		
feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Constants

	style_none : INTEGER is 0
	style_solid : INTEGER is 1
	style_dashed : INTEGER is 2
	style_dotted : INTEGER is 3
	style_dot_dash : INTEGER is 4
	style_double : INTEGER is 5

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
		
feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant

	style_valid: style >= style_none and style <= style_double
	color_not_void: not is_none implies color /= Void
	width_not_void: not is_none implies width /= Void
	width_positive: not is_none implies width.sign = 1
	
end
