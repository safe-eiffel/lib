indexing

	description:

		"Book adapter implemented using ECLI"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class BOOK_ADAPTER_ECLI

inherit

	BOOK_ADAPTER
		redefine
			on_adapter_connected, on_adapter_disconnect
		end

	ECLI_ADAPTER_READ_EXISTS_SKELETON[BOOK]
		redefine
			last_pid
		end
		
	ECLI_ADAPTER_WRITE_SKELETON[BOOK]
		redefine
			last_pid
		end

	ECLI_ADAPTER_DELETE_SKELETON[BOOK]
		redefine
			last_pid
		end
	
	ECLI_ADAPTER_UPDATE_SKELETON[BOOK]
		redefine
			last_pid
		end
	
	ECLI_ADAPTER_SINK_SKELETON[BOOK]
		undefine
			on_adapter_connected, on_adapter_disconnect,
			can_delete, can_read, can_write, can_update,
			delete, read, write, update
		redefine
			last_pid
		end

	BOOK_ADAPTER_ACCESS_ROUTINES
		rename
			book_read_by_title as read_by_title
		end

creation

	make
	
feature {PO_ADAPTER}-- Access

	last_pid : BOOK_PID

feature {NONE}-- Basic operations

	create_pid_from_object (b : like object_anchor) is
			-- 
		do
			create last_pid.make_from_isbn (b.isbn)
		end
		
feature {PO_ADAPTER} -- Factory

	create_pid_for_isbn (an_isbn : STRING) is
		do
			create last_pid.make_from_isbn (an_isbn)
		end
		
feature -- Basic operations

	read_by_isbn (isbn : STRING) is
			-- Read by `isbn'.
		do
			create last_pid.make_from_isbn (isbn)
			read (last_pid)
		end
		
	read_by_title (title : STRING) is
			-- Read by `title'.
		require else
			title_not_void:  title /= Void
		local
			cursor : BOOK_READ_BY_TITLE
		do
			create cursor.make (session)
			create last_cursor.make
			do_book_read_by_title (cursor, title)
			cursor.close
			last_object := Void -- ensure invariant

		end
		
	read_by_author (author_name : STRING) is
		do
		end
		
feature -- Obsolete

feature {NONE} -- Inapplicable

	session : ECLI_SESSION is do Result := datastore.session end
	
feature {NONE} -- Implementation

	read_cursor : BOOK_READ_BY_ISBN
	
	update_query : BOOK_UPDATE
	
	delete_query : BOOK_DELETE

	on_adapter_connected is
		do
			create read_cursor.make (session)
			create write_query.make (session)
			create update_query.make (session)
			create delete_query.make (session)
		end
		
	on_adapter_disconnect is
		do
			read_cursor.close
			write_query.close
			update_query.close
			delete_query.close
		end

	init_parameters_for_read (a_pid : like last_pid) is
			-- 
		do
			read_cursor.set_parameters_object (book_id_parameter (a_pid))
		end
		
	init_parameters_for_delete  (a_pid : like last_pid) is
			-- 
		do
			delete_query.set_parameters_object (book_id_parameter (a_pid))
		end

	create_object_from_read_cursor (a_cursor : like read_cursor; a_pid : like last_pid) is
		do
			create_last_object_from_book_row (a_cursor.item)
		end

	extend_cursor_from_book_row (row : BOOK_ROW) is
		do
			create_last_object_from_book_row (row)
			last_cursor.add_object (last_object)
		end

	create_last_object_from_book_row (row : BOOK_ROW) is
		do
			create last_object.make (row.isbn.as_string, row.title.as_string, row.author.as_string)
			create_pid_from_object (last_object)
			last_object.set_pid (last_pid)
		end
		
	fill_object_from_read_cursor (a_cursor : like read_cursor; object : like last_object) is
			-- 
		do
			do_nothing
		end

	init_parameters_for_write (object : like last_object; a_pid : like last_pid) is
		do			
			write_query.set_parameters_object (modify_parameters(object, a_pid))
		end

	init_parameters_for_update (object : like last_object; a_pid : like last_pid) is
			-- 
		do
			update_query.set_parameters_object (modify_parameters (object, a_pid))
		end		
	
	write_query : BOOK_WRITE
	
	modify_parameters (object : like last_object; a_pid : like last_pid) : BOOK_MODIFY_PARAMETERS is
		do
			create Result.make
			Result.isbn.set_item (a_pid.isbn)
			Result.author.set_item (object.author)
			Result.title.set_item (object.title)			
		end
	
	book_id_parameter (a_pid : like last_pid) : BOOK_ID is
		do
			create Result.make
			Result.isbn.set_item (a_pid.isbn)
		end

end
