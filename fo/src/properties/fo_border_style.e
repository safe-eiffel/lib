indexing
	description:

		"Border styles."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_BORDER_STYLE

feature -- Access

	style : INTEGER
		-- Style.

feature -- Element change

	set_style_none is
		do
			style := style_none
		end

	set_style_dashed is
		do
			style := style_dashed
		end

	set_style_dot_dashed is
		do
			style := style_dot_dash
		end

	set_style_dotted is
		do
			style := style_dotted
		end

	set_style_solid is
		do
			style := style_solid
		end

	set_style_double is
		do
			style := style_double
		end

feature {FO_BORDER_STYLE, FO_BORDERABLE, FO_INLINE} -- Access

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

feature -- Status report is

	valid_style (a_style : INTEGER) : BOOLEAN is
			-- Is `a_style' valid?
		do
			Result := (a_style >= style_none and a_style <= style_double)
		end

feature -- Constants

	style_none : INTEGER is 0
	style_solid : INTEGER is 1
	style_dashed : INTEGER is 2
	style_dotted : INTEGER is 3
	style_dot_dash : INTEGER is 4
	style_double : INTEGER is 5

feature {NONE} -- Implementation

invariant


end
