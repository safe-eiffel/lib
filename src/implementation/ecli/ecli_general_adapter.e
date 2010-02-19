indexing

	description:

		"Ecli partial implementation of PO_ADAPTERs.%
	%	%
	%	If `cache_on_read' is true, the adapter caches all read objects until `clear_cache' is called.%
	%	When `is_enabled_cache_on_write' is True then written object%
	%	also are inserted in the cache."

	authors: "Eric Fafchamps, Paul G. Crismer"

	usage: "%N%
	%	* Inherit from it.%N%
	%	* Implement deferred features. %N%
	%	* Redefine `last_pid'.%N%
	%	%N%
	%	Implement any other access (query) on objects.%N%
	%	Features `read_one' and `read_object_collection' can be used as facility routines for%N%
	%	exact-match or multiple-match queries, respectively."

	date: "$Date$"
	revision: "$Revision$"

deferred class ECLI_GENERAL_ADAPTER[G->PO_PERSISTENT]

inherit

	ECLI_ADAPTER_READ_COLLECTION_SKELETON[G]

	ECLI_ADAPTER_REFRESH_SKELETON[G]

	ECLI_ADAPTER_WRITE_SKELETON[G]

	ECLI_ADAPTER_UPDATE_SKELETON[G]

	ECLI_ADAPTER_DELETE_SKELETON[G]

feature -- Access

	error_handler : PO_ECLI_ERROR_HANDLER

feature {PO_ADAPTER} -- Basic operations

	init_parameters_for_exists (a_pid : like last_pid) is
			-- Initialize parameters of `Sql_exists' with information from `a_pid'.
		do
			--| Redefine in descendant classes
		end

	init_parameters_for_read (a_pid : like last_pid) is
			-- Initialize parameters of `Sql_read' with information from `a_pid'.
		do
			--| Redefine in descendant classes
		end

	init_parameters_for_refresh (a_pid : like last_pid) is
			-- Initialize parameters of `Sql_refresh' with information from `a_pid'.
		do
			--| Redefine in descendant classes
		end

	init_parameters_for_delete (a_pid : like last_pid) is
			-- Initialize parameters of `Sql_delete' with information from `a_pid'.
		do
			--| Redefine in descendant classes
		end

	init_parameters_for_write (object : like last_object; a_pid : like last_pid) is
			-- Initialize parameters of `Sql_write' with information from `object' and `a_pid'.
		do
			--| Redefine in descendant classes
		end

	init_parameters_for_update (object : like last_object; a_pid : like last_pid) is
			-- Initialize parameters of `Sql_update' with information from `object' and `a_pid'.
		do
			--| Redefine in descendant classes
		end

	create_pid_from_object (object : like last_object) is
			--
		do
			--|TODO redefine in descendant classes
		end

feature {PO_ADAPTER} -- Implementation

	write_query : ECLI_QUERY

	update_query : ECLI_QUERY

	delete_query : ECLI_QUERY

	read_cursor : ECLI_CURSOR

	refresh_cursor : ECLI_CURSOR

	read_pid_cursor : ECLI_CURSOR

	exists_cursor : ECLI_CURSOR

	exists_value : INTEGER is
		deferred
		end

	create_error_handler is
		do
			create error_handler.make_null
		end

end
