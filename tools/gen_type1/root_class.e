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
			arg : ARGUMENTS
		do
			create arg
			file_name := clone (arg.argument (1))
			create file.make_open_read (file_name)
			if file.is_open_read then
				create reader.make (file)				
			end
			create_class
		end

	reader : AFM_READER
	
	file : PLAIN_TEXT_FILE
	
	file_name : STRING

	
	fclass : PLAIN_TEXT_FILE
	
	class_name : STRING
	
	class_file_name : STRING
	
	class_name_of_font (s : STRING) : STRING is
			-- create class name from font name
			-- substitutes '-' and ' ' by '_' (underscore)
		require
			s /= Void
		local
			index : INTEGER
		do
			from
				create Result.make(s.count)
				index := 1
			until
				index > s.count
			loop
				inspect s.item (index)
				when '-', ' ' then
					Result.append_character ('_')
				else
					Result.append_character (s.item (index))					
				end 
				index := index + 1
			end
			Result.to_upper
		end
	
	create_class is
			-- 
		do
			-- infer class name and class file name
			class_name := class_name_of_font (reader.font_name)
			class_file_name := clone (class_name)
			class_file_name.to_lower
			class_file_name.prepend ("pdf_")
			class_file_name.append_string ("_font.e")
			-- create file
			create fclass.make_open_write (class_file_name)
			--
			fclass.put_string ("indexing%N%Tdescription: %"")
			fclass.put_string (reader.font_name)
			fclass.put_string (" font definition.%"%N%N")
			fclass.put_string ("class%N%N%TPDF_")
			fclass.put_string (class_name)
			fclass.put_string ("_FONT%N%Ninherit%N%TPDF_ADOBE14_FONT%N%N")
			fclass.put_string ("creation%N%Tmake%N%N")
			fclass.put_string ("feature -- Access%N%N")
			-- font name
			fclass.put_string ("%Tbasefont : PDF_NAME is%N")
			fclass.put_string ("%T%Tonce%N")
			fclass.put_string ("%T%T%Tcreate Result.make (%"")
			fclass.put_string (reader.font_name)
			fclass.put_string ("%")%N")
			fclass.put_string ("%T%Tend%N%N")
			-- name_to_width
			fclass.put_string ("feature {NONE} -- Implementation%N%N")
			fclass.put_string ("%Tname_to_width : DS_HASH_TABLE[INTEGER,STRING] is%N")
			fclass.put_string ("%T%Tonce%N")
			fclass.put_string ("%T%T%Tcreate Result.make (")
			fclass.put_string (reader.widths.count.out)
			fclass.put_string (")%N")
			-- put each character
			from
				reader.widths.start
			until
				reader.widths.off
			loop
				fclass.put_string ("%T%T%TResult.force (")
				fclass.put_string (reader.widths.item_for_iteration.out)
				fclass.put_string (", %"")
				fclass.put_string (reader.widths.key_for_iteration)
				fclass.put_string ("%")%N")
				reader.widths.forth
			end
			fclass.put_string ("%T%Tend%N%N")
			-- end of class
			fclass.put_string ("end -- class ")
			fclass.put_string (class_name)
			fclass.put_string ("%N")
			fclass.close
		end

end -- class ROOT_CLASS
