indexing

	description:

		"Adapters using ECLI that implement no access"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class ECLI_ADAPTER_SINK_SKELETON[G->PO_PERSISTENT]

inherit

	ECLI_ADAPTER_COMMON_SKELETON[G]

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

	on_adapter_connected is
		do
			do_nothing
		end
		
	on_adapter_disconnect is
		do
			do_nothing
		end
		
		
end
