note

	description:
	
			"Objects that handle some data format."

	library: "ECLI : Eiffel Call Level Interface (ODBC) Library. Project SAFE."
	Copyright: "Copyright (c) 2001-2012, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class ECLI_FORMAT [G]

inherit

	KL_IMPORTED_STRING_ROUTINES
	
feature -- Access

	last_result : G
		
feature -- Measurement

feature -- Status report

	matching_string (s : STRING) : BOOLEAN
			-- is `s' matching current data type ?
		do
			regex.match (s)
			Result := regex.match_count >= regex_component_count
		end
		
feature -- Status setting

feature -- Cursor movement

feature -- Element change

	create_from_string (s : STRING)
			-- create new `last_result' from `s'
		require
			s_not_void: s /= Void --FIXME: VS-DEL
			s_matching: matching_string (s)
		deferred
		ensure
			last_result_not_void: last_result /= Void --FIXME: VS-DEL
			last_result_same_as_s: formatted (last_result).is_equal (s)
		end
		
feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

	formatted (value : G) : STRING
			-- `value' formatted with respect to Current format
		require
			value_not_void: value /= Void --FIXME: VS-DEL
		deferred
		ensure
			result_not_void: Result /= Void --FIXME: VS-DEL
			result_matching_format: matching_string (Result)
		end
		
feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	regex : RX_PCRE_REGULAR_EXPRESSION
		deferred
		ensure
			result_not_void: Result /= Void --FIXME: VS-DEL
			result_compiled: Result.is_compiled
		end
		
	regex_component_count : INTEGER deferred end

invariant
	invariant_clause: True -- Your invariant here

end
