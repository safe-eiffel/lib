indexing

	description: "Objects that represent a PDF page.  It has a graphical and textual state.%
				% Page contents is drawn by successive streams of Graphical and textual operations."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class
	PDF_PAGE

inherit
	
	PDF_OBJECT
		undefine
			copy
		redefine
			make
		end

	PDF_PAGE_TREE_NODE
		
	PDF_TEXT_STATE_OPERATORS
		rename
			font as current_font,
			font_size as current_font_size
		undefine
			copy
		end
	
	PDF_GRAPHICS_STATE_OPERATORS
		
creation
	make

feature {NONE} -- Initialization

	make (an_object : INTEGER) is
			-- 
		local
			procname : PDF_NAME
		do
			Precursor (an_object)
			!!fonts.make
			!!procset.make (1,2)
			!!procname.make ("PDF")
			procset.put (procname, 1)
			!!procname.make ("Text")
			procset.put (procname, 2)
			!!resources.make
			resources.add_entry ("ProcSet", procset)
			resources.add_entry ("Font", fonts)
			!!mediabox.make_a4
			make_text_state
			make_graphics_state
			!!state_stack.make
		ensure then 
			procset /= Void
			resources /= Void
			mediabox /= Void
		end
		
feature -- Access

	mediabox : PDF_RECTANGLE
			-- rectangle describing the size of the medium 
			
	medium_rotation : INTEGER
			-- number of degrees the medium must be rotated when displayed or printed
			-- must be a multiple of 90
	
	current_stream : PDF_STREAM

feature {PDF_OBJECT} -- Access

	resources : PDF_DICTIONARY
			-- resources used by the page to draw its contents (like fonts and procset)

	count : INTEGER is 1
				-- count of leafs...

	frozen kids : DS_LIST[PDF_PAGE_TREE_NODE] is
			-- dummy definition
		do
		end

	contents : DS_LIST [PDF_STREAM] is
			-- streams of graphical operations
		do
			if impl_contents = Void then
				!DS_LINKED_LIST[PDF_STREAM]!impl_contents.make
			end
			Result := impl_contents
		end		

	procset : PDF_ARRAY_SERIALIZABLE[PDF_NAME]
			-- member of `resources'
	
	fonts : PDF_DICTIONARY
			-- member of `resources'
	
feature -- Element change

	set_font (a_font : PDF_FONT; a_size : DOUBLE) is
		do
			if not has_font (a_font) then
				use_font (a_font)
			end
			current_font_size := a_size
			current_font := a_font
			current_stream.set_font (a_font, a_size)
		end
	
	set_medium_rotation (r : INTEGER) is
			-- rotate medium
		require
			multiple_90: (r \\ 90) = 0
		do
			medium_rotation := r
		ensure
			medium_rotation_set: medium_rotation = r
		end
		
feature -- Status Report

	is_page : BOOLEAN is True
	
feature -- Element change

	add_stream (a_document : PDF_DOCUMENT) is
			-- 
		require
			a_document /= Void
		do
			a_document.create_stream
			contents.put_last (a_document.last_stream)
			current_stream := a_document.last_stream
		ensure
			contents.has (current_stream)
			current_stream = a_document.last_stream
		end
	
	set_mediabox (a_box : PDF_RECTANGLE) is
			-- set 'a_box' as mediabox
		require
			exists: a_box /= Void
		do
			mediabox := a_box
		ensure
			set: mediabox = a_box
		end
		
feature -- Conversion

	to_pdf : STRING is
			-- 
		local
			stype, sparent, sresources, smediabox : PDF_NAME
			contents_cursor : DS_LIST_CURSOR [PDF_OBJECT]
		do
			!!stype.make ("Type")
			!!sparent.make ("Parent")
			!!sresources.make ("Resources")
			!!smediabox.make ("MediaBox")
			!!Result.make (0)
			Result.append (object_header)
			Result.append (begin_dictionary)
			-- Type
			Result.append (dictionary_entry (stype, "/Page"))
			-- Parent
			Result.append (dictionary_entry (sparent, parent.indirect_reference))
			-- Resources can be empty : <<>>
			if resources = Void then
				Result.append (dictionary_entry (sresources, "<< >>"))
			else
				Result.append (dictionary_entry (sresources, resources.to_pdf))
			end
			-- MediaBox
			Result.append (dictionary_entry (smediabox, mediabox.to_pdf))
			-- contents (optional)			
			if contents.count > 0 then
				Result.append ("/Contents ")
				if contents.count > 1 then
					Result.append ("[ ")					
				end
				from 
					contents_cursor := contents.new_cursor
					contents_cursor.start
				until
					contents_cursor.off
				loop
					Result.append (contents_cursor.item.indirect_reference)
					Result.append_character (' ')
					contents_cursor.forth
				end
				if contents.count > 1 then
					Result.append (" ]%N")
				end
			end
			-- medium_rotation
			if medium_rotation /= 0 then
				Result.append ("/Rotate ")
				Result.append (medium_rotation.out)
				Result.append ("%N")
			end
			Result.append (end_dictionary)
			Result.append (object_footer)
		end
		
feature -- Basic operations - Graphics

	set_line_width (w : DOUBLE) is
		do
			line_width := w
			current_stream.set_line_width (w)
		end
		
	set_line_cap (c : INTEGER) is
		do
			line_cap := c
			current_stream.set_line_cap (c)
		end
		
	set_line_join (j : INTEGER) is
		do
			line_join := j
			current_stream.set_line_join (j)
		end
		
	set_miter_limit (m : DOUBLE) is
		do
			miter_limit := m
			current_stream.set_miter_limit (m)
		end

	set_line_dash (array : ARRAY[INTEGER]; phase : INTEGER) is
		do
			!!line_dash_array.make_from_array(array)
			line_dash_phase := phase
			current_stream.set_line_dash (array, phase)
		end

	set_line_solid is
		do
			current_stream.set_line_solid
			line_dash_array := Void
			line_dash_phase := 0
		end
		
feature -- Basic operations

	gsave is
			-- push graphics state on internal stack
		local
			state : PDF_PAGE_STATE
		do
			current_stream.gsave
			--| FIXME push state on stack
			!!state.make
			state.copy_text_state (Current)
			state.copy_graphics_state (Current)
			state_stack.put (state)
			save_level := save_level + 1
		end
		
	grestore is
			-- pop graphics state from internal stack
		do
			current_stream.grestore
			--| FIXME pop state from stack
			copy_text_state (state_stack.item)
			copy_graphics_state (state_stack.item)
			state_stack.remove
			save_level := save_level - 1
		end

	set_gray (a_gray : DOUBLE) is
			-- set 'a_gray' level color for non-stroking operations			
		do
			impl_gray := a_gray
			current_stream.set_gray (a_gray)			
		ensure then
			gray = a_gray
		end

	set_gray_stroke (a_gray : DOUBLE) is
			-- set 'a_gray' level color for stroking operations
		do			
			current_stream.set_gray_stroke (a_gray)
			impl_gray_stroke := a_gray
		ensure then
			gray_stroke = a_gray
		end
		
	set_rgb_color (r, g, b : DOUBLE) is
			-- set color to ('r','g','b') for non-stroking operations
		do
			impl_rgb := <<r, g, b>>
			current_stream.set_rgb_color (r, g, b)
		end
		
	set_rgb_color_stroke (r, g, b : DOUBLE) is
			-- set color to ('r','g','b') for stroking operations
		do
			impl_rgb_stroke := <<r,g,b>>
			current_stream.set_rgb_color_stroke (r, g, b)
		end

	begin_text is
		do
			operations_mode := Mode_text
			tlm.set_identity
			tm.set_identity
			line_x := 0
			line_y := 0
			text_x := 0
			text_y := 0
			current_stream.begin_text
		ensure then
			tm.is_identity
			tlm.is_identity
			line_x = 0
			line_y = 0
			text_x = 0
			text_y = 0		
		end
		
	end_text is
			-- end text mode
		do
			operations_mode := Mode_page_definition
			current_stream.end_text
		end

feature -- Coordinate system operations

	translate (a_tx, a_ty : DOUBLE) is
		do
			current_stream.translate (a_tx, a_ty)
		end

	scale (sx, sy : DOUBLE) is
		do
			current_stream.scale (sx, sy)
		end
		
	rotate (theta : DOUBLE) is
		do
			current_stream.rotate (theta)
		end
	
	skew (alpha, beta : DOUBLE) is
		do
			current_stream.skew (alpha, beta)
		end

feature -- Painting operators

	stroke is
		do
			current_stream.stroke
			operations_mode := Mode_page_definition
		end
	
	fill is
		do
			current_stream.fill (path_fill_heuristics)
			operations_mode := Mode_page_definition
		end
		
	fill_then_stroke is
		do
			current_stream.fill_then_stroke(path_fill_heuristics)
			operations_mode := Mode_page_definition
		end
		
	end_path is
		do
			current_stream.end_path
			operations_mode := Mode_page_definition
		end
		
feature -- Clipping operators

	clip is
		do
			current_stream.clip (path_fill_heuristics)
			operations_mode := Mode_clipping
		end

feature -- Path Construction operators
		
	rectangle (x, y, w, h : DOUBLE) is
		do
			current_x := x
			current_y := y + h
			current_stream.rectangle (x, y, w, h)
			operations_mode := Mode_path
		end

	move (x, y : DOUBLE) is
		do
			current_x := x
			current_y := y
			path_origin_x := x
			path_origin_y := y
			current_stream.move (x,y)
			operations_mode := Mode_path
		end
		
	lineto (x, y : DOUBLE) is
		do
			current_x := x
			current_y := y
			current_stream.lineto (x, y)
		end
		
	close_path is
		do
			current_x := path_origin_x
			current_y := path_origin_y
			current_stream.close_path
		end
		
	bezier_1 (cx1, cy1, cx2, cy2, px, py : DOUBLE) is
		do
			current_x := px
			current_y := py
			current_stream.bezier_1 (cx1, cy1, cx2, cy2, px, py)
		end
		
	bezier_2 (cx2, cy2, px, py : DOUBLE) is
		do
			current_x := px
			current_y := py
			current_stream.bezier_2 (cx2, cy2, px, py)
		end
		
	bezier_3 (cx1, cy1, px, py : DOUBLE) is
		do
			current_x := px
			current_y := py
			current_stream.bezier_3 (cx1, cy1, px, py)
		end

feature -- Basic operations - Text

	set_text_render_mode (a_mode : INTEGER) is
		do
			text_render_mode := a_mode
			current_stream.set_text_render_mode (a_mode)
		end

	move_text_origin (x, y : DOUBLE) is
			-- begin a new line, with an (x,y) offset from the previous one
		local
			m : PDF_TRANSFORMATION_MATRIX
		do
			current_stream.move_text_origin (x, y)
			line_x := line_x + x
			line_y := line_y + y
			text_x := line_x
			text_y := line_y
			!!m.set (1,0,0,1,x,y)
			tlm := tlm * m
			tm := tm * m
		end

	put_string (s : STRING) is
		local
			m : PDF_TRANSFORMATION_MATRIX
			w : DOUBLE
		do
			current_stream.put_string (s)
			w := string_width (s)
			!!m.set(1,0,0,1,w,0)
			tm := tm * m
			text_x := text_x + w
		end

	put_new_line is
		local
			m : PDF_TRANSFORMATION_MATRIX
		do
			current_stream.put_new_line
			line_y := line_y - text_leading
			text_x := line_x
			text_y := line_y
			!!m.set (1,0,0,1,0,-text_leading)
			tm := tlm * m
			tlm := tlm * m
		end
	
	put_new_line_string (s : STRING) is
			-- 
		local
			m : PDF_TRANSFORMATION_MATRIX
			w : DOUBLE
		do
			current_stream.put_new_line_string (s)
			w := string_width (s)
			line_y := line_y - text_leading
			text_x := line_x + w
			text_y := line_y
			!!m.set (1,0,0,1,0,-text_leading)
			tm := tlm * m
			!!m.set (1,0,0,1,w,0)
			tlm := tm * m
		end


	string_width (string : STRING) : DOUBLE is
			-- width of `string' using current text state
			-- i.e : current_font_size, character_spacing, word_spacing, horizontal_scaling
		do
			Result := current_font.string_width (string, current_font_size, character_spacing, word_spacing, horizontal_scaling)
		end

	put_text (txt : STRING; width : DOUBLE) is
			-- put text 'txt', beginning at current line position
			-- and writing lines no longer than 'width'
			-- if width is reached, characters are wrapped on a next line
			-- Newline (%N) starts a new line
		require
			txt /= Void
		local
			i_begin, i_end : INTEGER
			current_char_width, current_width : DOUBLE
			lines : INTEGER
			new_line : BOOLEAN
		do
			from
				i_begin := 1
				lines := 1
			until
				i_begin > txt.count or else i_end > txt.count
			loop
				if lines > 1 then
					--skip spaces
					from
						
					until
						i_begin > txt.count or else txt.item (i_begin) /= ' '
					loop
						i_begin := i_begin + 1
					end
				end
				from
					current_width := 0
					i_end := i_begin
				until
					i_end > txt.count or else current_width > width or else txt.item (i_end)='%N'
				loop
					current_char_width := tx_page (txt.item (i_end), 0.0)
					current_width := current_width + current_char_width
					i_end := i_end + 1
				end
				new_line := (txt.item (i_end) = '%N')
				-- i_end always an index too far wrt 
				i_end := i_end - 1
				if current_width > width then
					-- one character too far
					i_end := i_end - 1
				end
				if lines = 1 then
					put_string (txt.substring (i_begin, i_end))
				else
					put_new_line_string (txt.substring (i_begin, i_end))
				end
				if new_line then
					-- skip the new_line character
					i_end := i_end + 1
				end
				i_begin := i_end + 1
				lines := lines + 1
			end			
		end

	set_text_leading (l : DOUBLE) is
		do
			if text_leading /= l then
				text_leading := l
				current_stream.set_text_leading (l)
			end
		end

	set_character_spacing (s : DOUBLE) is
		do
			if character_spacing /= s then
				character_spacing := s
				current_stream.set_character_spacing (s)
			end
		end
		
	set_word_spacing (w : DOUBLE) is
		do	
			if word_spacing /= w then
				word_spacing := w
				current_stream.set_word_spacing (w)
			end
		end
		
	set_horizontal_scaling (s : DOUBLE) is
		do
			if horizontal_scaling /= s then
				horizontal_scaling := s
				current_stream.set_horizontal_scaling (s)
			end
		end
	
	set_text_rise (r : DOUBLE) is
		do
			if text_rise /= r then
				text_rise := r
				current_stream.set_text_rise (r)
			end
		end

	set_text_matrix (a_text_matrix : PDF_TRANSFORMATION_MATRIX) is
		do
			tm.copy (a_text_matrix)
			current_stream.set_text_matrix (tm.a, tm.b, tm.c, tm.d, tm.e, tm.f)
		end
		
feature {PDF_STREAM} -- Access 

	font_alias (a_font : PDF_FONT) : STRING is
			-- fonts receive an alias (nickname) within the context of a page
		require
			a_font_exists: a_font /= Void
			has_font: has_font (a_font)
		local
			index : INTEGER
		do
			index := font_index (a_font)
			if index <= fonts.count then
				Result := fonts.key (index)
			end
		end
		
	has_font (a_font : PDF_FONT) : BOOLEAN is
			-- does a font with 'font_name' exist ?
		do
			Result := (font_index (a_font) <= fonts.count)	
		end
			
feature {NONE} -- Implementation

	tx_page (c : CHARACTER; position_adjustment : DOUBLE) : DOUBLE is
			-- 
		do
			Result := current_font.horizontal_displacement (c, current_font_size, character_spacing, word_spacing, position_adjustment, horizontal_scaling)
		end

	impl_contents : DS_LIST [PDF_STREAM]
	
	font_index (a_font : PDF_FONT) : INTEGER is
			-- 
		require
			a_font_exists: a_font /= Void
		local
			index : INTEGER
			font : PDF_FONT
		do
			index := 1
			if fonts.count > 0 then
				from
					font ?= fonts.value (index)
				until
					index > fonts.count or else font.number = a_font.number 
				loop
					index := index + 1
					if index <= fonts.count then
						font ?= fonts.value (index)
					end
				end
			end
			Result := index
		end

		
	use_font (a_font : PDF_FONT) is
			-- 
		require
			a_font /= Void
			not has_font (a_font)
		local
			fname : STRING
		do
			!!fname.make (0)
			fname.append ("F")
			fname.append ((fonts.count + 1).out)
			fonts.add_entry (fname, a_font)
		end

	state_stack : DS_LINKED_STACK [PDF_PAGE_STATE]
	
invariant
	invariant_clause: -- Your invariant here

end -- class PDF_PAGE
