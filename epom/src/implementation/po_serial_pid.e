note
	description: "[
		Typed Persistent Identifiers implemented using serial numbers.
		]"

	copyright: "Copyright (c) 2012, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	PO_SERIAL_PID [G -> PO_PERSISTENT]

inherit
	PO_GENERIC_PID [G]

create {PO_ADAPTER}
	make_serial,
	make_serial_unsafe

feature {NONE} -- Initialization

	make_serial (a_serial : NATURAL_64; an_adapter : PO_ADAPTER[G])
			-- Make using `a_serial', for `an_adapter'.
		do
			serial := a_serial
			persistent_class_name := an_adapter.persistent_class_name
		ensure
			serial_set: serial = a_serial
			persistent_class_name_set: persistent_class_name = an_adapter.persistent_class_name
		end

	make_serial_unsafe (a_serial : NATURAL_64; a_persistent_class_name : STRING)
			-- Make using `a_serial', for `a_persistent_class_name'
			-- There is no guarantee that `a_persistent_class_name' is related to an adapter in the system.
		do
			serial := a_serial
			persistent_class_name := a_persistent_class_name.twin
		ensure
			serial_set: serial = a_serial
			persistent_class_name_set: persistent_class_name ~ a_persistent_class_name
		end
		
feature -- Access

	persistent_class_name : STRING

	serial : NATURAL_64

feature -- Conversion

	as_string : STRING
		local
			s : STRING
		do
			s := serial.out
			create Result.make (persistent_class_name.count + s.count)
			Result.append_string (persistent_class_name)
			Result.append_character ('#')
			Result.append_string (s)
		end

end
