indexing
	description	: "System's root class"
	note		: "Initial version automatically generated"

class
	SYMB_ZAPF

creation
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			lines : INTEGER
		do
			create of.make
			io.put_string ("Enter input filename : ")
			io.read_line
			create f.make_open_read (clone (io.last_string))
			io.put_string ("Enter output filename : ")
			io.read_line
			create fstd.make_open_write (clone (io.last_string))
			if f.is_open_read then
				from
					done := False
				until
					done or else f.end_of_file
				loop
					lines := lines + 1
					process_line
					if not done then
						out_begin
						fstd.put_integer (last_std_code)
						out_end
					end
				end
			end
			io.put_string ("Processed ")
			io.put_integer (lines)
			io.put_string (" lines.%N")
			f.close
			fstd.close
		end

	of : OCTAL_FORMAT
	
	f, fstd : PLAIN_TEXT_FILE
	
	done : BOOLEAN
	
	process_line is
			-- 
		do
			f.read_word -- character
			last_character_string := clone (f.last_string)
			f.read_word -- name
			last_name := clone (f.last_string)
			f.read_line -- std
			if f.last_string.is_integer then
				of.from_string (f.last_string)
				last_std_code := of.last_value
			else
				last_std_code := -1
			end
			io.put_string (last_name)
			io.put_character ('%T')
			io.put_integer (last_std_code)
			io.put_new_line
		end
		
	last_name : STRING
	
	last_std_code : INTEGER
	
	last_character_string : STRING
	
	out_begin is
			-- 
		do
			fstd.put_string ("%T%T%Tname_to_code.put (")
		end
		
	out_end is
			-- 
		do
						fstd.put_string (", %"")
						fstd.put_string (last_name)
						fstd.put_string ("%")%T -- '"+last_character_string+"'%N")
						
		end		
		
end -- class SYMB_ZAPF
