indexing
	description: "Persistence adapters for BORROWER objects"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	BORROWER_ADAPTER_ECLI

inherit
	BORROWER_ADAPTER
		redefine
			on_adapter_connected, on_adapter_disconnect
		end

	ECLI_ADAPTER_READ_EXISTS_SKELETON[BORROWER]
		redefine
			last_pid
		end
		
	ECLI_ADAPTER_WRITE_SKELETON[BORROWER]
		redefine
			last_pid
		end

	ECLI_ADAPTER_DELETE_SKELETON[BORROWER]
		redefine
			last_pid
		end
	
	ECLI_ADAPTER_UPDATE_SKELETON[BORROWER]
		redefine
			last_pid
		end
	
	ECLI_ADAPTER_SINK_SKELETON[BORROWER]
		undefine
			on_adapter_connected, on_adapter_disconnect,
			can_delete, can_read, can_write, can_update,
			delete, read, write, update
		redefine
			last_pid
		end

	BORROWER_ADAPTER_ACCESS_ROUTINES
		rename
			borrower_read_like as read_by_name_pattern
		end

creation
	make
	
feature {PO_ADAPTER, PO_CURSOR, PO_REFERENCE, PO_PERSISTENT} -- Access

	last_pid : BORROWER_PID 

feature {PO_DATASTORE}-- Basic operations

	on_adapter_connected is
		do
			create read_cursor.make (datastore.session)
			create write_query.make (datastore.session)
			create update_query.make (datastore.session)
			create delete_query.make (datastore.session)
		end
		
	on_adapter_disconnect is
		do
			read_cursor.close
			write_query.close
			update_query.close
			delete_query.close
		end
		
feature -- Basic operations

	read_by_id (id : INTEGER) is
			-- read by `id'
		do
			create last_pid.make (id)
			read (last_pid)
		end
		
	read_by_name_pattern (name_pattern : STRING) is
			-- read by `name_pattern'
		local
			cursor : BORROWER_READ_LIKE
		do
			create cursor.make (datastore.session)
			do_borrower_read_like (cursor, name_pattern)
			cursor.close
		end

feature {PO_ADAPTER} -- Factory

	create_pid_from_id (id : INTEGER) is
		do
			create last_pid.make (id)
		end

	create_pid_from_object (object : like last_object) is
		do
			create last_pid.make (object.id)
		end
	
feature {NONE} -- Implementation

	init_parameters_for_read (a_pid : like last_pid) is
		do
			read_cursor.set_parameters_object (borrower_id_parameter (a_pid))
		end
		
	init_parameters_for_delete  (a_pid : like last_pid) is
		do
			delete_query.set_parameters_object (borrower_id_parameter (a_pid))
		end

	init_parameters_for_write (object : like last_object; a_pid : like last_pid) is
		do			
			write_query.set_parameters_object (modify_parameters(object, a_pid))
		end

	init_parameters_for_update (object : like last_object; a_pid : like last_pid) is
		do
			update_query.set_parameters_object (modify_parameters (object, a_pid))
		end		

feature {NONE} -- Implementation --factories

	create_object_from_read_cursor (a_cursor : like read_cursor; a_pid : like last_pid) is
		do
			create last_object.make (a_cursor.item.id.as_integer,
				a_cursor.item.name.as_string,
				a_cursor.item.address.as_string)
		end
		
	fill_object_from_read_cursor  (a_cursor : like read_cursor; object : like last_object) is
			-- 
		do
			do_nothing
		end

	extend_cursor_from_borrower_id (id : BORROWER_ID) is
		local
			reference : PO_REFERENCE[BORROWER]
		do
			create last_pid.make (id.id.as_integer)
			last_cursor.add_last_pid (Current)
		end

	borrower_id_parameter (a_pid : like last_pid) : BORROWER_ID is
		do
			create Result.make
			Result.id.set_item (a_pid.id)
		end
		
	modify_parameters (object : like last_object; a_pid : like last_pid) : BORROWER_MODIFY_PARAMETERS is
		do
			create Result.make
			Result.id.set_item (object.id)
			Result.address.set_item (object.address)
			Result.name.set_item (object.name)
		end

feature {NONE} -- Implementation -- datastore access

	read_cursor : BORROWER_READ
	
	write_query : BORROWER_WRITE
	
	update_query : BORROWER_UPDATE
	
	delete_query : BORROWER_DELETE

end
