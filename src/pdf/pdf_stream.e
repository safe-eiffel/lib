indexing

	description: "Objects where page drawing occur."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class
	
	PDF_STREAM

inherit
	
	PDF_OBJECT
		rename
			make as make_object
		redefine
			put_pdf
		end

--	PDF_TEXT_STATE
	
creation
	
	make

feature -- Initialization

	make (a_number : INTEGER; a_page : PDF_PAGE) is
			-- 
		do
			make_object (a_number)
			!!content.make (0)
			page := a_page
			debug ("debug_stream")
				unencoded := True
			end
		ensure
			page = a_page
		end

feature -- Access

	page : PDF_PAGE
			-- page where the stream occurs
		
feature -- Status report

	text_mode : BOOLEAN
	
feature -- Status setting

	set_text_render_mode (a_mode : INTEGER) is
		do
			content_append_intop (a_mode, "Tr")
		end

feature -- Element change

	move_text_origin (x, y : DOUBLE) is
			-- begin a new line, with an (x,y) offset from the previous one
		do
--			text_origin_x := text_origin_x + x
--			text_origin_y := text_origin_y + x
			content_append_double (x)
			content.append_character (' ')
			content_append_double (y)
			content.append_string (" Td%N")
		end

	put_string (s : STRING) is
			-- put string `s'
		do
			content_append_literal_string (s)
			content.append_string (" Tj%N") 
		end

	put_new_line is
			-- go to next line 
		do
			content.append_string (" T*%N")
		end

	put_new_line_string (s : STRING) is
			-- put string `s' and issue a newline
		do
			content_append_literal_string (s)
			content.append_string (" '%N")
		end

	set_text_leading (l : DOUBLE) is
			-- set `l' as text_leading
		do
			content_append_numop (l, "TL")
		end

	set_character_spacing (s : DOUBLE) is
			-- set `character_spacing' to `s'
		do
			content_append_numop (s, "Tc")
		end
		
	set_word_spacing (w : DOUBLE) is
			-- 
		do
			content_append_numop (w, "Tw")
		end
		
	set_horizontal_scaling (s : DOUBLE) is
			-- 
		require
			not_zero: s > 0
		do
			content_append_numop (s, "Tz")
		end
	
	set_text_rise (r : DOUBLE) is
			-- 
		do
			content_append_numop (r, "Ts")
		end
	
feature {PDF_PAGE} --

	set_font (a_font : PDF_FONT; size : DOUBLE) is
			-- 
		do
			content_append_name (page.font_alias (a_font)) --page.font_alias
			content_append_space
			content_append_double (size)
			content_append_space
			content.append_string (" Tf%N")
		end

	put_image (image : PDF_IMAGE) is
		do
			content_append_name (page.image_alias (image))
			content_append_space
			content.append_string (" Do%N")
		end
		
feature -- Removal

feature -- Resizing

feature -- Transformation

	
feature -- Conversion

	to_pdf : STRING is
			-- 
		local
			length : PDF_NAME
		do
			!!Result.make (0)
			Result.append_string (object_header)
			-- dictionary
			Result.append_string (begin_dictionary)
			!!length.make ("Length")
			Result.append_string (length.to_pdf)
			Result.append_character (' ')
			
			Result.append_string (content.count.out)
			Result.append_string (end_dictionary)
			-- stream
			Result.append_string ("stream%N")
			-- content
			Result.append_string (content)
			Result.append_character ('%N')
			-- endstream
			Result.append_string ("endstream%N")
			-- endobj
			Result.append_string (object_footer)
		end

	put_pdf (medium : PDF_OUTPUT_MEDIUM) is
			-- 
		local
			length : PDF_NAME
			content_length : INTEGER
			zlib_format : ZLIB_FORMAT
			encoded_stream : STRING
			names : PDF_NAME_CONSTANTS
			ascii_85_format : ASCII_85_FORMAT
			filter : PDF_ARRAY_SERIALIZABLE[PDF_NAME]
		do
			if not unencoded then
				create zlib_format
				create ascii_85_format
				create names
				encoded_stream := zlib_format.encode (content)
				encoded_stream := ascii_85_format.encode (encoded_stream)
				content_length := ascii_85_format.last_encoded_count (medium)
			else
				content_length := content.count + content.occurrences ('%N') * (medium.eol_count - 1)
			end
			medium.put_string (object_header)
			-- dictionary
			medium.put_string (begin_dictionary)
			medium.put_string (dictionary_entry (names.LENGTH, content_length.out))
			if not unencoded then
				create filter.make (1,2)
				filter.put (names.Ascii85decode,1)
				filter.put (names.Flatedecode,2)
				medium.put_string (dictionary_entry (names.Filter, filter.to_pdf))
			end
			medium.put_string (end_dictionary)
			-- stream
			medium.put_string ("stream%N")
			-- content
			
			if unencoded then
				medium.put_string (content)
			else
				medium.put_string (encoded_stream)
			end
			medium.put_new_line
			-- endstream
			medium.put_string ("endstream%N")
			-- endobj
			medium.put_string (object_footer)			
		end
		
feature -- Basic operations

	begin_text is
		do
--			text_origin_x := 0
--			text_origin_y := 0
			content.append_string ("BT%N")
			text_mode := True
		end
		
	end_text is
		do
			content.append_string ("ET%N")
			text_mode := False
		end

	gsave is
			-- 
		do
			content.append_string ("q%N")
		end
		
	grestore is
			-- 
		do
			content.append_string ("Q%N")
		end
		
	translate (a_tx, a_ty : DOUBLE) is
			-- 
		do
			concatenate_to_ctm (1, 0, 0, 1, a_tx, a_ty)
		end

	scale (sx, sy : DOUBLE) is
			-- 
		do
			concatenate_to_ctm (sx, 0, 0, sy, 0, 0)
		end
		
	rotate (theta : DOUBLE) is
			-- 
		local
			math : expanded EPDF_MATH
			c, s : DOUBLE
		do
			c := math.cosine (theta)
			s := math.sine (theta)
			concatenate_to_ctm (c, s, -s, c, 0, 0)
		end
	
	skew (alpha, beta : DOUBLE) is
			-- 
		local
			math : expanded EPDF_MATH
		do
			concatenate_to_ctm (1, math.tangent (alpha), math.tangent (beta), 1, 0, 0)
		end

	stroke is
			-- 
		do
			content.append_string ("S%N")
		end
	
	fill (path_fill_heuristics : INTEGER) is
			-- 
		do
			content.append_string (" f")
			if path_fill_heuristics > 0 then
				content.append_character ('*')
			end
			content.append_character('%N')
		end
		
	fill_then_stroke  (path_fill_heuristics : INTEGER) is
			-- 
		do
			content.append_string (" B")
			if path_fill_heuristics > 0 then
				content.append_character ('*')
			end
			content.append_character('%N')
		end

	clip  (path_fill_heuristics : INTEGER) is
			-- 
		do
			content.append_string (" W")
			if path_fill_heuristics > 0 then
				content.append_character ('*')
			end
			content.append_character('%N')
		end
		
	end_path is
			--
		do
			content.append_string (" n%N")
		end
		
	rectangle (x, y, w, h : DOUBLE) is
			--
		do
			content_append_double (x)
			content_append_space
			content_append_double (y)
			content_append_space
			content_append_double (w)
			content_append_space
			content_append_double (h)
			content_append_space
			content.append_string ("re%N")
		end
		
	set_text_origin (a_tx, a_ty : DOUBLE) is
			-- 
		do
			set_text_matrix (1, 0, 0, 1, a_tx, a_ty)
--			text_origin_x := a_tx
--			text_origin_y := a_ty
--		ensure
--			text_origin_x = a_tx
--			text_origin_y = a_ty
		end

	set_text_matrix (a, b, c, d, e, f : DOUBLE) is
			-- 
		do
			content_append_transformation_matrix (a, b, c, d, e, f)
			content.append_string (" Tm%N")
		end

--	scale_text (sx, sy : DOUBLE) is
--			-- 
--		do
--			set_text_matrix (sx, 0, 0, sy, 0, 0)
--		end
--		
--	rotate_text (theta : DOUBLE) is
--			-- 
--		local
--			math : expanded EPDF_MATH
--		do
--			set_text_matrix (math.cosine(theta), math.sine(theta), -math.sine(theta), math.cosine(theta), 0, 0)
--		end
--	
--	skew_text (alpha, beta : DOUBLE) is
--			-- 
--		local
--			math : expanded EPDF_MATH
--		do
--			set_text_matrix (1, math.tangent (alpha), math.tangent (beta), 1, 0, 0)
--		end
--
--	reset_text_matrix  is
--			--
--		do
--			set_text_matrix (1, 0, 0, 1, 0, 0)
--		end


	set_gray (gray : DOUBLE) is
		do
			content_append_double (gray)
			content_append_space
			content.append_string (" g%N")
		end

	set_gray_stroke (gray : DOUBLE) is
		do
			content_append_double (gray)
			content_append_space
			content.append_string (" G%N")
		end
		
	set_rgb_color (r, g, b : DOUBLE) is
		do
			content_append_double (r)
			content_append_space
			content_append_double (g)
			content_append_space
			content_append_double (b)
			content_append_space
			content.append_string (" rg%N")
		end
		
	set_rgb_color_stroke (r, g, b : DOUBLE) is
		do
			content_append_double (r)
			content_append_space
			content_append_double (g)
			content_append_space
			content_append_double (b)
			content_append_space
			content.append_string (" RG%N")
		end

	set_line_width (w : DOUBLE) is
		do
			content_append_numop (w, "w")
		end
		
	set_line_cap (c : INTEGER) is
		do
			content_append_intop (c, "J")			
		end
		
	set_line_join (j : INTEGER) is
		do
			content_append_intop (j, "j")
		end
		
	set_miter_limit (m : DOUBLE) is
		do
			content_append_numop (m, "M")
		end

	set_line_dash (pattern : ARRAY[INTEGER]; phase : INTEGER) is
			-- 
		require
			pattern /= Void
			phase >= 0
		local
			index : INTEGER
		do
			content.append_character ('[')
			from
				index := 1
			until
				index > pattern.upper
			loop
				content.append_string (pattern.item (index).out)
				content_append_space
				index := index + 1
			end
			content.append_character (']')
			content_append_space
			content_append_intop (phase, "d")			
		end
		
	set_line_solid is
			-- unset line_dash
		do
			content.append_string ("[] 0 d%N")
		end

	move (x, y : DOUBLE) is
			-- create at new subpath at (x,y)
		do
			content_append_double (x)
			content_append_space
			content_append_numop (y, "m")
		end
		
	lineto (x, y : DOUBLE) is
			-- draws a line in the current subpath from current position
			-- to (x,y).  (x,y) becomes the new current position
		do
			content_append_double (x)
			content_append_space
			content_append_numop (y, "l")			
		end
		
	close_path is
			-- close current subpath by drawing a straight line from current
			-- path position to subpath origin
		do
			content.append_string (" h%N")
		end
		
	bezier_1 (cx1, cy1, cx2, cy2, px, py : DOUBLE) is
			-- append_string a bezier curve to current subpath, with current position
			-- as starting point, (px, py) as end point, and control points
			-- (cx1, cy1) attached to starting point and (cx2,cy2) attached to end point
			-- (px, py) is the new current position
		do
			content_append_double (cx1)
			content_append_space
			content_append_double (cy1)
			content_append_space
			content_append_double (cx2)
			content_append_space
			content_append_double (cy2)
			content_append_space
			content_append_double (px)
			content_append_space
			content_append_double (py)
			content_append_space
			content.append_string ("c%N")			
		end
		
	bezier_2 (cx2, cy2, px, py : DOUBLE) is
			-- append_string a bezier curve to current subpath, with current position
			-- as starting point, (px, py) as end point, and control point
			-- (cx2,cy2) attached to end point. (px, py) is the new current position
		do
			content_append_double (cx2)
			content_append_space
			content_append_double (cy2)
			content_append_space
			content_append_double (px)
			content_append_space
			content_append_double (py)
			content_append_space
			content.append_string ("v%N")			
		end
		
	bezier_3 (cx1, cy1, px, py : DOUBLE) is
			-- append_string a bezier curve to current subpath, with current position
			-- as starting point, (px, py) as end point, and control point
			-- (cx1,cy1) attached to starting point. (px, py) is the new current position
		do
			content_append_double (cx1)
			content_append_space
			content_append_double (cy1)
			content_append_space
			content_append_double (px)
			content_append_space
			content_append_double (py)
			content_append_space
			content.append_string ("y%N")			
		end

feature {NONE} -- Implementation


	content : STRING

	content_append_literal_string (s : STRING) is
			-- 
		local
			index : INTEGER
		do
			content.append_character ('(')
			-- output string, prefixing parentheses and backslashes by a backslash
			from
				index := 1
			until
				index > s.count
			loop
				inspect s.item (index)
				when '(', ')', '\' then
					content.append_character ('\')
				else
					-- do nothing
				end
				content.append_character (s.item (index))
				index := index + 1
			end
			content.append_character (')')
		end

	content_append_space is
			-- 
		do
			content.append_character (' ')
		end
		
	content_append_double (d : DOUBLE) is
			-- format 'iiiiii' or 'iiiii.ffff'
		local
			integral, fraction : INTEGER
			sign : INTEGER
		do
			sign := d.sign
			integral := d.truncated_to_integer
			fraction := ((d - integral) * 10000 * sign).truncated_to_integer
			if integral = 0 and sign = - 1 then
				content.append_character ('-')
			end
			content.append_string (integral.out)
			if fraction > 0 then
				content.append_character ('.')
				if fraction < 10 then
					content.append_string ("000")
				elseif fraction < 100 then
					content.append_string ("00")
				elseif fraction < 1000 then
					content.append_string ("0")
				end
				content.append_string (fraction.out)
			end
		end
		
	content_append_name (s : STRING) is
			-- 
		do
			content.append_character ('/')
			content.append_string (s)
		end

	concatenate_to_ctm (a, b, c, d, e, f : DOUBLE) is
			--
		do
			content_append_transformation_matrix (a, b, c, d, e, f)
			content.append_string (" cm%N")			
		end

	content_append_transformation_matrix (a, b, c, d, e, f : DOUBLE) is
			-- 
		do
			content_append_double (a)
			content_append_space
			content_append_double (b)
			content_append_space
			content_append_double (c)
			content_append_space
			content_append_double (d)
			content_append_space
			content_append_double (e)
			content_append_space
			content_append_double (f)
			content_append_space
		end
	
	content_append_numop (n : DOUBLE; op : STRING) is
			-- "num op%N"
		do
			content_append_double (n)
			content_append_space
			content.append_string (op)
			content.append_character ('%N')
		end

	content_append_intop (i : INTEGER; op : STRING) is
			-- "int op%N"
		do
			content.append_string (i.out)
			content_append_space
			content.append_string (op)
			content.append_character ('%N')
		end
		
	unencoded : BOOLEAN
	
invariant
	invariant_clause: -- Your invariant here

end -- class PDF_STREAM
