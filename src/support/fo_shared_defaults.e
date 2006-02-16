indexing
	description: "Shared defaults."

class FO_SHARED_DEFAULTS

feature -- Access

	shared_defaults : FO_DEFAULTS is
		once
			create Result
		end	
end
