indexing

class
	PDF_GRAPHICS_STATE
	
inherit

	PDF_NUMBER_OPERATORS
		undefine
			copy
		end

	ANY
		redefine
			copy
		end
		
--creation
--	make_graphics_state
	
feature {NONE} -- Initialization

	make_graphics_state is
		do
			!!ctm.set_identity
			color_space := Color_space_gray
			line_width := 1
			line_cap := Butt_cap
			line_join := Miter_join
			miter_limit := 10
			current_x := 0
			current_y := 0
			line_dash_phase := 0
			line_dash_array := Void
		ensure
			ctm_identity: 		ctm.is_identity
			default_color_space: 	color_space = Color_space_gray
			default_colors: 	gray = 0 and gray_stroke = 0
			line_width: 		equal_numbers (line_width, 1)
			line_cap: 		line_cap = Butt_cap
			line_join: 		line_join = Miter_join
			miter_limit: 		equal_numbers (miter_limit, 10)
			current_point:		current_x = 0 and current_y = 0
			solid_line:		line_dash_phase = 0 and line_dash_array = Void
		end
		
feature -- Access

	current_x : DOUBLE
		-- current point x
	
	current_y : DOUBLE
		-- current point y
	
	path_origin_x : DOUBLE
		-- `y' coordinate of current path origin
	
	path_origin_y : DOUBLE
		-- `x' coordinate of current path origin
	
	ctm : PDF_TRANSFORMATION_MATRIX
		-- current transformation matrix
	
	color_space : INTEGER
		-- current color space
		
	gray : DOUBLE is
		-- gray index for non-stroking operations
		-- useful when color_space = color_space_gray
		require
			color_space = Color_space_gray
		do
			Result := impl_gray
		ensure
			between_black_an_white: 0 <= Result and Result <= 1
		end
		
	gray_stroke : DOUBLE is
		-- gray index for stroking operations
		-- useful when color_space = color_space_g
		require
			color_space = Color_space_gray
		do
			Result := impl_gray_stroke
		ensure
			between_black_an_white: 0 <= Result and Result <= 1
		end
			
	rgb : ARRAY[DOUBLE] is
			-- rgb color for non-stroking operations
		require
			color_space = color_space_rgb
		do
			Result := impl_rgb
		ensure
			Result /= Void
			Result.lower = 1
			Result.upper = 3
		end
		
	rgb_stroke : ARRAY[DOUBLE] is
			-- rgb color for stroking operations
		require
			color_space = color_space_rgb
		do
			Result := impl_rgb_stroke
		ensure
			Result /= Void
			Result.lower = 1
			Result.upper = 3
		end

	line_width : DOUBLE
			-- The thickness, in user space units, of paths to be stroked (see “Line
			-- Width” PDFReference v1.3 p. 139).

	line_cap : INTEGER
			-- The line cap style specifies the shape to be used at the ends of open 
			-- subpaths (and dashes, if any) when they are stroked (PDFReference v1.3 p. 139). 
	
	line_join : INTEGER
			-- The line join style specifies the shape to be used at the corners of 
			-- paths that are stroked (PDFReference v1.3 p. 140).
	
	miter_limit : DOUBLE
			-- The miter limit imposes a maximum on the ratio of the miter length 
			-- to the line width. When the limit is exceeded, the join is converted from a miter to a bevel. 
			-- (PDFReference v1.3 p. 140)
			-- This parameter limits the length of “spikes” produced when line segments join at sharp angles. 
			-- Initial value: 10.0, for a miter cutoff below approximately 11.5 degrees.

	line_dash_array : PDF_ARRAY[INTEGER]
			-- The line dash pattern controls the pattern of dashes and gaps used to stroke paths.
			-- It is specified by a dash array and a dash phase. The dash array’s elements are
			-- numbers that specify the lengths of alternating dashes and gaps.

	line_dash_phase : INTEGER
			-- the dash phase specifies the distance into the dash pattern at which to start the dash. 
			-- The elements of both the dash array and the dash phase are expressed in user space units.
	
	path_fill_heuristics : INTEGER
			-- Rule to compute the surface 'inside' a path
			-- See PDFReference v1.3 Section 4.4 on page 153
			
feature -- Status report

	operations_mode : INTEGER
			-- See page 122, Ch. 4 of PDF Reference v1.3
	
	is_text_mode : BOOLEAN is
			-- is `operations_mode' in text mode?
		do
			Result := operations_mode = Mode_text
		end
		

	is_page_definition_mode : BOOLEAN is
			-- is `operations_mode' in page-definition mode?
		do
			Result := operations_mode = Mode_Page_definition
		end
	
	is_path_mode : BOOLEAN is
			-- is `operations_mode' in path mode?
		do
			Result := operations_mode = Mode_Path
		end
		
	is_clipping_mode : BOOLEAN is
			-- is `operations_mode' in clipping mode?
		do
			Result := operations_mode = Mode_Clipping
		end
		

	save_level : INTEGER
			-- depth of graphical state stack (see `gsave' & `grestore')
	
feature -- Miscellaneous

	Mode_page_definition : INTEGER is 0
	Mode_text  : INTEGER is 1
	Mode_path : INTEGER is 2
	Mode_clipping : INTEGER is 3
	Mode_inline_image : INTEGER is 4
	Mode_external_object : INTEGER is 5
	Mode_shading_object : INTEGER is 6

	Miter_join : INTEGER is 0
			-- Miter join. The outer edges of the strokes for the two
			-- segments are extended until they meet at an angle, as
			-- in a picture frame. If the segments meet at too sharp
			-- an angle (as defined by the miter limit parameter—
			-- see “Miter Limit,”), a bevel join is used instead.

	Round_join : INTEGER is 1
			-- Round join. A circle with a diameter equal to the line
			-- width is drawn around the point where the two
			-- segments meet and is filled in, producing a rounded
			-- corner.
			-- Note: If path segments shorter than half the line width
			-- meet at a sharp angle, an unintended “wrong side” of
			-- the circle may appear.

	Bevel_join : INTEGER is 2
			-- Bevel join. The two segments are finished with butt
			-- caps (see “Line Cap Style” on page 139) and the
			-- resulting notch beyond the ends of the segments is
			-- filled with a triangle.	


	Butt_cap : INTEGER is 0
			-- Butt cap. The stroke is squared off at the endpoint of
			-- the path. There is no projection beyond the end of
			-- the path.

	Round_cap : INTEGER is 1
			-- Round cap. A semicircular arc with a diameter equal
			-- to the line width is drawn around the endpoint and
			-- filled in.

	Projecting_square_cap : INTEGER is 2
			-- Projecting square cap. The stroke continues beyond
			-- the endpoint of the path for a distance equal to half
			-- the line width and is then squared off.

	Color_space_gray : INTEGER is 1
			-- /DeviceGray
			
	Color_space_rgb : INTEGER is 2
			-- /DeviceRGB
			
	Non_zero_winding_rule : INTEGER is 0
			-- Fill heuristics: non-zero winding rule
	
	Even_odd_rule : INTEGER is 1
			-- Fill heuristics: even-odd rule
	
feature -- Copy

	copy (other : like Current) is
		do
			copy_graphics_state (other)
		end
		
	copy_graphics_state (other: PDF_GRAPHICS_STATE) is
			--
		require
			state_exists: other /= Void
		local
			index :INTEGER
		do
			current_x := other.current_x
			current_y := other.current_y
			path_origin_x := other.path_origin_x
			path_origin_y := other.path_origin_y
			ctm.copy (other.ctm)
			color_space := other.color_space
			if other.color_space = Color_space_gray then
				impl_gray := other.gray
				impl_gray_stroke := other.gray_stroke
			elseif other.color_space = Color_space_rgb then
				--rgb := other.rgb
				if rgb = Void then
					!!impl_rgb.make (other.rgb.lower, other.rgb.upper)
				end
				from index := rgb.lower until index > rgb.upper loop rgb.put (other.rgb.item (index), index); index := index + 1 end
				--rgb_stroke := other.rbg_stroke
				if rgb_stroke = Void then
					!!impl_rgb_stroke.make (other.rgb_stroke.lower, other.rgb_stroke.upper)
				end
				from index := rgb_stroke.lower until index > rgb_stroke.upper loop rgb_stroke.put (other.rgb_stroke.item (index), index); index := index + 1 end							
			end
			line_width := other.line_width
			line_cap := other.line_cap
			line_join := other.line_join
			miter_limit := other.miter_limit
			if other.line_dash_array /= Void then
				--line_dash_array := other.line_dash_array
				!!line_dash_array.make_from_array (other.line_dash_array)
			end
			line_dash_phase := other.line_dash_phase
			path_fill_heuristics := other.path_fill_heuristics			
		end
		

feature {NONE} -- Implementation
	
	impl_rgb : ARRAY[DOUBLE]
	
	impl_rgb_stroke : ARRAY[DOUBLE]
	
	impl_gray : DOUBLE
	
	impl_gray_stroke : DOUBLE

end -- class PDF_GRAPHICS_STATE	
		