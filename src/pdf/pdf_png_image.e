indexing
	description: "Objects that are images coming from a PNG file"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_PNG_IMAGE

inherit
	PDF_IMAGE
		rename
			make as make_image
		end
		
	KL_SHARED_FILE_SYSTEM
	
creation
	{PDF_DOCUMENT} make
	
feature {NONE} -- Initialization

	make (object_number : INTEGER; file_name : STRING) is
			-- make pdf `object_number', for PNG image in `file_name'
		require
			object_number_not_negative: object_number >= 0
			file_name_valid: file_name /= Void and then file_system.file_exists (file_name)
		do
			number := object_number
			create c_file_name.make_from_string (file_name)
			create c_channels.make
			create c_rowbytes.make
			create c_width.make
			create c_height.make
			create c_bitdepth.make
			create c_colortype.make
			create c_interlacetype.make
			image := read_png (c_file_name.handle,
				c_channels.handle,
				c_rowbytes.handle,
				c_width.handle,
				c_height.handle,
				c_bitdepth.handle,
				c_colortype.handle,
				c_interlacetype.handle)
				
			if image /= default_pointer then
				width := c_width.item
				height := c_height.item
				color_type := c_colortype.item
				color_bits := c_bitdepth.item
				interlace_type := c_interlacetype.item
				channels := c_channels.item
				if channels \\ 2 = 0 then
					color_count := channels - 1
				else
					color_count := channels
				end
				create_samples (width, height, color_count)
			end
		end
		
feature {NONE} -- Measurement

	color_type : INTEGER
			-- PNG specific
			
	interlace_type : INTEGER
			-- PNG specific
			
feature -- Measurement

	channels : INTEGER
			-- number of color channels including alpha if present
	
feature -- Status report

	is_filled : BOOLEAN is 
			-- has current been filled with the PNG file content ?
		do 
			Result := (image = Void) 
		end

feature {NONE} -- Access

	c_file_name : XS_C_STRING
	c_channels : XS_C_INT32 
	c_rowbytes : XS_C_INT32
	c_width : XS_C_INT32
	c_height : XS_C_INT32
	c_bitdepth : XS_C_INT32
	c_colortype : XS_C_INT32
	c_interlacetype : XS_C_INT32
	image : POINTER
	
feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature {PDF_DOCUMENT}-- Implementation

	fill_xobject (d : PDF_DOCUMENT) is
			-- fill xobject for `d'; second phase of creation
			-- it is mandatory; `d' is passed because alpha channels are images
			-- that must be created through the document
		require
			document_exists: d /= Void
			not_filled: not is_filled
		local
			has_alpha : BOOLEAN
			i, j, index : INTEGER
			pimage : XS_C_STRING
			color_r, color_g, color_b, color_a : INTEGER
		do
			create pimage.make_from_pointer (image, width * height * channels)
			if channels \\ 2 = 0 then
				has_alpha := True
			end
			if has_alpha then
				d.create_image (width, height, 1, 8)
				set_alpha (d.last_image)
			end
			from
				i := 1
				index := 1
			until
				i > height
			loop
				from
					j := 1
				until
					j > width
				loop
					if color_count = 1 then
						put_sample (pimage.item_integer (index), j, i)
					    if has_alpha then
							alpha.put_sample (pimage.item_integer (index + 1), j, i)						
					    end
					else
						put_rgb_at (pimage.item_integer (index),
							pimage.item_integer (index + 1),
							pimage.item_integer (index + 2),
							j, i)
						if has_alpha then
							alpha.put_sample (pimage.item_integer (index + 3), j, i)													
						end						
					end
					index := index + channels
					j := j + 1
				end
				i := i + 1
			end
			pimage.release
		end
		
feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	read_png (pfilename, pchannels, prowbytes, pwidth, pheight, pbitdepth, pcolortype,pinterlacetype : POINTER) : POINTER is
		external "C" 
		alias "read_png"
		end	
		
invariant
	channels_property: is_filled implies ((alpha = Void and then channels = color_count) or else channels = color_count + 1)

end -- class PDF_PNG_IMAGE
