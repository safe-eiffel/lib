indexing
	description: "Collection of persistent objects"
	author: "Fafchamps Eric"
	date: "$Date$"
	revision: "$Revision$"

class
	EPOM_PERSISTENT_COLLECTION [P->EPOM_PERSISTENT]

inherit

	EPOM_PERSISTENT

feature -- Basic operations for persistent behaviour


	retrieve (a_query_frame: EPOM_QUERY_FRAME) is
			-- Retrieve the persistent state.
		do
			manager.retrieve (a_query_frame)
			if manager.error /= Void then
				last_epom_error := manager.error
			else
				last_epom_error := Void
			end

			if last_epom_error = Void then
				set_persistent
				set_not_modified
			end

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
				set_persistent
				set_not_modified
			end

		end

	manager: EPOM_STORAGE_MANAGER is
			-- Manager of persistent state.
		do
			if manager_i = Void then
				shared_manager_factory.create_storage_manager (Current)
				manager_i := shared_manager_factory.last_object
			end
			Result := manager_i
		end

feature {NONE} -- Storage manager support routines

	parent: EPOM_PERSISTENT
			-- Parent of this collection

	manager_i: EPOM_STORAGE_MANAGER


end -- class EPOM_PERSISTENT_COLLECTION

--
-- Copyright: 2001, Eric Fafchamps, <eric.fafchamps@belgacom.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
