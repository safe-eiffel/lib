indexing
	description: "Access to Math routines"
	author: "Paul G. Crismer"
	date: "$Date :$"
	revision: "$Revision :$"

class
	EPDF_IMPORTED_MATH

feature -- Access

	math : EPDF_MATH is
		once
			create Result
		end

end -- class EPDF_IMPORTED_MATH

