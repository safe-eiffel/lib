indexing

	description:

		"Objects that share a single PO_MANAGER."

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class PO_SHARED_MANAGER

feature -- Access

	persistence_manager : PO_MANAGER is
			-- Persistence manager singleton.
		do
			Result := cell.item
		ensure
			Result /= Void
		end
		
feature {PO_LAUNCHER} -- Status setting

	set_manager (manager : PO_MANAGER) is
			-- Set `persistence_manager' to `manager'.
		require
			manager_not_void: manager /= Void
		do
			cell.put (manager)
		ensure
			persistence_manager_set: persistence_manager = manager
		end
		
feature {NONE} -- Implementation

	cell : DS_CELL[PO_MANAGER] is
			-- The singleton.
		once
			!! Result.make (Void)
		end

invariant

	cell_not_void: cell /= Void
	
end
