indexing
	description: "Objects that show how to use PDF images, as supported by ePDF"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_IMAGES

inherit
	XS_IMPORTED_UINT32_ROUTINES

	KL_SHARED_FILE_SYSTEM
	
feature -- Basic operations

	do_test (document : PDF_DOCUMENT; images_outline : PDF_OUTLINE_ITEM) is
			-- 
		local
			page : PDF_PAGE
			image, alpha, image2 : PDF_IMAGE
			i,j, c : INTEGER
		do
			page := document.last_page
			document.create_png_image (file_system.pathname (images_dir,"toucan.png"))
			image2 := document.last_image
			document.create_image (80, 80,3,8)
			image := document.last_image
			document.create_image (80,80,1,8)
			alpha := document.last_image
			-- create red image with alpha
			from
				i := 1
				c := UINT32_.left_shift (255, 16)
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
			image.set_alpha (alpha)
			--
			-- compose page
			-- begin text mode
			page.begin_text	
			-- set font + size
			page.set_font (document.last_font, 36)		
			-- move text origin to (left edge + 1 inch, upper edge - 1 inch - fontsize)
			page.move_text_origin ((page.mediabox.width - image.width - 4) /2 , page.mediabox.height / 2 + 2)			
			-- show text
			page.put_string ("Hello World !")		
			-- end text mode
			page.end_text
			page.gsave
			page.translate ((page.mediabox.width - image.width)  /2 , page.mediabox.height / 2 )
			page.scale (80,80)
			page.put_image (image)
			page.grestore
			page.gsave
			page.translate ((page.mediabox.width - image2.width / 2)  /2 - 20, (page.mediabox.height - image.height / 2) / 2 + (image2.height / 3))
			page.scale (image2.width / 2 ,image2.height / 2)
			page.put_image (image2)
			page.grestore
			check page.save_level = 0 end
			document.add_page
			page := document.last_page
			document.create_outline_item ("Test PNG", page, page.mediabox.llx, page.mediabox.ury)
			images_outline.put_last (document.last_outline_item)
			document.find_font ("Helvetica", document.Encoding_winansi)
			page.set_font (document.last_font, 12)
			from
				i := 1
				j := document.default_mediabox.ury.truncated_to_integer - 100
			until
				i > images.upper
			loop
				document.create_png_image (file_system.pathname (images_dir,images.item (i)))
				image := document.last_image
				page.gsave
				page.translate (100, j)
				page.scale (image.width, image.height)
				page.put_image (image)
				page.grestore
				page.gsave
				page.begin_text
				page.set_text_origin (100 + 2 * image.width, j)
				page.put_string (images.item (i+1))
				page.end_text
				page.grestore				
				j := j - image.height - 5
				i := i + 2
			end
			check page.save_level = 0 end
		end
		
	images : ARRAY [STRING] is
			-- 
		once 
			Result := <<
			    "basn0g01.png", "1-bit grayscale",
			    "basn0g02.png", "2-bit grayscale",
			    "basn0g04.png", "4-bit grayscale",
			    "basn0g08.png", "8-bit grayscale",
			    "basn0g16.png", "16-bit grayscale",
			    "basn2c08.png", "8-bit truecolor",
			    "basn2c16.png", "16-bit truecolor",
			    "basn3p01.png", "1-bit paletted",
			    "basn3p02.png", "2-bit paletted",
			    "basn3p04.png", "4-bit paletted",
			    "basn3p08.png", "8-bit paletted",
			    "basn4a08.png", "8-bit gray with alpha",
			    "basn4a16.png", "16-bit gray with alpha",
			    "basn6a08.png", "8-bit RGBA",
			    "basn6a16.png", "16-bit RGBA"
			>>
		end

	images_dir : STRING is "images"
	
end -- class TEST_IMAGES
