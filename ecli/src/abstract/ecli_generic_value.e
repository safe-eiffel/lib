note

	description:

		"Objects that represent typed values to be exchanged with the database."

	library: "ECLI : Eiffel Call Level Interface (ODBC) Library. Project SAFE."
	Copyright: "Copyright (c) 2001-2012, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class ECLI_GENERIC_VALUE [G -> attached ANY]

inherit

	ECLI_VALUE
		redefine
			out, copy
		end

feature -- Access

	item : G
			-- Actual Eiffel value
		require
			not_null: not is_null
		do
			check attached impl_item as i then
				Result := i
			end
		ensure
			not_void: Result /= Void --FIXME: VS-DEL
		end

feature -- Element change

	set_item (value: G)
			-- Set `item' with content of `value'
		require
			value_valid: valid_item (value)
		deferred
		ensure
			item_set: equal (item, formatted (value))
			not_null: not is_null
		end

feature -- Conversion

	formatted (v : G) : G
			-- 'v' formatted according to 'column_precision'
			-- does nothing, except for fixed format types like CHAR
			-- where values are either truncated or padded by blanks
		do
			Result := v
		end

	out : STRING
		do
			if is_null then
				Result := out_null
			else
				Result := item.out
			end
		end

feature -- Duplication

	copy (other : like Current)
		do
			if other.is_null then
				set_null
			else
				set_item (other.item)
			end
		end

feature -- Comparison

	is_equal (other : like Current) : BOOLEAN
			do
				Result := (is_null and then other.is_null) or else (item.is_equal (other.item))
			end

feature -- Contract support

	valid_item (value : G) : BOOLEAN
			-- Is `value' valid as an item ?
		do
			Result := value /= Void
		ensure
			definition: Result implies value /= Void
		end

feature {NONE} -- Implementation

	impl_item : detachable G
			-- Reference to actual item this is always the same item !
		do
		end

	create_impl_item
			-- Create impl_item
		do
		end

	out_null : STRING
			-- Default `out' when value `is_null'
		once
			Result := "<NULL>"
		end

end
