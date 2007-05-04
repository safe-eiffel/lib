indexing

	description:

		"ECLI adapters that implement 'exists' using 'read' access."

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class ECLI_ADAPTER_READ_EXISTS_SKELETON [G -> PO_PERSISTENT]

inherit

	ECLI_ADAPTER_READ_SKELETON [G]


feature {NONE} -- Framework - Implementation

	exists_cursor : ECLI_CURSOR is
		do
			Result := read_cursor
		end

	init_parameters_for_exists (a_pid : like last_pid) is
		do
			init_parameters_for_read (a_pid)
		end

	exists_test (a_cursor : like exists_cursor) : BOOLEAN is
		do
			a_cursor.start
			if a_cursor.is_ok then
				Result := not a_cursor.off
				if Result then
					a_cursor.go_after
				end
			end
		end
		
end
