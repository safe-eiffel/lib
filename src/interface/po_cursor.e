indexing
	description: "Objects that give linear access to a collection of persistent objects."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PO_CURSOR [G -> PO_PERSISTENT]

feature -- Access

	item : G is
			-- current item
		require
			not_off: not off
		deferred
		ensure
			item_not_void: Result /= Void
		end
		
	first : G is
			-- first item
		require
			not_empty: not is_empty
		deferred
		ensure
			definition: Result /= Void
		end
		
feature -- Measurement

	count : INTEGER is
			-- number of elements in cursor
		deferred
		end

	is_empty : BOOLEAN is
			-- is this cursor empty ?
		do
			Result := (count = 0)
		end
		
feature -- Status report

	before : BOOLEAN is
			-- is current cursor before any item ?
		deferred
		end
		
	after : BOOLEAN is
			-- is current cursor after any item ?
		deferred
		end
		
	off : BOOLEAN is
			-- is there no `item' at current cursor position
		deferred
		ensure
			before_or_after: Result = (before or after)
		end	
		
feature -- Basic operations

	start is
			-- start iteration
		require
		deferred
		ensure
			not_off_or_after: (is_empty and after) or else (not off)
		end

	forth is
			-- advance cursor forth
		require
			not_off_or_after: not off or after
		deferred
		ensure
			not_off_or_after: not off or after
		end
		
end

