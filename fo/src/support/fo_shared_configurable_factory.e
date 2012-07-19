indexing

	description: 
	
		"Objects that share a configurable factory."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class FO_SHARED_CONFIGURABLE_FACTORY

feature -- Access

	factory : FO_CONFIGURABLE_FACTORY is
		do
			Result := factory_cell.item
		end
		
feature -- Basic operations

	set_factory (a_factory : FO_CONFIGURABLE_FACTORY) is
		require
			a_factory_not_void: a_factory /= Void
			factory_void: factory = Void
		do
			factory_cell.put (a_factory)
		ensure
			factory_set: factory = a_factory
		end
		
feature {NONE} -- Implementation

	factory_cell : DS_CELL[FO_CONFIGURABLE_FACTORY] is
		once
			create result.make (Void)
		end
		
end

