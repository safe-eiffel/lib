indexing
	description	: "System's root class"
	note		: "Initial version automatically generated"

class
	ROOT_CLASS

inherit
	
	KL_SHARED_FILE_SYSTEM
	
creation
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			arg : ARGUMENTS
			dir : KL_DIRECTORY
			file_names : ARRAY[STRING]
			i : INTEGER
		do
			create arg
			file_name := clone (arg.argument (1))
			if file_system.is_file_readable (file_name) then
				process_file (file_name)
			elseif file_system.is_directory_readable (file_name) then
				create dir.make (file_name)
				file_names := dir.filenames
				from
					i := file_names.lower
				until
					i > file_names.upper
				loop
					if afm_regex.matches (file_names.item (i)) then
						process_file (file_system.pathname (file_name, file_names.item (i)))
					end
					i := i + 1
				end
			end
		end

	process_file (a_name : STRING) is
		do
			create file.make (a_name)
			file.open_read
			if file.is_open_read then
				create reader.make (file)	
				file.close			
				create_class
			end
		end
	
	afm_regex : RX_PCRE_REGULAR_EXPRESSION is	
		once
			create Result.make
			Result.compile (".*\.afm")
		end
		
	reader : AFM_READER
	
	file : KL_TEXT_INPUT_FILE
	
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
			fclass.put_string (" font definition.%"%N")
			fclass.put_string ("%Tauthor: %"Paul G. Crismer%"%N")
			fclass.put_string ("%Tlicence: %"Release under the Eiffel Forum licence.  See file 'forum.txt'.%"%N%N")

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
			put_string_function ("full_name", reader.full_name)
			put_string_function ("family_name", reader.family_name)
			put_string_function ("weight", reader.weight)
			put_integer_function ("italic_angle", reader.italic_angle)
			put_boolean_function ("is_fixed_pitch", reader.is_fixed_pitch)
			put_string_function ("character_set", reader.character_set)
			put_rectangle_function ("font_b_box", reader.font_b_box)
			put_integer_function ("underline_position", reader.underline_position)
			put_integer_function ("underline_thickness", reader.underline_thickness)
			put_string_function ("encoding_scheme", reader.encoding_scheme)
			put_integer_function ("cap_height", reader.cap_height)
			put_integer_function ("x_height", reader.x_height)
			put_integer_function ("ascender", reader.ascender)
			put_integer_function ("descender", reader.descender)
			put_integer_function ("std_hw", reader.std_hw)
			put_integer_function ("std_vw", reader.std_vw)
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
			fclass.put_string ("end%N")
			fclass.close
		end

	put_integer_function (name: STRING; value : INTEGER) is
		do
			put_function (name, "INTEGER", value.out)
		end

	put_boolean_function (name: STRING; value : BOOLEAN) is
		do
			put_function (name, "BOOLEAN", value.out)
		end
		
	put_function (name, type, value : STRING) is
		do
			fclass.put_string ("%T")
			fclass.put_string (name)
			fclass.put_string (" : ")
			fclass.put_string (type)
			fclass.put_string (" is%N")
			fclass.put_string ("%T%Tdo%N")
			fclass.put_string ("%T%T%TResult := ")
			fclass.put_string (value)
			fclass.put_string ("%N%T%Tend%N%N")
		end
		
	put_string_function (name : STRING; value : STRING) is
		do
			put_function (name, "STRING", "%"" + value + "%"")
		end
		
	put_rectangle_function (name : STRING; rectangle : GEO_RECTANGLE[INTEGER]) is
		do
			fclass.put_string ("%T")
			fclass.put_string (name)
			fclass.put_string (" : PDF_RECTANGLE is%N")
			fclass.put_string ("%T%Tdo%N")
			fclass.put_string ("%T%T%Tcreate Result.set (")
			fclass.put_integer (rectangle.llx)
			fclass.put_character (',')
			fclass.put_integer (rectangle.lly)
			fclass.put_character (',')
			fclass.put_integer (rectangle.urx)
			fclass.put_character (',')
			fclass.put_integer (rectangle.ury)
			fclass.put_string (")%N")
			fclass.put_string ("%T%Tend%N%N")
		end
		
end -- class ROOT_CLASS
