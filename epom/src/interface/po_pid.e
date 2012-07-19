indexing

	description:
	"[
		Persistent Identifiers.
		Identify the persistent state of persistent objects.
		PID instances are opaque to client applications.
	 ]"

	usage:
	"[
		* Inherit from it.
		* Implement deferred features.
	]"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class PO_PID

inherit

	ANY
		redefine
			is_equal
		end

feature -- Access			

	persistent_class_name: STRING is
			-- Name of class for persistence that this PID identifies.
			-- Used by PO_REFERENCE to obtain an adapter
		deferred
		end

feature -- Conversion

	to_string : STRING is
			-- Stringified PID made by appending.
			-- class_name and any other identifying query separated by some separator character like ',' or '|'
		obsolete "Use as_string instead."
		do
			Result := as_string
		ensure
			result_not_void: Result /= Void
			class_name_substring: Result.substring (1,persistent_class_name.count).is_equal (persistent_class_name)
		end

	as_string : STRING is
			-- Stringified PID made by appending.
			-- class_name and any other identifying query separated by some separator character like ',' or '|'
		deferred
		ensure
			result_not_void: Result /= Void
			class_name_substring: Result.substring (1,persistent_class_name.count).is_equal (persistent_class_name)
		end

feature -- Comparison

	is_equal (other : like Current) : BOOLEAN is
			-- Comparison.
		do
			Result := (as_string.is_equal (other.as_string))
		ensure then
			definition: Result = (as_string.is_equal (other.as_string))
		end

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable


invariant

	class_name_is_defined: persistent_class_name /= Void and then not persistent_class_name.is_empty

end
