indexing

	description:

		"generated access routines"
	usage: "mix-in"

deferred class COPY_ADAPTER_ACCESS_ROUTINES

inherit

	PO_STATUS_USE
	PO_STATUS_MANAGEMENT

feature  -- Access

	last_object: PO_PERSISTENT is
		deferred
		end

	last_cursor: PO_CURSOR[like last_object] is
		deferred
		end

feature  -- Status report

	is_error: BOOLEAN is
			-- did last operation produce an error?
		deferred
		end

feature  -- Basic operations

	copy_borrowed is
		require
			refine_in_descendants: False
		deferred
		end

feature {NONE} -- Implementation

	do_copy_borrowed (cursor: COPY_BORROWED) is
			-- helper implementation of access `COPY_BORROWED'
		require
			cursor_not_void:  cursor /= Void
		do
			from
				cursor.start
				status.reset
			until
				status.is_error or else not cursor.is_ok or else cursor.off
			loop
				extend_cursor_from_copy_id (cursor.item)
				cursor.forth
			end
			if cursor.is_error then
				status.set_datastore_error (cursor.native_code, cursor.diagnostic_message)
			elseif cursor.is_ok and cursor.has_information_message then
				status.set_datastore_warning (cursor.native_code, cursor.diagnostic_message)
			end
		end

	extend_cursor_from_copy_id (row: COPY_ID) is
		require
			row_not_void:  row /= Void
			last_cursor_not_void:  last_cursor /= Void
		deferred
		ensure
			last_cursor_extended: not is_error implies (last_cursor.count = old (last_cursor.count) + 1)
		end

end
