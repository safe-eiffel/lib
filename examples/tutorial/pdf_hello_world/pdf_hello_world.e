indexing
	description	: "Hello world ePDF tutorial root class."

class
	PDF_HELLO_WORLD

inherit
	KL_SHARED_FILE_SYSTEM
	
creation
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			page : PDF_PAGE
			medium : PDF_OUTPUT_MEDIUM
			file : KI_TEXT_OUTPUT_FILE
		do
			!!document.make
			document.find_font ("Helvetica", document.Encoding_winansi)
			page := document.last_page
			--
			--
			-- begin text mode
			page.begin_text
			
			-- set font + size
			page.set_font (document.last_font, 20)
			
			-- move text origin to (left edge + 1 inch, upper edge - 1 inch - fontsize)
			page.move_text_origin (72, page.mediabox.ury - 72 - 20)
			
			-- show text
			page.put_string ("Hello World !")
			
			-- end text mode
			page.end_text
			
			file := file_system.new_output_file ("pdf_hello_world.pdf")
			file.open_write
			!! medium.make (file)
			document.put_pdf (medium)
			file.close
		end

	document : PDF_DOCUMENT
				
end -- class PDF_HELLO_WORLD
--
-- Copyright: 2001, 2003 Paul G. Crismer, <pgcrism@users.sf.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
