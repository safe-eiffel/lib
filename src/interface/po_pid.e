indexing

	description:

		"Persistent Identifiers. %N%
	 %Identify the persistent state of persistent objects.  %N%
	 %PID instances are opaque to client applications."

	usage: "* Inherit from it.%N%
		   %* Implement deferred features."		

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

	class_name: STRING is
			-- Class name of object this PID identifies
			-- Used by PO_REFERENCE to obtain an adapter
		deferred
		end
		
feature -- Conversion

	to_string : STRING is
			-- stringified PID made by appending
			-- class_name and any other identifying query separated by some separator character like ',' or '|'
		deferred
		ensure
			result_not_void: Result /= Void
			class_name_substring: Result.substring (1, class_name.count).is_equal (class_name) 
		end
		
feature -- Comparison

	is_equal (other : like Current) : BOOLEAN is
			-- comparison
		do
			Result := (to_string.is_equal (other.to_string))
		ensure then
			definition: Result = (to_string.is_equal (other.to_string))
		end

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable


invariant

	class_name_is_defined: class_name /= Void and then not class_name.is_empty
	
end
