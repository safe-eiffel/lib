indexing

	description:

		"Adapters that interface COPY object with a corresponding datastore"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class COPY_ADAPTER_ECLI

inherit

	COPY_ADAPTER
		redefine
			on_adapter_connected, on_adapter_disconnect
		end

	ECLI_ADAPTER_READ_SKELETON[COPY]
		redefine
			last_pid
		end
		
	ECLI_ADAPTER_WRITE_SKELETON[COPY]
		redefine
			last_pid
		end

	ECLI_ADAPTER_UPDATE_SKELETON[COPY]
		redefine
			last_pid
		end

	ECLI_ADAPTER_DELETE_SKELETON[COPY]
		redefine
			last_pid
		end

	ECLI_ADAPTER_SINK_SKELETON[COPY]
		undefine
			on_adapter_connected, on_adapter_disconnect,
			can_delete, can_read, can_write, can_update,
			delete, read, write, update
		redefine
			last_pid
		end
		
	COPY_ADAPTER_ACCESS_ROUTINES
		rename
			copy_borrowed as read_borrowed
		end

creation

	make
	
feature {NONE} -- Access

	last_pid : COPY_PID

feature -- Basic operations

	read_borrowed is
		require else
			True
		local
			cursor : COPY_BORROWED
		do
			create cursor.make (datastore.session)
			create last_cursor.make
			do_copy_borrowed (cursor)
			cursor.close
			last_object := Void
		end

	read_from_isbn_and_number (an_isbn : STRING; a_number : INTEGER) is
		do
			create last_pid.make (an_isbn, a_number)
			read (last_pid)
		end

	read_from_isbn (isbn : STRING) is
			-- read copies identified by `isbn'
		do
			
		end
		
feature {NONE} -- Factory

		
	create_pid_from_object (an_object : like object_anchor) is
			-- 
		do
			create last_pid.make (an_object.book.isbn, an_object.number)
		end
		
	extend_cursor_from_copy_id (id : COPY_ID) is
		do
			create last_pid.make (id.isbn.as_string, id.serial_number.as_integer)
			last_cursor.add_last_pid (Current)
		end

feature {PO_DATASTORE} -- Basic operations

	on_adapter_connected is
		do
			create read_cursor.make (datastore.session)
			create exists_cursor.make (datastore.session)
			create write_query.make (datastore.session)
			create update_query.make (datastore.session)
			create delete_query.make (datastore.session)
		end

	on_adapter_disconnect is
		do
			read_cursor.close
			exists_cursor.close
			write_query.close
			update_query.close
			delete_query.close
		end
		
feature {NONE} -- Implementation

	init_parameters_for_read (a_pid: like last_pid) is
		local
			parameters : COPY_ID
		do
			parameters := copy_id_from_pid (a_pid)
			read_cursor.set_parameters_object (parameters)
		end

	init_parameters_for_update (object: like last_object; a_pid: like last_pid) is
		local
			parameters : COPY_UPDATE_PARAMETERS
		do
			create parameters.make
			parameters.isbn.set_item (object.book.isbn)
			parameters.serial_number.set_item (object.number)
			if object.borrower /= Void then
				parameters.borrower.set_item (object.borrower.id)
			end
			parameters.loc_row.set_item (object.row)
			parameters.loc_shelf.set_item (object.shelf)
			parameters.loc_store.set_item (object.store)
			update_query.set_parameters_object (parameters)
		end
		
	init_parameters_for_write (object: like last_object; a_pid: like last_pid) is
		local
			parameters : COPY_WRITE_PARAMETERS
		do
			create parameters.make
			parameters.isbn.set_item (object.book.isbn)
			parameters.serial_number.set_item (object.number)
			if object.borrower /= Void then
				parameters.borrower.set_item (object.borrower.id)
			end
			parameters.loc_row.set_item (object.row)
			parameters.loc_shelf.set_item (object.shelf)
			parameters.loc_store.set_item (object.store)
			write_query.set_parameters_object (parameters)
		end
		
	init_parameters_for_exists (a_pid: like last_pid) is
		do
			exists_cursor.set_parameters_object (copy_id_from_pid (a_pid))
		end

	init_parameters_for_delete (a_pid : like last_pid) is
		do
			delete_query.set_parameters_object (copy_id_from_pid (a_pid))
		end
		
	create_object_from_read_cursor (a_cursor : like read_cursor; a_pid : like last_pid) is
		local
			book_adapter : BOOK_ADAPTER
			book_name : BOOK_PERSISTENT_CLASS_NAME
			book_reference : PO_REFERENCE[BOOK]
		do
			create book_name
			persistence_manager.search_adapter (book_name.persistent_class_name)
			if persistence_manager.found then
				book_adapter ?= persistence_manager.last_adapter
			end
			check
				book_adapter_not_void:  book_adapter /= Void
			end
			book_adapter.create_pid_for_isbn (a_cursor.item.isbn.as_string)
			create book_reference.set_pid_from_adapter (book_adapter)
			create last_object.make_lazy (book_reference, a_cursor.item.serial_number.as_integer)
		end
		
	fill_object_from_read_cursor  (a_cursor : like read_cursor; object : like last_object) is
		local
			ba : BORROWER_ADAPTER
			bpn : BORROWER_PERSISTENT_CLASS_NAME
			borrower_id : INTEGER
		do
			object.set_location (a_cursor.item.loc_store.as_integer,
				a_cursor.item.loc_shelf.as_integer,
				a_cursor.item.loc_row.as_integer)
			if not a_cursor.item.borrower.is_null then
				create bpn
				persistence_manager.search_adapter (bpn.persistent_class_name)
				if not persistence_manager.found then
					--| FIXME ERROR!
					status.set_framework_error (status.Error_could_not_find_adapter)
				else
					borrower_id := a_cursor.item.borrower.as_integer
					if borrower_id > 0 then
						ba ?= persistence_manager.last_adapter
						if ba /= Void then
							ba.create_pid_from_id (a_cursor.item.borrower.as_integer)
							object.borrower_reference.set_pid_from_adapter (ba)
						else
							status.set_framework_error (status.Error_could_not_find_adapter)
						end
					else
						object.borrower_reference.reset
					end
				end
			end
		end
	
	read_cursor : COPY_READ

	exists_cursor : COPY_EXIST
	
	delete_query : COPY_DELETE

	write_query : COPY_WRITE
	
	exists_value : INTEGER is do Result := exists_cursor.item.exists_count.as_integer end

	exists_test (a_cursor : like exists_cursor) : BOOLEAN is
		do
			a_cursor.start
			if a_cursor.is_ok then
				Result := a_cursor.item.exists_count.as_integer > 0
				a_cursor.go_after
			end
		end
		
	update_query : COPY_UPDATE
	
	copy_id_from_pid (a_pid : like last_pid) : COPY_ID is
			-- 
		do
			create Result.make
			Result.isbn.set_item (a_pid.isbn)
			Result.serial_number.set_item (a_pid.serial)
		end
		
end
