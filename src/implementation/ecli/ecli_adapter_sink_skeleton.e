indexing
	description: "Adapters using ECLI that implement no access"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECLI_ADAPTER_SINK_SKELETON[G->PO_PERSISTENT]

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

	update (object: like last_object) is
		do
			do_nothing
		end

	refresh (object: like last_object) is
		do
			do_nothing
		end

	write (object: like last_object)  is
		do
			do_nothing
		end

	delete (object: like last_object) is
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
		
		
feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end -- class ECLI_ADAPTER_SINK_SKELETON
