indexing

	description:

		"Objects that give linear access to a collection of persistent objects."

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class PO_CURSOR [G -> PO_PERSISTENT]

feature -- Access

	item : G is
			-- Current item.
		require
			not_off: not off
		deferred
		ensure
			item_not_void: Result /= Void
		end
		
	first : G is
			-- First item.
		require
			not_empty: not is_empty
		deferred
		ensure
			definition: Result /= Void
		end
		
feature -- Measurement

	count : INTEGER is
			-- Number of elements in cursor.
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
			-- Is there no `item' at current cursor position.
		deferred
		ensure
			before_or_after: Result = (before or after)
		end	
		
feature -- Basic operations

	start is
			-- Start iteration.
		require
		deferred
		ensure
			not_off_or_after: (is_empty and after) or else (not off)
		end

	forth is
			-- Advance cursor forth.
		require
			not_off_or_after: not off or after
		deferred
		ensure
			not_off_or_after: not off or after
		end
		
end

