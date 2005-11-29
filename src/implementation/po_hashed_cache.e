indexing
	description: "Caches of Persistent objects, implemented with a hash table"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PO_HASHED_CACHE [G -> PO_PERSISTENT]

inherit
	PO_CACHE [G]
		
creation
	make
	
feature -- Initialization

	make (new_capacity : INTEGER) is
		do
			create table.make (new_capacity)
			table.set_equality_tester (create {KL_EQUALITY_TESTER[G]})
			create pid_list.make
		end
		
feature -- Access

	item (pid : PO_PID) : G is
		do
			Result := table.item (pid.as_string)
		end
		
	new_cursor : DS_LIST_CURSOR [PO_PID] is
		do
			Result := pid_list.new_cursor
		end
	
	found_item : G is
		do
			Result := table.found_item
		end
		
feature -- Measurement

	count : INTEGER is
			-- Count of items.
		do
			Result := table.count
		end
		
	capacity : INTEGER is
			-- Capacity of container.
		do
			Result := table.capacity
		end
		
feature -- Status report

	has (pid : PO_PID) : BOOLEAN is
		do
			Result := table.has (pid.as_string)
		end

	found : BOOLEAN
	
feature -- Status setting

feature -- Cursor movement

feature -- Element change

	put (object : G) is
		do
			table.force (object, object.pid.as_string)
			pid_list.put_last (object.pid)
		end
		
	put_void (pid : PO_PID) is
		do
			table.force (Void, pid.as_string)	
			pid_list.put_last (pid)
		end

	remove (pid : PO_PID) is
		local
			cursor : DS_LIST_CURSOR[PO_PID]
		do
			table.remove (pid.as_string)
			cursor := pid_list.new_cursor
			cursor.start
			cursor.search_forth (pid)
			if not cursor.off then
				cursor.remove
			end
		ensure then
			removed_from_list: not pid_list.has (pid)
		end
		
feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	wipe_out is
		do
			table.wipe_out
			pid_list.wipe_out
		end

	search (a_pid : PO_PID) is
		do
			table.search (a_pid.as_string)
			found := table.found
		end
		
feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	pid_list : DS_LINKED_LIST[PO_PID]
	
	table : DS_HASH_TABLE [G, STRING]
	
invariant

	pid_list_not_void: pid_list /= Void
	table_not_void: table /= Void
	
end -- class PO_HASHED_CACHE
