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
--		export 
--			{NONE}
--				all;
--		 	{ANY}
--				item, put, has, force, upper, lower
		end
	

creation
	make, make_from_array
	
feature {NONE} -- Initialization

	make (a_lower, an_upper : INTEGER) is
			-- make object `a_number', with bounds within [a_lower..an_upper]
		do
			make_array (a_lower, an_upper)
		end
		
	make_from_array (array : ARRAY[G]) is
			-- make from existing array
		local
			i : INTEGER
		do
			make (array.lower, array.upper)
			from 
				i := array.lower
			until
				i > array.upper
			loop
				put (array.item (i), i)
				i := i + 1
			end
		end
		
feature -- Conversion

	to_pdf : STRING is
		local
			index : INTEGER
		do
			!!Result.make (0)
			--Result.append (object_header)
			Result.append ("[ ")
			from
				index := lower
			until
				index > upper
			loop
				Result.append  (item_separator (index))
				Result.append (to_pdf_item (index))
				index := index + 1
			end
			Result.append (" ]%N")
			--Result.append (object_footer)
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
		
end -- class PDF_ARRAY
