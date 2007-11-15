indexing

	description:

		"Weak references to persistent objects."

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class PO_REFERENCE [G -> PO_PERSISTENT]

inherit

	PO_SHARED_MANAGER
	
create

	set_pid_from_adapter, set_item, make_void
	
feature -- Access			
	
	pid : PO_PID
			-- identifier of persistent object

	item : G is
			-- Actual value of referenced item.
		require
			not_void: not is_void
		do
				if object = Void then
					object := get_object
				end
				Result := object			
		ensure
			exists: Result /= Void
			same_pid_when_persistent: Result.is_persistent implies Result.pid.is_equal (pid)
		end

feature -- Status report

	is_void : BOOLEAN is
			-- is this a 'Void' reference ?
		do
			Result := not is_identified or else not has_item
		ensure
			definition: Result = not is_identified or else not has_item
		end
	
	is_identified : BOOLEAN is
			-- is this reference identified by a pid ?
		do
			Result := pid /= Void
		ensure
			definition: Result = (pid /= Void)
		end

	has_item : BOOLEAN is
			-- is this reference attached to an item ?
		require
			is_identified: is_identified
		do
			if object = Void then
				object := get_object
			end
			Result := object /= Void
		end
		
feature {PO_ADAPTER, PO_PERSISTENT, PO_REFERENCE_ACCESS} -- Element change

	set_pid_from_adapter (an_adapter : PO_ADAPTER[G]) is
			-- Set `pid' to `an_adapter.pid'.
		require
			adapter_not_void: an_adapter /= Void
			pid_not_void: an_adapter.last_pid /= Void
		do
			pid := an_adapter.last_pid
		ensure
			definition: pid = an_adapter.last_pid
		end

	set_item (an_object : G) is
			--  set `item' to `an_object'
		require
			an_object_not_void: an_object /= Void
		do
			object := an_object
			if object.is_volatile then
				pid := pid_for (object)
			else
				pid := object.pid
			end
		ensure
			item_set: item = an_object
		end

	make_void, reset is
			-- Reset reference.
		do
			pid := Void
			set_object (Void)
		end
		
feature {NONE} -- Implementation

	get_object : G is
			-- Get object.
		require
			identified: is_identified
		local
			persistent_adapter : PO_ADAPTER[G]
		do
			persistence_manager.search_adapter (pid.persistent_class_name)
			if persistence_manager.found then
				persistent_adapter ?= persistence_manager.last_adapter
				check
					adapter_not_void: persistent_adapter /= Void
				end
				persistent_adapter.read (pid)
				if persistent_adapter.last_cursor.count > 0 then
					Result := persistent_adapter.last_cursor.first
				else
					Result := Void
				end
			end
		end

	object : G
	
	pid_for (an_object : G) : PO_PID is
			-- Pid for  `an_object'.
		local
			persistent_adapter : PO_ADAPTER[G]
		do
			persistence_manager.search_adapter (an_object.persistent_class_name)
			if persistence_manager.found then
				persistent_adapter ?= persistence_manager.last_adapter
				check
					adapter_not_void: persistent_adapter /= Void
				end
				persistent_adapter.create_pid_from_object (an_object)
				if not persistent_adapter.status.is_error then
					Result := persistent_adapter.last_pid
				end
			end
		end

	set_object (an_object : G) is
			-- Set `object' to `an_object'.
		do
			object := an_object
		ensure
			object_set: object = an_object
		end
		
end