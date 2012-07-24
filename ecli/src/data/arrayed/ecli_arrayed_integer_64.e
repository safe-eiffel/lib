indexing

	description:

			"CLI SQL BIGINT arrayed value."

	library: "ECLI : Eiffel Call Level Interface (ODBC) Library. Project SAFE."
	copyright: "Copyright (c) 2001-2006, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class ECLI_ARRAYED_INTEGER_64

inherit

	ECLI_GENERIC_ARRAYED_VALUE [INTEGER_64]
		redefine
			set_item, out
		select
			is_equal, copy
		end

	ECLI_INTEGER_64
		rename
			make as make_single, is_equal as is_equal_item, copy as copy_item
		export
			{NONE} make_single
		undefine
			release_handle, length_indicator_pointer,
			to_external, is_null, set_null, set_item
		redefine
			item, transfer_octet_length, out, trace
		end

create

	make

feature {NONE} -- Initialization

	make (a_capacity : INTEGER) is
			-- make with `capacity' values
		do
			buffer := ecli_c_alloc_array_value (8, a_capacity)
			capacity := a_capacity
			count := capacity
			set_all_null
		end

feature -- Access

	item : INTEGER_64 is
			-- <Precursor>
		do
			Result := item_at (cursor_index)
		end

	item_at (index : INTEGER) : INTEGER_64 is
			--
		do
			Result := c_memory_get_int64 (ecli_c_array_value_get_value_at(buffer,index))
		end

feature -- Status setting

	transfer_octet_length: INTEGER_64 is
		do
			Result := ecli_c_array_value_get_length (buffer)
		end

feature -- Element change

	set_item (value : INTEGER_64) is
			-- set item to 'value', truncating if necessary
		do
			set_item_at (value, cursor_index)
		end

	set_item_at (value : INTEGER_64; index : INTEGER) is
			-- set item to 'value', truncating if necessary
		do
			c_memory_put_int64 (ecli_c_array_value_get_value_at(buffer,index), value)
			ecli_c_array_value_set_length_indicator_at (buffer, transfer_octet_length, index)
		end

feature -- Basic operations

	out : STRING is
		local
			i : INTEGER
		do
			from i := 1
				create Result.make (10)
				Result.append_string ("<<")
			until i > count
			loop
				if is_null_at (i) then
					Result.append_string (out_null)
				else
					Result.append_string (item_at (i).out)
				end
				i := i + 1
				if i <= count then
					Result.append_string (", ")
				end
			end
			Result.append_string (">>")
		end

	trace (a_tracer : ECLI_TRACER) is
		do
			a_tracer.put_integer_64 (Current)
		end

end
