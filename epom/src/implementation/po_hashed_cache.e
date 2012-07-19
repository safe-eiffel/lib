indexing
	description: "Caches of Persistent objects, implemented with a hash table"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PO_HASHED_CACHE [G -> PO_PERSISTENT]

inherit
	PO_CACHE [G]

create
	make

feature -- Initialization

	make (new_capacity : INTEGER) is
			-- Make with capacity `new_capacity'
		do
			create table.make (new_capacity)
			table.set_equality_tester (create {KL_EQUALITY_TESTER[G]})
			create pid_list.make
		ensure
			capacity_set: capacity = new_capacity
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

feature -- Element change

	put (object : G) is
		do
			table.force (object, object.pid.as_string)
			pid_list.put_last (object.pid)
		end

	put_void (pid : PO_PID) is
		do
			table.force (default_value, pid.as_string)
			pid_list.put_last (pid)
		end

feature -- Removal

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

	wipe_out is
		do
			table.wipe_out
			pid_list.wipe_out
		end

feature -- Basic operations

	search (a_pid : PO_PID) is
		do
			table.search (a_pid.as_string)
			found := table.found
		end

feature {NONE} -- Implementation

	pid_list : DS_LINKED_LIST[PO_PID]

	table : DS_HASH_TABLE [G, STRING]

	default_value : G is do  end

invariant

	pid_list_not_void: pid_list /= Void
	table_not_void: table /= Void

end -- class PO_HASHED_CACHE
