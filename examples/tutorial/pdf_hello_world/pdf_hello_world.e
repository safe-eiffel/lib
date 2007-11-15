indexing
	description	: "Hello world ePDF tutorial root class."

class
	PDF_HELLO_WORLD

inherit
	KL_SHARED_FILE_SYSTEM

	XS_IMPORTED_UINT32_ROUTINES
	
create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			page, page1, page2 : PDF_PAGE
			medium : PDF_OUTPUT_MEDIUM
			file : KI_TEXT_OUTPUT_FILE
			image, alpha, image2 : PDF_IMAGE
			i,j, c : INTEGER
			png : PDF_PNG_IMAGE
			images_outline : PDF_OUTLINE_ITEM
		do			
			create document.make
			document.find_font ("Helvetica", document.Encoding_winansi)
			document.create_outlines
			page := document.last_page
			document.create_outline_item ("Images", page, page.mediabox.llx, page.mediabox.ury)
			document.outlines.put_last (document.last_outline_item)
			images_outline := document.last_outline_item
			images_outline.set_open
			document.create_outline_item ("Nice Image", page, page.mediabox.llx, page.mediabox.ury // 2)
			images_outline.put_last (document.last_outline_item)
			document.last_outline_item.set_open
			document.create_png_image ("C:\User\Dev\lpng125\contrib\gregbook\toucan.png")
			image2 := document.last_image
			document.create_image (80, 80,3,8)
			image := document.last_image
			document.create_image (80,80,1,8)
			alpha := document.last_image
			from
				i := 1
				c := 0xFF0000
				j := 1
			until
				i > image.height
			loop
				if i /= 25 then
					from
						j := 1
					until
						j > image.width
					loop
						image.put_sample (c, i, j)
						alpha.put_sample (155, i, j)
						j := j + 1
					end
				end
				i := i + 1
			end
			--
			--
			-- begin text mode
			page.begin_text
			
			-- set font + size
			page.set_font (document.last_font, 36)
			
			-- move text origin to (left edge + 1 inch, upper edge - 1 inch - fontsize)
			page.move_text_origin ((page.mediabox.width - image.width) //2 , page.mediabox.height // 2)
			
			-- show text
			page.put_string ("Hello World !")
			
			-- end text mode
			page.end_text
			page.gsave
			page.translate ((page.mediabox.width - image.width)  //2 , page.mediabox.height // 2 )
			page.scale (80,80)
			image.set_alpha (alpha)
			page.put_image (image)
			page.grestore
			page.gsave
			page.translate ((page.mediabox.width - image2.width)  //2 - 20, (page.mediabox.height - image.height) // 2 + (image2.height // 4))
			page.scale (image2.width,image2.height)
			page.put_image (image2)
			page.grestore
			
			document.add_page
			page := document.last_page
			document.create_outline_item ("Test PNG", page, page.mediabox.llx, page.mediabox.ury)
			images_outline.put_last (document.last_outline_item)
			document.find_font ("Helvetica", document.Encoding_winansi)
			page.set_font (document.last_font, 12)
			from
				i := 1
				j := document.default_mediabox.ury - 100
			until
				i > images.upper
			loop
				--create png.make (images.item (i))
				document.create_png_image (images.item (i))
				image := document.last_image
				page.gsave
				page.translate (100, j)
				page.scale (image.width, image.height)
				page.put_image (image)
				page.grestore
				page.gsave
				page.begin_text
				page.move_text_origin (100 + 2 * image.width, j)
				page.put_string (images.item (i+1))
				page.end_text
				page.grestore				
				j := j - image.height - 5
				i := i + 2
			end
			file := file_system.new_output_file ("pdf_hello_world.pdf")
			file.open_write
			create  medium.make (file)
			document.put_pdf (medium)
			file.close
		end

	document : PDF_DOCUMENT
				
	images : ARRAY [STRING] is
			-- 
		once 
			Result := <<
			    "C:\User\Dev\lpng125\contrib\pngsuite\basn0g01.png", "1-bit grayscale",
			    "C:\User\Dev\lpng125\contrib\pngsuite\basn0g02.png", "2-bit grayscale",
			    "C:\User\Dev\lpng125\contrib\pngsuite\basn0g04.png", "4-bit grayscale",
			    "C:\User\Dev\lpng125\contrib\pngsuite\basn0g08.png", "8-bit grayscale",
			    "C:\User\Dev\lpng125\contrib\pngsuite\basn0g16.png", "16-bit grayscale",
			    "C:\User\Dev\lpng125\contrib\pngsuite\basn2c08.png", "8-bit truecolor",
			    "C:\User\Dev\lpng125\contrib\pngsuite\basn2c16.png", "16-bit truecolor",
			    "C:\User\Dev\lpng125\contrib\pngsuite\basn3p01.png", "1-bit paletted",
			    "C:\User\Dev\lpng125\contrib\pngsuite\basn3p02.png", "2-bit paletted",
			    "C:\User\Dev\lpng125\contrib\pngsuite\basn3p04.png", "4-bit paletted",
			    "C:\User\Dev\lpng125\contrib\pngsuite\basn3p08.png", "8-bit paletted",
			    "C:\User\Dev\lpng125\contrib\pngsuite\basn4a08.png", "8-bit gray with alpha",
			    "C:\User\Dev\lpng125\contrib\pngsuite\basn4a16.png", "16-bit gray with alpha",
			    "C:\User\Dev\lpng125\contrib\pngsuite\basn6a08.png", "8-bit RGBA",
			    "C:\User\Dev\lpng125\contrib\pngsuite\basn6a16.png", "16-bit RGBA"
			>>
		end
		
end -- class PDF_HELLO_WORLD
--
-- Copyright: 2001, 2003 Paul G. Crismer, <pgcrism@users.sf.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
