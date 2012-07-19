indexing
	description: 
	
		"Abstract output medium for writing PDF files"

	author: 	"Paul G. Crismer"
	licencing: 	"See notice at end of class"
	date: 		"$Date$"
	revision: 	"$Revision$"

class
	PDF_OUTPUT_MEDIUM

create
	make, make_string
	
feature {NONE} -- Initialization

	make (a_medium : KI_BINARY_OUTPUT_FILE) is
			-- make using `a_medium'
		require
			a_medium /= Void and then a_medium.is_open_write
		do
			medium := a_medium
		end

	make_string (a_medium : KL_STRING_OUTPUT_STREAM) is
			-- make using `a_medium'
		require
			a_medium /= Void and then a_medium.is_open_write
		do
			medium := a_medium
		end
		
feature -- Measurement

	eol_count : INTEGER is
			-- count of bytes in an EOF marker
		do
			Result := 1 -- medium.eol.count
		end
		
feature -- Status Report

	is_open_write : BOOLEAN is
			-- is the medium open for writing ?
		do
			Result := medium.is_open_write
		end
		
feature -- Measurement

	count : INTEGER is
			-- number of characters output
		do
			Result := count_impl
		end
		
feature -- Basic operations

	put_string (s : STRING) is
			-- put string `s'
		require
			s /= Void
		local
			begin_index, end_index : INTEGER
		do
			-- use put_new_line for %N characters
			-- use put_string for string segment not containing %N
			if not s.is_empty then
				from
					begin_index := 1
				until
					begin_index > s.count
				loop
					end_index := s.index_of ('%N', begin_index)
					if end_index > 0 then
						-- found a new_line
						if begin_index <= end_index - 1 then
							-- segment before new_line is not empty
							medium.put_string (s.substring (begin_index, end_index-1))
							-- update count
							increment_count (end_index - begin_index)
						end
						put_new_line
						begin_index := end_index + 1
					else
						medium.put_string (s.substring (begin_index, s.count))				
						-- update count
						increment_count (s.count - begin_index + 1)
						-- set loop exit condition
						begin_index := s.count + 1
					end
				end
			end
		ensure
			not s.is_empty implies (count >= old count + s.count)
		end
		
	put_double (d : DOUBLE) is
			-- put double `d'
		local
			integral, fraction : INTEGER
			s : STRING
		do
			create s.make (0)
			integral := d.truncated_to_integer
			fraction := ((d - integral) * 10000).truncated_to_integer
			s.append_string (integral.out)
			if fraction > 0 then
				s.append_character ('.')
				if fraction < 10 then
					s.append_string ("000")
				elseif fraction < 100 then
					s.append_string ("00")
				elseif fraction < 1000 then
					s.append_string ("0")
				end
				s.append_string (fraction.out)
			end
			medium.put_string (s)
			increment_count (s.count)
		ensure
			count > old count
		end

	put_new_line is
			-- put a newline
		do
			medium.put_character ('%N') --medium.put_new_line
			increment_count (eol_count)
		ensure
			count > old count
		end

feature {NONE} -- Implementation

	increment_count (c : INTEGER) is
		do
			count_impl := count_impl + c
		end
		
	count_impl : INTEGER
	
	medium : KI_CHARACTER_OUTPUT_STREAM
	
invariant

	medium_is_open_write: is_open_write

end -- class PDF_OUTPUT_MEDIUM
