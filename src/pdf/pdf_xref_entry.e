indexing

	description: "PDF Cross reference entry."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."
	
class

	PDF_XREF_ENTRY

inherit

	PDF_SERIALIZABLE
		redefine
			put_pdf
		end

creation

	make, make_free
	
feature {NONE} -- Initialization

	make (an_object : PDF_OBJECT) is
		require
			object: an_object /= Void
		do
			object := an_object
			set_eol_bytes_count (1)
		ensure
			object: object = an_object
			not_free: not is_free
		end
	
	make_free (a_next_entry_number, a_generation : INTEGER) is
		require
			number: a_next_entry_number >= 0
			generation: a_generation <= 65535
		do
			object := Void
			impl_value := a_next_entry_number
			impl_generation := a_generation
			set_eol_bytes_count (1)
		ensure
			next_free_set: next_free = a_next_entry_number
			generation_set: generation= a_generation
			free: is_free
			byte_count_set: eol_bytes_count = 1
		end
		
feature -- Access

	next_free : INTEGER is
			-- 
		require
			is_free
		do
			Result := impl_value
		end
		
	offset : INTEGER is
			--
		require
			not is_free
		do
			Result := impl_value
		end
		
	generation : INTEGER is
			-- 
		do
			if is_free then
				Result := impl_generation
			else
				Result := object.generation
			end
		end
		
	
	object : PDF_OBJECT
	
feature -- Status report

	is_free : BOOLEAN is
			-- 
		do
			Result := (object = Void)
		end

feature -- Status setting

	set_offset (an_offset : INTEGER) is
			-- set value to `an_offset'
		require
			not is_free
		do
			impl_value := an_offset
		end
		
feature -- Conversion

	to_pdf : STRING is
		local
			snumber, sgeneration : STRING
			scount : INTEGER
			zero_string : STRING
			temp_string : STRING
			zero_count : INTEGER
		do
			!!Result.make (0)
			zero_string := "0000000000"
			-- format number : 10 digits
			temp_string := impl_value.out
			scount := temp_string.count
			zero_count := 10 - scount
			snumber := zero_string.substring (1, zero_count)
			snumber.append (temp_string)
			check
				snumber_count: snumber.count = 10
			end
			-- format generation : 5 digits
			temp_string := generation.out
			scount := temp_string.count
			zero_count := 5 - scount
			sgeneration := zero_string.substring (1, zero_count)
			sgeneration.append (temp_string)
			check
				sgeneration_count: sgeneration.count = 5
			end
			-- format
			Result.append (snumber)
			Result.append (" ")
			Result.append (sgeneration)
			if is_free then
				Result.append (" f")
			else
				Result.append (" n")
			end
			if eol_bytes_count = 1 then
				Result.append (" %N")
			else
				Result.append ("%N")
			end	
		ensure then
			format_size_eol1: (eol_bytes_count = 1) implies Result.count = 20
			format_size_eol2: (eol_bytes_count = 2) implies Result.count = 19
		end
	
	put_pdf (medium : PDF_OUTPUT_MEDIUM) is
			-- 
		local
			count_save : INTEGER
		do
			count_save := eol_bytes_count
			set_eol_bytes_count (medium.eol_count)
			medium.put_string (to_pdf)
			set_eol_bytes_count (count_save)
		end

	eol_bytes_count : INTEGER
	
	set_eol_bytes_count (c : INTEGER) is
			-- 
		require
			c_eq_1_or_2: c = 1 or else c = 2
		do
			eol_bytes_count := c
		end
		
feature {NONE} -- Implementation

	impl_value : INTEGER
	
	impl_generation : INTEGER
invariant
	eol_byte_count: eol_bytes_count > 0 and eol_bytes_count <= 2
end -- class PDF_XREF_ENTRY
		