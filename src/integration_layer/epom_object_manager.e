indexing
	description: "Objects that retrieve/store and delete one persistent object in the underlying database"
	author: "Fafchamps Eric"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EPOM_OBJECT_MANAGER

inherit
	EPOM_STORAGE_MANAGER

	
feature -- Basic operations

	delete is
			-- Delete the persistent state of the persistent object.
		require
			persistent_object.is_persistent
		deferred
		ensure
			not persistent_object.is_persistent
		end


end -- class EPOM_OBJECT_MANAGER

--
-- Copyright: 2001, Eric Fafchamps, <eric.fafchamps@belgacom.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
