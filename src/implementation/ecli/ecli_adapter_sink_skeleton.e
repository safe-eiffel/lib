indexing

	description:

		"[
			Adapters using ECLI that implement 
			- all framework accesses as no-operation
			- error_handler and create_error_handler
		]"

	copyright: "Copyright (c) 2004-today, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class ECLI_ADAPTER_SINK_SKELETON[G->PO_PERSISTENT]

inherit

	ECLI_ADAPTER_COMMON_SKELETON[G]

feature {NONE} -- Framework - Access

	error_handler : PO_ECLI_ERROR_HANDLER

feature -- Status report

	can_write : BOOLEAN is do Result := False end
	can_update : BOOLEAN is do Result := False end
	can_delete : BOOLEAN is do Result := False end
	can_refresh : BOOLEAN is do Result := False end
	can_read : BOOLEAN is do Result := False end

feature -- Basic operations

	read (pid: like last_pid) is
		do
			do_nothing
		end

	update (object: like object_anchor) is
		do
			do_nothing
		end

	refresh (object: like object_anchor) is
		do
			do_nothing
		end

	write (object: like object_anchor)  is
		do
			do_nothing
		end

	delete (object: like object_anchor) is
		do
			do_nothing
		end

feature {PO_DATASTORE} -- Framework - Basic operations

	on_adapter_connected is
		do
			do_nothing
		end

	on_adapter_disconnect is
		do
			do_nothing
		end

	create_error_handler is
		do
			create error_handler.make_standard
		end

end
