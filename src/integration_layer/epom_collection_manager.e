indexing
	description: "Objects that .."
	author: "Fafchamps Eric"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EPOM_COLLECTION_MANAGER

inherit
	EPOM_STORAGE_MANAGER
		redefine
			persistent_object
		end

feature -- Access

	persistent_object: EPOM_BILINKED_LIST [EPOM_PERSISTENT_OBJECT]
			-- Managed persistent object

end -- class EPOM_COLLECTION_MANAGER

--
-- Copyright: 2001, Eric Fafchamps, <eric.fafchamps@belgacom.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
