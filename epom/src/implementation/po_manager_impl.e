indexing

	description:

		"Objects that implement persistence manager."

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class PO_MANAGER_IMPL

inherit

	PO_MANAGER

create

	make

feature {NONE} -- Initialization

	make is
			-- Creation.

		do
			create adapters_table.make (10)
			create error_handler.make_null
		end

feature -- Access

	adapters : DS_LIST [PO_ADAPTER[PO_PERSISTENT]] is
		local
			cursor : DS_HASH_TABLE_CURSOR[PO_ADAPTER[PO_PERSISTENT],STRING]
		do
			create {DS_LINKED_LIST[PO_ADAPTER[PO_PERSISTENT]]}Result.make
			from
				cursor := adapters_table.new_cursor
				cursor.start
			until
				cursor.off
			loop
				Result.put_last (cursor.item)
				cursor.forth
			end
		end

	error_handler : PO_ERROR_HANDLER

feature -- Measurement

	count: INTEGER is
		do
			Result := adapters_table.count
		end

feature -- Status report


	found: BOOLEAN is
		do
			Result := adapters_table.found
		end

	has_adapter (class_name: STRING): BOOLEAN is
		do
			last_adapter := Void
			adapters_table.search (class_name)
			if adapters_table.found then
				Result := True
				last_adapter := adapters_table.found_item
			end
		end

feature -- Element change

feature {PO_LAUNCHER} -- Element change

	add_adapter (an_adapter: PO_ADAPTER [PO_PERSISTENT]) is
		do
			adapters_table.force (an_adapter, an_adapter.persistent_class_name)
		end

	set_error_handler (an_error_handler : PO_ERROR_HANDLER) is
		do
			error_handler := an_error_handler
		end

feature -- Basic operations

	search_adapter (class_name: STRING) is
		do
			adapters_table.search (class_name)
			if adapters_table.found then
				last_adapter := adapters_table.found_item
			else
				last_adapter := Void
				status.set_framework_error (status.Error_could_not_find_adapter)
				error_handler.report_could_not_find_adapter (class_name, generator, "search_adapter")
			end
		end

feature {NONE} -- Implementation

	adapters_table : DS_HASH_TABLE [PO_ADAPTER[PO_PERSISTENT], STRING]

invariant

	adapters_table_not_void: adapters_table /= Void

end
