indexing
	description	: "System's root class"
	note		: "Initial version automatically generated"

class
	ROOT_CLASS

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
			create fstd.make_open_write ("c:\isolatin1_std.txt")
			create fmac.make_open_write ("c:\iso_latin1_mac.txt")
			create fwin.make_open_write ("c:\isolatin1_win.txt")
			create fpdf.make_open_write ("c:\iso_latin1_pdf.txt")
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
						fmac.put_integer (last_mac_code)
						fwin.put_integer (last_win_code)
						fpdf.put_integer (last_pdf_code)
						out_end
					end
				end
			end
			io.put_string ("Processed ")
			io.put_integer (lines)
			io.put_string (" lines.%N")
			f.close
			fstd.close
			fmac.close
			fwin.close
			fpdf.close
		end

	of : OCTAL_FORMAT
	
	f, fstd, fmac, fwin, fpdf : PLAIN_TEXT_FILE
	
	done : BOOLEAN
	
	process_line is
			-- 
		do
			f.read_word -- character
			last_character_string := clone (f.last_string)
			f.read_word -- name
			last_name := clone (f.last_string)
			if last_name.count > 1 and last_name.item (last_name.count).is_digit then
				last_name.head (last_name.count - 1)
			end
			f.read_word -- std
			if f.last_string.is_integer then
				of.from_string (f.last_string)
				last_std_code := of.last_value
			else
				last_std_code := -1
			end
			f.read_word -- mac
			if f.last_string.is_integer then
				of.from_string (f.last_string)
				last_mac_code := of.last_value
			else
				last_mac_code := -1
			end
			f.read_word -- win
			if f.last_string.is_integer then
				of.from_string (f.last_string)
				last_win_code := of.last_value
			else
				last_win_code := -1
			end
			f.read_line -- pdf
			if f.last_string.is_integer then
				of.from_string (f.last_string)
				last_pdf_code := of.last_value
			else
				last_pdf_code := -1

			end
			io.put_string (last_name)
			io.put_character ('%T')
			io.put_integer (last_win_code)
			io.put_new_line
		end
		
	last_name : STRING
	
	last_std_code : INTEGER
	
	last_mac_code : INTEGER
	
	last_win_code : INTEGER
	
	last_pdf_code : INTEGER

	last_character_string : STRING
	
	out_begin is
			-- 
		do
			fstd.put_string ("%T%T%Tname_to_code.put (")
			fmac.put_string ("%T%T%Tname_to_code.put (")
			fwin.put_string ("%T%T%Tname_to_code.put (")
			fpdf.put_string ("%T%T%Tname_to_code.put (")
		end
		
	out_end is
			-- 
		do
						fstd.put_string (", %"")
						fstd.put_string (last_name)
						fstd.put_string ("%")%T -- '"+last_character_string+"'%N")
						
						fmac.put_string (", %"")
						fmac.put_string (last_name)
						fmac.put_string ("%")%T -- '"+last_character_string+"'%N")
			
						fwin.put_string (", %"")
						fwin.put_string (last_name)
						fwin.put_string ("%")%T -- '"+last_character_string+"'%N")

						fpdf.put_string (", %"")
						fpdf.put_string (last_name)
						fpdf.put_string ("%")%T -- '"+last_character_string+"'%N")
		end		
		
end -- class ROOT_CLASS
