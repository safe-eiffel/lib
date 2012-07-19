indexing
	description:

		"Shared defaults."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class FO_SHARED_DEFAULTS

feature -- Access

	shared_defaults : FO_DEFAULTS is
		once
			create Result
		end
end
