indexing

	description: "PDF images"
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class

	PDF_IMAGE

inherit
	PDF_XOBJECT
		rename
			make as make_object
		end

	KL_IMPORTED_INTEGER_ROUTINES
	KL_IMPORTED_STRING_ROUTINES
	
creation
	{PDF_DOCUMENT} make
	
feature {NONE} -- Initialization

	make (object_number, image_width, image_height, sample_colors, color_precision : INTEGER) is
			-- creation as `object_number', of an image measuring `image_width' x `image_height',
			-- each sample counting `sample_colors' colors; each color being `color_precision' bits
		require
			image_width_positive: image_width >= 1
			image_height_positive: image_height >= 1
			valid_sample_colors: sample_colors = 1 or else sample_colors = 3
			valid_color_precision: color_precision = 1 or else color_precision = 4 or else color_precision = 8
		do
			make_object (object_number)
			width := image_width
			height := image_height
			color_count := sample_colors
			color_bits := color_precision
			create_samples (width, height, sample_colors)
		ensure
			width_set: width = image_width
			height_set: height = image_height
			color_count_set: color_count = sample_colors
			color_bits_set: color_bits = color_precision
		end
		
feature -- Access

	sample (x, y : INTEGER) : INTEGER is 
			-- sample at (x,y)
		require
			x_within_limits: x >= 1 and x <= width
			y_within_limits: y >= 1 and y <= height
		local
			index : INTEGER
		do
			index := sample_index (x,y)
			if color_count = 1 then
				Result := samples.item (index).code
			else
				compose_sample (samples.item (index).code, 
					samples.item (index + 1).code,
					samples.item (index + 2).code)
				Result := last_sample
			end
		ensure
			valid_sample: valid_sample (Result)
		end

	color_at (x, y, n : INTEGER) : INTEGER is 
			-- n-th color component at (x,y)
		require
			x >=1 and x <= width
			y >=1 and y <= height
			n >= 1 and n <= color_count
		local
			index : INTEGER
		do
			index := sample_index (x,y)
			if color_count = 1 then
				Result := samples.item (index).code
			else
				Result := samples.item (index + (n-1)).code
			end
		ensure
			valid_color: valid_color (Result)
		end

	alpha : PDF_IMAGE
			-- transparency image, also known as `alpha'
			
feature -- Status report

	valid_color (c : INTEGER) : BOOLEAN is
			-- is `c' a valid color ?
		do
			inspect color_bits
			when 1 then
				Result := (c = 1 or else c = 0)
			when 2 then
				Result := (c >= 0 and then c <= 3)
			when 4 then
				Result := (c >= 0 and then c <= 15)
			else
				Result := (c >= 0 and then c <= 255)
			end
		end
		
	valid_sample (s : INTEGER) : BOOLEAN is
			-- is `s' a valid sample ?
		do
			decompose_sample (s)
			inspect color_count
			when 1 then
				Result := valid_color (color_1)
			else
				Result := valid_color (color_1) and then valid_color (color_2) and then valid_color (color_3)
			end			
		end
		
feature -- Measurement

	width : INTEGER 
			-- number of columns
			
	height : INTEGER 
			-- number of rows
			
	color_count : INTEGER 
			-- number of color components per sample; 1 DeviceGray - 3 DeviceRGB 
			
	color_bits : INTEGER 
			-- number of bits per color component; 1, 2, 4, 8

feature -- Element change

	set_alpha (new_alpha : PDF_IMAGE) is
			-- set alpha image mask
		require
			new_alpha_exists: new_alpha /= Void
			same_width: width = new_alpha.width
			same_height: height = new_alpha.height
			new_alpha_grey: new_alpha.color_count = 1
		do
			alpha := new_alpha
		ensure
			alpha_set: alpha = new_alpha
		end
		
	put_sample (some_sample, x, y : INTEGER) is
			-- put `some_sample' at `x', `y' coordinates
		require
			x >= 1 and x <= width
			y >= 1 and y <= height
			valid_sample (some_sample)
		local
			index : INTEGER
		do
			index := sample_index (x, y)
			if color_count = 1 then
				samples.put (INTEGER_.to_character (some_sample), index)
			else
				decompose_sample (some_sample)
				samples.put (INTEGER_.to_character (color_1), index)
				samples.put (INTEGER_.to_character (color_2), index + 1)
				samples.put (INTEGER_.to_character (color_3), index + 2)
			end
		ensure
			sample (x, y) = some_sample
		end

	put_rgb_at (r, g, b, x, y : INTEGER) is
			-- put (`r',`g',`b') color sample at `x', `y' coordinates
		require
			x >= 1 and x <= width
			y >= 1 and y <= height
			r >= 0 and r <= 255
			g >= 0 and g <= 255
			b >= 0 and b <= 255
			color_count = 3
		local
			index : INTEGER
		do
			index := sample_index (x, y)
			samples.put (INTEGER_.to_character (r), index)
			samples.put (INTEGER_.to_character (g), index + 1)
			samples.put (INTEGER_.to_character (b), index + 2)
		end

	put_color_at (some_color, x, y, color_number : INTEGER) is
			-- put single color `some_color' at `color_number'-th color or `x',`y' coordinate
		require
			valid_color (some_color)
			x_within_limits: x >= 1 and then x <= width
			y_within_limits: y >= 1 and then y <= height
			valid_color_number: color_number >= 1 and then color_number <= color_count
		local
			index : INTEGER
		do
			index := sample_index (x, y)
			samples.put (INTEGER_.to_character (some_color), index + (color_number - 1))
		ensure
			color_set: color_at (x, y, color_number) = some_color
		end

feature {NONE} -- Conversion
		
	put_pdf_content (medium : PDF_OUTPUT_MEDIUM) is
			-- put PDF content of image in `medium'
		local
			n_type, n_subtype, 
			n_width, n_height, 
			n_colorspace, n_bitspercomponent, 
			n_length, n_filter,n_smask : PDF_NAME
			encoded_stream : STRING
			index : INTEGER
			hex : STRING
			encoded_stream_length, eol_count : INTEGER
			--hex_format : ASCII_HEX_FORMAT
			ascii_85_format : ASCII_85_FORMAT
			zlib_stream : STRING
			zlib_format : ZLIB_FORMAT
		do
			create ascii_85_format
			create zlib_format
			zlib_stream := zlib_format.encode (samples)
			encoded_stream := ascii_85_format.encode (zlib_stream)
			encoded_stream_length := ascii_85_format.last_encoded_count (medium) --encoded_stream.count - 2 + encoded_stream.occurrences ('%N') * (medium.eol_count - 1)

			create n_type.make ("Type")
			create n_subtype.make ("Subtype")
			create n_width.make ("Width")
			create n_height.make ("Height")
			create n_colorspace.make ("ColorSpace")
			create n_bitspercomponent.make ("BitsPerComponent")
			create n_length.make ("Length")
			create n_filter.make ("Filter")
			
			medium.put_string (begin_dictionary)
			medium.put_string (dictionary_entry (n_type, "/XObject"))
			medium.put_string (dictionary_entry (n_subtype, "/Image"))
			medium.put_string (dictionary_entry (n_width, width.out))
			medium.put_string (dictionary_entry (n_height, height.out))
			if color_count = 1 then
				medium.put_string (dictionary_entry (n_colorspace, "/DeviceGray"))
			else
				medium.put_string (dictionary_entry (n_colorspace, "/DeviceRGB"))
			end
			medium.put_string (dictionary_entry (n_bitspercomponent, color_bits.out))
			medium.put_string (dictionary_entry (n_length, encoded_stream.count.out))
			medium.put_string (dictionary_entry (n_filter, "[/ASCII85Decode/FlateDecode]"))
			if alpha /= Void then
				create n_smask.make ("SMask")
				medium.put_string (dictionary_entry (n_smask, alpha.indirect_reference))
			end
			medium.put_string (end_dictionary)
			medium.put_string ("stream")
			medium.put_new_line

			medium.put_string (encoded_stream)
			medium.put_new_line
			medium.put_string ("endstream")
			medium.put_new_line
		end
		
feature {NONE} -- Implementation

	samples : STRING

	color_1, color_2, color_3 : INTEGER
	
	last_sample : INTEGER
	
	decompose_sample (s : INTEGER) is
		local
			divider : INTEGER
			decomposed : INTEGER
		do
			color_1 := 0
			color_2 := 0
			color_3 := 0
			decomposed := s
			divider := division_factors.item (color_bits)
			inspect color_count
			when 1 then
				color_1 := decomposed
			when 3 then
				color_3 := decomposed \\ divider
				decomposed := decomposed // divider
				color_2 := decomposed \\ divider
				color_1 := decomposed // divider
			end
		end

	compose_sample ( r, g, b : INTEGER) is
		local
			multiplier : INTEGER
		do
			multiplier := division_factors.item (color_bits)
			last_sample := r * multiplier * multiplier
			last_sample := last_sample + g * multiplier
			last_sample := last_sample + b
		ensure
			valid_sample (last_sample)
		end
		
	division_factors : ARRAY[INTEGER] is
		once
			create Result.make (1, 8)
			Result.put (2, 1)
			Result.put (4, 2)
			Result.put (8, 3)
			Result.put (16, 4)
			Result.put (32, 5)
			Result.put (64, 6)
			Result.put (128, 7)
			Result.put (256, 8)
		end
		
	sample_index (x,y : INTEGER) : INTEGER is
		local
			row_length : INTEGER
		do
			row_length := width * color_count
			Result := 1 + (x-1) * color_count + (y-1) * row_length
		end
					
	create_samples (the_width, the_height, the_sample_colors : INTEGER) is
			-- 
		do
			samples := STRING_.make_filled ('%/0/', the_width * the_height * the_sample_colors)
		ensure
			samples_exist: samples /= Void
			samples_capacity: samples.capacity = (the_width * the_height * the_sample_colors)
		end
		
end -- class PDF_IMAGE
