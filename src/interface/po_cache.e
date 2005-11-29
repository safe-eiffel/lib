indexing
	description: "Caches that hold PO_PERSISTENT object keyed by their pid"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class 	PO_CACHE [G-> PO_PERSISTENT]

feature -- Access

	item (a_pid : PO_PID) : G is
			-- Item associated to `a_pid'.
		require
			a_pid_not_void: a_pid /= Void
			has_a_pid: has (a_pid)
		deferred
		ensure
			same_pids: Result.pid.is_equal (a_pid) 
		end
		
	new_cursor : DS_LIST_CURSOR[PO_PID] is
			-- Cursor on a list of PO_PID that are associated in Current.
		deferred
		ensure
			result_not_void: Result /= Void
		end

	found_item : G is
			-- Found item by last search operation.
		deferred
		end
		
feature -- Measurement

	count : INTEGER is
			-- Count of cached objects.
		deferred
		end
		
feature -- Status report

	has (a_pid : PO_PID) : BOOLEAN is
			-- Has `a_pid' been associated ?
		require
			a_pid_not_void: a_pid /= Void
		deferred
		ensure
			definition: Result implies item (a_pid).pid.is_equal (a_pid)
		end

	has_item (object : G) : BOOLEAN is
			-- Is `object' cached ?
		require
			object_not_void: object /= Void
		do
			if object.is_persistent then
				search (object.pid)
				if found then
					Result := (object = found_item)
				end
			end
		ensure
			definition: Result implies (object.is_persistent and then has (object.pid) and then item (object.pid) = object)
		end

	found : BOOLEAN is
			-- Has last search operation succeeded ?
		deferred
		end
		
feature -- Element change
		
	put (object : G) is
			-- Put `object' in cache.
		require
			object_not_void: object /= Void
			object_persistent: object /= Void implies object.is_persistent
		deferred
		ensure
			definition: has (object.pid) and then item (object.pid) = object
		end
		
	put_void (pid : PO_PID) is
			-- Cache the fact that `pid' is associated with Void.
		require
			pid_not_void: pid /= Void
		deferred
		ensure
			definition: has (pid) and then item (pid) = Void
		end

	remove (pid : PO_PID) is
			-- Remove the association [pid, object].
		require
			pid_not_void: pid /= Void
		deferred
		ensure
			definition: not has (pid)
		end
		
feature -- Basic operations

	wipe_out is
			-- Wipe all elements.
		deferred
		ensure
			no_items: count = 0
		end

	search (a_pid : PO_PID) is
			-- Search for `a_pid'.
		require
			a_pid_not_void: a_pid /= Void
		deferred
		end
		
end -- class PO_CACHE
