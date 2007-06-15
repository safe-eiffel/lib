indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FO_BORDER_STYLE

feature -- Access

	style : INTEGER
		-- Style.

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

feature -- Constants

	style_none : INTEGER is 0
	style_solid : INTEGER is 1
	style_dashed : INTEGER is 2
	style_dotted : INTEGER is 3
	style_dot_dash : INTEGER is 4
	style_double : INTEGER is 5

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
