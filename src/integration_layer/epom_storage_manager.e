indexing
	description: "Objects that retrieve and store persistent objects in the underlying database"
	cluster: "PERSISTENT_OBJECT_MANAGEMENT"
	keywords: "retrieve,store,manager"
	author: "Paul George Crismer, Fafchamps Eric"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EPOM_STORAGE_MANAGER


feature -- Access

	persistent_object: EPOM_PERSISTENT
			-- Managed persistent object

	session: ECLI_SESSION
			-- Session in wich this manager operates.

feature -- Status report

	error: UT_ERROR
			-- Error of last operation.

feature -- Basic operations

	retrieve (a_query_frame: EPOM_QUERY_FRAME) is
			-- Retrieve the persistent object by using `a_query_frame'.
		require
			a_query_frame_defined: a_query_frame /= Void
		deferred
		ensure
			-- persistent state succesfull retrieved implies persistent_object.is_persistent	
		end


	store is
			-- Store the persistent state of the persistent object.
		deferred
		end

invariant
	session_defined: session /= Void
	row_object_defined: session /= Void
	-- bidirectional: persistent_object.manager = Current

end -- class EPOM_STORAGE_MANAGER

--
-- Copyright: 2001, Eric Fafchamps, <eric.fafchamps@belgacom.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
