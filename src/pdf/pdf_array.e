indexing

	description: "PDF array."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."
	
class

	PDF_ARRAY[G]
	
inherit

	PDF_SERIALIZABLE
		undefine
			is_equal, copy
		end
		
	ARRAY[G]
		rename
			make as make_array, make_from_array as array_make_from_array
		end
	

creation
	make, make_from_array
	
feature {NONE} -- Initialization

	make (a_lower, an_upper : INTEGER) is
			-- make object `a_number', with bounds within [a_lower..an_upper]
		do
			make_array (a_lower, an_upper)
		end
		
	make_from_array (an_array : ARRAY[G]) is
			-- make from existing array
		local
			i : INTEGER
		do
			make (an_array.lower, an_array.upper)
			from 
				i := an_array.lower
			until
				i > an_array.upper
			loop
				put (an_array.item (i), i)
				i := i + 1
			end
		end
		
feature -- Conversion

	to_pdf : STRING is
			-- PDF representation
		local
			index : INTEGER
		do
			create Result.make (0)
			Result.append_string ("[ ")
			from
				index := lower
			until
				index > upper
			loop
				Result.append_string  (item_separator (index))
				Result.append_string (to_pdf_item (index))
				index := index + 1
			end
			Result.append_string (" ]")
		end

feature {NONE} -- Implementation

	to_pdf_item (n : INTEGER) : STRING is
		do
			Result := (item (n)).out
		end
		
	item_separator (n : INTEGER) : STRING  is
		do
			if n > 0 and (n \\ 16) = 0 then
				Result := "%N"
			else
				Result := " "
			end
		end

	number : INTEGER is do  end	
		
end -- class PDF_ARRAY
