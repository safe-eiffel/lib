indexing
	description: "Objects that creates a EPOM_STORAGE_MANAGER for a persistent object"
	usage: "Systems should define default_session and define create_storage_manager in a descendant using generating_type of a_persistent_object to set last_object to a new storage manager"
	author: "Fafchamps Eric"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EPOM_MANAGER_FACTORY

feature -- Access

	last_object: EPOM_STORAGE_MANAGER
			-- Last created storage manager

feature -- Basic operation

	create_storage_manager (a_persistent_object: EPOM_PERSISTENT) is
			-- Create a storage_manager for `a_persistent_object'.
		require
			persistent_object_exists: a_persistent_object /= Void
		deferred
		end

	default_session: ECLI_SESSION is
			-- Default session in which storage managers operates.
		deferred
		end

end -- class EPOM_MANAGER_FACTORY

--
-- Copyright: 2001, Eric Fafchamps, <eric.fafchamps@belgacom.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
