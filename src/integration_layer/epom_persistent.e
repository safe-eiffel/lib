indexing
	description: "Object of which existence is independent of the system session in which it was created"
	cluster: "PERSISTENT_OBJECT_MANAGEMENT"
	keywords: "persistent,retrieve,store"
	author: "Fafchamps Eric"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EPOM_PERSISTENT

inherit

	ANY

	EPOM_SHARED_MANAGER_FACTORY
		export
			{NONE} all;
			{ANY} generating_type
		end

	
feature -- Status report for persistent behaviour
	

	session: ECLI_SESSION is 
			-- Session in which persistent behaviour occurs.
		do
			Result := manager.session
		end

	last_epom_error: UT_ERROR
			-- Error of last EPOM operation.

	is_persistent: BOOLEAN
			-- Does this object has a persistent state?

	is_modified: BOOLEAN is
			-- Is this object modified since it's last retrieve or store command?
		do
			Result := is_modified_i
		end

	is_store_needed: BOOLEAN is
			-- Is the store command needed to keep the persistent state up to date?
		do
			Result := not is_persistent or is_modified
		ensure
			Result = (not is_persistent or is_modified)
		end

feature -- Status setting

	set_modified is
			-- Set this object as modified since it's last retrieve or store.
		do
			is_modified_i := True
		ensure
			is_modified: is_modified
		end

	set_not_modified is
			-- Set this object as not been modified since it's last retrieve or store.
		do
			is_modified_i := False
		ensure
			is_not_modified: not is_modified
		end

feature -- Basic operations for persistent behaviour

	store is
			-- Store the persistent state.
		deferred
		ensure
			stored: (last_epom_error = Void) implies (is_persistent and not is_modified)
		end


	retrieve (a_query_frame: EPOM_QUERY_FRAME) is
			-- Retrieve the persistent object by using it's unique indentifier.
		require
			a_query_frame_set: a_query_frame /= Void
		deferred
		ensure
			retrieved: (last_epom_error = Void) implies (is_persistent and not is_modified)
		end

feature {EPOM_STORAGE_MANAGER} -- Support routines for storage managers


	manager: EPOM_STORAGE_MANAGER is
		deferred
		end


	set_persistent is
			-- Set this object as persistent.
		do
			is_persistent := True
		ensure
			is_persistent: is_persistent
		end

	set_not_persistent is
			-- Set this object as not beeing persistent.
		do
			is_persistent := False
		ensure
			not_is_persistent: not is_persistent
		end

feature {NONE} -- Implementation

	is_modified_i: BOOLEAN

	
invariant
	-- manager /= Void implies manager.model_object = Current

end -- class EPOM_PERSISTENT


--
-- Copyright: 2001, Eric Fafchamps, <eric.fafchamps@belgacom.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
