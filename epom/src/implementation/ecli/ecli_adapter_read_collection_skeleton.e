indexing
	description: "Adapters using ECLI that implement read accesses with support for reading collections of objects"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECLI_ADAPTER_READ_COLLECTION_SKELETON[G->PO_PERSISTENT]

obsolete "Please use query assistant generated access routines"

inherit
	ECLI_ADAPTER_READ_SKELETON[G]

feature {PO_ADAPTER} -- Access

	read_pid_cursor : ECLI_CURSOR is
		deferred
		end

feature {PO_ADAPTER} -- Basic operations

	create_pid_from_read_pid_cursor is
			-- Create `last_pid' based on the content of the read_pid_cursor.
		require
			last_pid_void: last_pid = Void
			row_exists: read_pid_cursor /= Void and then not read_pid_cursor.off
		deferred
		ensure
			adapted_count:  not status.is_error implies last_pid /= Void
		end

	create_last_cursor is
			-- Create last_cursor on result-set.
		do
			create last_cursor.make
		end


feature  {NONE} -- Implementation facilities for descendants

	read_object_collection is
			-- Read a collection of objects from current `read_cursor'.
		require
			read_cursor_ready: read_cursor /= Void
		do
			last_object := default_value
			create_last_cursor
			read_cursor.start
			if read_cursor.is_ok then
				from
					status.reset
				until
					read_cursor.off
				loop
					last_object := default_value
					create_object_from_read_cursor (read_cursor, Void)
					if last_object /= Void then
						fill_object_from_read_cursor (read_cursor, last_object)
						last_cursor.add_object (last_object)
					end
					read_cursor.forth
				end
			else
				status.set_datastore_error (read_cursor.native_code, read_cursor.diagnostic_message)
			end
			last_object := default_value
		end

	read_pid_collection is
			-- Read a collection of pid from current `read_pid_cursor'.
			-- uses `create_pid_from_read_pid_cursor' and `add_pid_to_cursor'
		require
			read_pid_cursor_ready: read_pid_cursor /= Void
		do
			last_object := default_value
			create_last_cursor
			read_pid_cursor.start
			if read_pid_cursor.is_ok then
				from
					status.reset
				until
					read_pid_cursor.off
				loop
					last_pid := Void
					create_pid_from_read_pid_cursor
					if last_pid /= Void then
						last_cursor.add_last_pid (Current)
					end
					read_pid_cursor.forth
				end
			else
				status.set_datastore_error (read_pid_cursor.native_code, read_pid_cursor.diagnostic_message)
			end
		end

end -- class ECLI_ADAPTER_READ_COLLECTION_SKELETON
