indexing
	description: 	"System's root class"
	author: 	"Paul G. Crismer"
	licence: 	"Released under the Eiffel Forum licence.  See file 'forum.txt'."
	date: 		"$Date$"
	revision: 	"$Revision$"

class
	SHOW_EPDF
	
inherit 
	KL_SHARED_FILE_SYSTEM
	
creation
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			medium : PDF_OUTPUT_MEDIUM
			file : KI_TEXT_OUTPUT_FILE
			page : PDF_PAGE
			title : TEST_TITLE
			fonts : TEST_FONTS
			text_attributes : TEST_TEXT_ATTRIBUTES
			text_clip : TEST_TEXT_CLIP
			lines : TEST_LINES
			line_attributes : TEST_LINE_ATTRIBUTES
			paint : TEST_PAINT
			matrix : TEST_MATRIX
			text : TEST_TEXT
		do
			print ("show_epdf application%N")
			!!document.make
			document.find_font ("Helvetica", document.Encoding_winansi)
			page := document.last_page
			!!title
			title.do_test (document)
			document.add_page
			!!fonts
			fonts.do_test (document)
			document.add_page
			!!text_attributes
			text_attributes.do_test (document)
			document.add_page
			!!text_clip
			text_clip.do_test (document)
			document.add_page
			!!lines
			lines.do_test (document)
			document.add_page
			!!line_attributes
			line_attributes.do_test (document)
			document.add_page
			!!paint
			paint.do_test (document)
			document.add_page
			!!matrix
			matrix.do_test (document)
			document.add_page
			!!text
			text.do_test (document)

			file := file_system.new_output_file ("pdf_show.pdf")
			file.open_write
			!! medium.make (file)
			document.put_pdf (medium)
			file.close
			print ("file '")
			print (file.name)
			print ("' has been generated%N")
		end

	document : PDF_DOCUMENT
				
end -- class SHOW_EPDF
--
-- Copyright: 2001, 2003 Paul G. Crismer, <pgcrism@users.sf.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
