indexing

	description:

		"Objects that can persist on some datastore."

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class PO_PERSISTENT

inherit

	PO_SHARED_MANAGER

	PO_STATUS_USE
	PO_STATUS_MANAGEMENT
	
feature {PO_PERSISTENT, PO_REFERENCE, PO_ADAPTER} -- Access

	pid : PO_PID
		-- Persistence identifier, if any

feature -- Access

	persistence_error_meaning : STRING is
			-- Error meaning, if any
		obsolete "use `status.message' instead"
		require
			status.is_error
		do
			Result := status.message
		end

	persistent_class_name : STRING is
		-- Name of class for persistence. 
		-- To be redefined when a single adapter takes care of
		-- a whole class hierarchy (different classes, same persistent class name)
		deferred
		end
		
feature -- Status report

	is_persistent : BOOLEAN is
			-- does Current have a persistent image on datastore ?
		do
			Result := (pid /= Void)
		end
		
	is_volatile : BOOLEAN is
			-- does Current have no persistent image on datastore ?
		do
			Result := (pid = Void)
		ensure
			definition: Result = not is_persistent
		end
		
	is_deleted : BOOLEAN is
			-- has Current's persistent image been deleted from datastore ?
		do
			Result := deleted_impl
		end
		
	is_modified : BOOLEAN is
			-- has Current been modified since last persistence operation ?
		do
			Result := modified_impl
		end

	is_persistence_error : BOOLEAN is
			-- has last persistence operation given an error ?
		obsolete "use `status.is_error" 
		do
			Result := status.is_error
		end

	exists : BOOLEAN is
			-- Does current object exist in datastore ?
		local
			adapter : PO_ADAPTER[like Current]
		do
			if is_persistent then
				Result := True
			elseif is_deleted then
				Result := False
			elseif is_volatile then
				adapter := adapter_for_me
				if adapter /= Void then
					Result := adapter.exists (adapter.pid_for_object (Current))
				end
			end
		end		

	is_writable : BOOLEAN is
			-- Is Current writable on datastore?
		do
			Result := adapter_for_me.can_write
		end
		
	is_updatable : BOOLEAN is
			-- Is Current updatable on datastore?
		do
			Result := adapter_for_me.can_update
		end
		
	is_refreshable : BOOLEAN is
			-- Is Current refreshable from datastore?
		do
			Result := adapter_for_me.can_refresh
		end
		
	is_deletable : BOOLEAN is
			-- Is Current deletable on datastore?
		do
			Result := adapter_for_me.can_delete
		end
		
feature {PO_ADAPTER} -- Status setting

	set_deleted is
			-- set `is_deleted' to `value'
		require
			is_persistent: is_persistent
		do
			deleted_impl := True
			pid := Void
		ensure
			is_deleted: is_deleted
			is_volatile: is_volatile
		end

feature  {PO_ADAPTER } -- Element change

	set_pid (p : PO_PID ) is
			-- set `pid' to `p'
		require
			p_not_void: p /= Void
			same_persistent_class_names : p.persistent_class_name.is_equal (persistent_class_name)
		do
			pid := p
		ensure
			shared_pid: pid = p
			same_class_names: equal (persistent_class_name, pid.persistent_class_name)
		end

feature -- Basic operations

	write is
			-- write current object state to data store
		require
			volatile: is_volatile
			writable: is_writable
			has_adapter: persistence_manager.has_adapter (persistent_class_name)
		local
			adapter : PO_ADAPTER[like Current]
		do
			adapter := adapter_for_me
			if adapter /= Void then
				adapter.write (Current)
				status.copy (adapter.status)
				if not status.is_error then
					set_modified(False)
				end
			else
				status.copy (persistence_manager.status)
			end
		ensure
			definition: not status.is_error implies (is_persistent and then exists and then not is_modified)
		end
		
	update is
			-- update data store from current object state
		require
			persistent: is_persistent
			updatable: is_updatable			
		local
			adapter : PO_ADAPTER[like Current]
		do
			adapter := adapter_for_me
			if adapter /= Void then
				adapter.update (Current)
--				status.copy (adapter.status)
				status.copy (adapter.status)
				if not status.is_error then
					set_modified(False)
				end
			else
				status.copy (persistence_manager.status)
			end
		ensure
			definition: not status.is_error implies not is_modified
		end

	delete is
			-- delete current object state from data store
		require
			persistent: is_persistent
			deletable: is_deletable
		local
			adapter : PO_ADAPTER[like Current]
		do
			adapter := adapter_for_me
			if adapter /= Void then
				adapter.delete (Current)
				status.copy (adapter.status)
				if not status.is_error then
					pid := Void
				end
			else
				status.copy (persistence_manager.status)
			end
		ensure
			deleted: not status.is_error implies is_deleted and then not exists
			volatile: not status.is_error implies is_volatile
		end
		
	refresh is
			-- delete current object state from data store
		require
			persistent: is_persistent
			refreshable: is_refreshable
		local
			adapter : PO_ADAPTER[like Current]
		do
			adapter := adapter_for_me
			if adapter /= Void then
				adapter.refresh (Current)
				status.copy (adapter.status)
				if not status.is_error then
					set_modified(False)
				end
			else
				status.copy (persistence_manager.status)
			end
		ensure
			definition: not status.is_error implies not is_modified
		end
		
feature {NONE} -- Implementation

	adapter_for_me : PO_ADAPTER[like Current] is
		local
			persistent_name : STRING	
		do
			if pid = Void then
				persistent_name := persistent_class_name
			else
				persistent_name := pid.persistent_class_name
			end
			persistence_manager.search_adapter (persistent_name)			
			if persistence_manager.found then
				Result ?= persistence_manager.last_adapter
			end
		end
	
	set_modified (value : BOOLEAN) is
			-- set `is_modified' to `value'
		do
			modified_impl := Value
		end

	modified_impl : BOOLEAN

	deleted_impl : BOOLEAN
	
invariant

	persistent_has_a_pid: is_persistent implies pid /= Void
	persistent_class_name_not_void: persistent_class_name /= Void and not persistent_class_name.is_empty
	volatile_and_persistent_state_are_exclusive: is_volatile xor is_persistent
	deleted_implies_volatile: is_deleted implies is_volatile
	
end
