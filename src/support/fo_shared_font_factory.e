indexing

	description: 
	
		"Objects that share a single font factory object."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_SHARED_FONT_FACTORY

feature -- Access

	font_factory : FO_FONT_FACTORY is once create Result.make end

end
