indexing
	description: "Objects that share a single PO_MANAGER."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PO_SHARED_MANAGER

feature -- Access

	persistence_manager : PO_MANAGER is
			-- persistence manager singleton
		do
			Result := cell.item
		ensure
			Result /= Void
		end
		
feature -- Measurement

feature -- Status report

feature {PO_LAUNCHER} -- Status setting

	set_manager (manager : PO_MANAGER) is
			-- set `persistence_manager' to `manager'
		require
			manager_not_void: manager /= Void
		do
			cell.put (manager)
		ensure
			persistence_manager_set: persistence_manager = manager
		end
		
feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	cell : DS_CELL[PO_MANAGER] is
			-- the singleton
		once
			!! Result.make (Void)
		end

invariant
	cell_not_void: cell /= Void
	
end -- class PO_SHARED_MANAGER
