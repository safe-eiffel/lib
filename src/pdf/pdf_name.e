indexing

	description: "PDF name. Useful in dictionaries."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class
	PDF_NAME

inherit
	PDF_SERIALIZABLE
		redefine
			is_equal
		end
	
creation

	make

feature -- Initialization

	make (a_string : STRING) is
			-- 
		require
			string_exists: a_string /= Void
		do
			value := a_string
		ensure
			value_shared: value = a_string
		end
		
feature -- Access

	value : STRING
			
feature -- Conversion

	to_pdf : STRING is
			-- 
		do
			create Result.make (value.count+1)
			Result.append_character ('/')
			Result.append_string (value)
		end

feature -- Comparison

	is_equal (other : like Current) : BOOLEAN is
		do
			Result := value.is_equal (other.value)
		end
		
feature {NONE} -- Implementation

	number : INTEGER is do end
	
end -- class PDF_NAME
