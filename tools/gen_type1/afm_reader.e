indexing
	description: "Objects that read Adobe Font Metrics (AFM) files"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AFM_READER

creation
	make
	
feature -- Initialization
	
	make (f : PLAIN_TEXT_FILE) is
			-- 
		require
			f /= Void and then f.is_open_read
		do
			file := f
			read_name
			read_widths
		end
		
feature -- Access

	file : PLAIN_TEXT_FILE

	font_name : STRING
		
	widths : DS_HASH_TABLE[INTEGER, STRING]
			-- widths, indexed by character name

	widths_count : INTEGER
	
	last_width : INTEGER
	
	last_name : STRING
	
feature -- Element change
	
	read_name is
			-- 
		do
			read_until ("FontName")
			file.read_word
			font_name := clone (file.last_string)
		end
		
	read_widths is
			-- 
		local
			index : INTEGER
		do
			read_until ("StartCharMetrics")
			file.read_line
			widths_count := file.last_string.to_integer
			!!widths.make (widths_count)
			from
				index := 1
			until
				index > widths_count
			loop
				read_3_words -- code : ignored
				read_3_words -- width
				if w1.is_equal ("WX") then
					last_width := w2.to_integer
				end
				read_3_words -- name
				if w1.is_equal ("N") then
					last_name := w2
				end
				file.read_line -- ignore end of line
				widths.force (last_width, last_name)
				index := index + 1
			end
		end
		
feature -- Basic operations

	read_until (s : STRING) is
			-- 
		do
			from
				file.read_word
			until
				file.end_of_file or else file.last_string.is_equal (s)
			loop
				file.read_word
			end			
		end
		
	read_3_words is
			-- 
		do
			file.read_word
			w1 := clone (file.last_string)
			file.read_word
			w2 := clone (file.last_string)
			file.read_word
			w3 := clone (file.last_string)
		end
		
	w1, w2, w3 : STRING
	
end -- class AFM_READER
