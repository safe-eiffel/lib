indexing
	description: "Object of which existence is independent of the system session in which it was created"
	cluster: "PERSISTENT_OBJECT_MANAGEMENT"
	keywords: "persistent,retrieve,store"
	author: "Fafchamps Eric"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EPOM_PERSISTENT_OBJECT

inherit

	ANY

	EPOM_PERSISTENT

	
feature -- Basic operations for persistent behaviour

	retrieve (a_query_frame: EPOM_QUERY_FRAME) is
			-- Retrieve the persistent object by using it's unique indentifier.
		do
			manager.retrieve (a_query_frame)
			if manager.error /= Void then
				last_epom_error := manager.error
			else
				last_epom_error := Void
			end

			if last_epom_error = Void then
				def_persistent
				def_not_modified
			end
		end

	delete is
			-- Delete the persistent state of current.
		require
			is_persistent: is_persistent
		do
			manager.delete
			if manager.error /= Void then
				last_epom_error := manager.error
			else
				last_epom_error := Void
			end

			if last_epom_error = Void then
				def_not_persistent
				def_not_modified
			end
		ensure
			not_is_modified: not is_modified
			not_is_persistent: not is_persistent		
		end


	store is
			-- Store the persistent state.
		do
			manager.store
			if manager.error /= Void then
				last_epom_error := manager.error
			else
				last_epom_error := Void
			end
			
			if last_epom_error = Void then
				def_persistent
				def_not_modified
			end
			
		end


feature {EPOM_STORAGE_MANAGER} -- Support routines for storage managers


	manager: EPOM_OBJECT_MANAGER is
			-- Manager of persistent state.
		do
			if manager_i = Void then
				shared_manager_factory.create_storage_manager (Current)
				manager_i ?= shared_manager_factory.last_object
			end
			Result := manager_i
		end
feature {NONE} -- Implementation

	manager_i: EPOM_OBJECT_MANAGER

end -- class EPOM_PERSISTENT_OBJECT

--
-- Copyright: 2001, Eric Fafchamps, <eric.fafchamps@belgacom.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
