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
			ti : TEST_TITLE
			tf : TEST_FONTS
			tt : TEST_TEXT_ATTRIBUTES
			tc : TEST_TEXT_CLIP
			tl : TEST_LINES
			tla : TEST_LINE_ATTRIBUTES
			tp : TEST_PAINT
			tm : TEST_MATRIX
			tx : TEST_TEXT
		do
			!!document.make
			document.find_font ("Helvetica", document.Encoding_winansi)
			page := document.last_page
			!!ti
			ti.do_test (document)
			document.add_page
			!!tf
			tf.do_test (document)
			document.add_page
			!!tt
			tt.do_test (document)
			document.add_page
			!!tc
			tc.do_test (document)
			document.add_page
			!!tl
			tl.do_test (document)
			document.add_page
			!!tla
			tla.do_test (document)
			document.add_page
			!!tp
			tp.do_test (document)
			document.add_page
			!!tm
			tm.do_test (document)
			document.add_page
			!!tx
			tx.do_test (document)

			file := file_system.new_output_file ("pdf_show.pdf")
			file.open_write
			!! medium.make (file)
			document.put_pdf (medium)
			file.close
		end

	document : PDF_DOCUMENT
				
end -- class SHOW_EPDF
--
-- Copyright: 2001, Paul G. Crismer, <pgcrism@pi.be>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
