indexing

	description: "PDF graphics operations."
	usage: "mix-in"
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

deferred class 

	PDF_GRAPHICS_STATE_OPERATORS

inherit
	PDF_GRAPHICS_STATE

feature -- Status Report

	
feature -- Element change

	set_line_width (w : DOUBLE) is
			-- set `line_width' to `w'
		require
			non_negative: w >= 0
		deferred
		ensure
			line_width = w
		end
		
	set_line_cap (c : INTEGER) is
			-- set `line_cap' to `c'
		require
			within_range: c = Butt_cap or c = Round_cap or c = Projecting_square_cap
		deferred
		ensure
			line_cap = c
		end
		
	set_line_join (j : INTEGER) is
			-- set `line_join' to `j'
		deferred
		ensure
			line_join = j
		end
		
	set_miter_limit (m : DOUBLE) is
			-- set `miter_limit' to `m'
		deferred
		ensure
			miter_limit = m
		end

	set_line_dash (array : ARRAY[INTEGER]; phase : INTEGER) is
			-- set line dash attributes
		deferred
		ensure
			array.is_equal (line_dash_array)
			line_dash_phase = phase
		end

	set_line_solid is
			-- set line solid (no dash)
		deferred
		ensure
			line_dash_array = Void
			line_dash_phase = 0
		end
		
	set_non_zero_winding_rule is
			-- set `path_fill_heuristics' to `Non_zero_winding_rule'
		do
			path_fill_heuristics := Non_zero_winding_rule
		ensure
			path_fill_heuristics = Non_zero_winding_rule		
		end
		
	set_even_odd_rule is
			-- set `path_fill_heuristics' to `Even_odd_rule'
		do
			path_fill_heuristics := Even_odd_rule
		ensure
			path_fill_heuristics = Even_odd_rule		
		end

feature -- Basic operations

	gsave is
			-- push graphics state
		require
			is_page_definition_mode
		deferred
		ensure
			save_level = old save_level + 1
		end
		
	grestore is
			-- pop graphics state
		require
			is_page_definition_mode
			save_level > 0
		deferred
		ensure
			save_level = old save_level - 1
		end

	set_gray (a_gray : DOUBLE) is
			-- set `a_gray' level color for non-stroking operations
		require
			black: a_gray >= 0.0
			white: a_gray <= 1.0
		deferred
		ensure
		end

	set_gray_stroke (a_gray : DOUBLE) is
			-- set `a_gray' level color for stroking operations
		require
			black: a_gray >= 0.0
			white: a_gray <= 1.0
		deferred
		ensure
			
		end
		
	set_rgb_color (r, g, b : DOUBLE) is
			-- set color to ('r','g','b') for non-stroking operations
		require
			r_level: 0.0 <= r and r <= 1.0
			g_level: 0.0 <= g and g <= 1.0
			b_level: 0.0 <= b and b <= 1.0			
		deferred
		ensure
		end
		
	set_rgb_color_stroke (r, g, b : DOUBLE) is
			-- set color to ('r','g','b') for stroking operations
		require
			r_level: 0.0 <= r and r <= 1.0
			g_level: 0.0 <= g and g <= 1.0
			b_level: 0.0 <= b and b <= 1.0			
		deferred
		ensure
		end

feature -- Status setting

	begin_text is
			-- begin text mode
		require
			page_definition: is_page_definition_mode
		deferred
		ensure
			text: is_text_mode
		end
		
	end_text is
			-- end text mode
		require
			text_mode: is_text_mode
		deferred
		ensure
			definition: is_page_definition_mode
		end

feature -- Coordinate space transformation

	translate (a_tx, a_ty : DOUBLE) is
			-- translate coordinate system by `a_tx' in the x direction and  `a_ty' in y direction
		deferred
		end

	scale (sx, sy : DOUBLE) is
			-- scale coordinate system : x axis by `sx', y axis by `sy' 
		deferred
		end
		
	rotate (theta : DOUBLE) is
			-- rotate coordinate system by `theta' radians 
		deferred
		end
	
	skew (alpha, beta : DOUBLE) is
			-- skew coordinate system by angle (radians) `alpha' from x axis and `beta' from y axis 
		deferred
		end

feature -- Path painting operators

	stroke is
			-- stroke current path
		require
			is_path_mode or else is_clipping_mode
		deferred
		ensure
			is_page_definition_mode
		end
	
	fill is
			-- fill current path
		require
			is_path_mode or else is_clipping_mode
		deferred
		ensure
			is_page_definition_mode
		end
		
	fill_then_stroke is
			-- fill first, then stroke current path
		require
			is_path_mode or else is_clipping_mode
		deferred
		ensure
			is_page_definition_mode
		end
		
	end_path is
			-- path painting no-operation
		require
			is_path_mode or else is_clipping_mode
		deferred
		ensure
			is_page_definition_mode
		end
		
feature -- Clipping operators

	clip is
			-- set current path as clipping region
			-- path must be closed before doing that
		require
			is_path_mode
		deferred
		end
		
feature -- Path construction operators

	rectangle (x, y, w, h : DOUBLE) is
			-- draw a rectangle starting at (x,y) with width `w' and height `h'
		require
			is_page_definition_mode or else is_path_mode
		deferred
		ensure
			current_x = x
			current_y = y + h
			is_path_mode
		end

	move (x, y : DOUBLE) is
			-- create at new subpath at (x,y)
		require
			is_page_definition_mode or else is_path_mode
		deferred
		ensure
			current_x = x
			current_y = y
			path_origin_x = x
			path_origin_y = y
			is_path_mode
		end
		
	lineto (x, y : DOUBLE) is
			-- draws a line in the current subpath from current position
			-- to (x,y).  (x,y) becomes the new current position
		require
			is_path_mode
		deferred
		ensure
			current_x = x
			current_y = y
		end
		
	close_path is
			-- close current subpath by drawing a straight line from current
			-- path position to subpath origin
		require
			is_path_mode
		deferred
		ensure
			current_x = path_origin_x
			current_y = path_origin_y
		end
		
	bezier_1 (cx1, cy1, cx2, cy2, px, py : DOUBLE) is
			-- append_string a cubic bezier curve to current subpath, with current position
			-- as starting point, (px, py) as end point, and control points
			-- (cx1, cy1) attached to starting point and (cx2,cy2) attached to end point
			-- (px, py) is the new current position.
			-- Formula: R(t) = (1 - t)^3 P0 + 3 t (1 - t)^2 P1 + 3 t^2 (1 - t) P2 + t^3 P3
			-- P0 = (current_x, current_y), P1=(cx1,cy1), P2=(cx2,cy2), P3=(px, py)
			-- Curve is drawn by varying t between 0 and 1; R(0) = P0; R(1) = P3
		require
			is_path_mode
		deferred
		ensure
			current_x = px
			current_y = py
		end
		
	bezier_2 (cx2, cy2, px, py : DOUBLE) is
			-- append_string a bezier curve to current subpath, with current position
			-- as starting point, (px, py) as end point, and control point
			-- (cx2,cy2) attached to end point. (px, py) is the new current position
		require
			is_path_mode
		deferred
		ensure
			current_x = px
			current_y = py
		end
		
	bezier_3 (cx1, cy1, px, py : DOUBLE) is
			-- append_string a bezier curve to current subpath, with current position
			-- as starting point, (px, py) as end point, and control point
			-- (cx1,cy1) attached to starting point. (px, py) is the new current position
		require
			is_path_mode
		deferred
		ensure
			current_x = px
			current_y = py
		end

	circle (x, y, r : DOUBLE) is
			-- circle of radius `r' centered at (`x',`y')
			-- drawn counter clockwise
		require
			positive_radius: r > 0
		do
		    --| emulate by drawing 4 quadrants
		    move (x + r, y)
		    bezier_1 (x + r, y + r*Bezier_arc_magic, x + r*Bezier_arc_magic, y + r, x, y + r)
		    bezier_1 (x - r*Bezier_arc_magic, y + r, x - r, y + r*Bezier_arc_magic, x - r, y)
		    bezier_1 (x - r, y - r*Bezier_arc_magic, x - r*Bezier_arc_magic, y - r, x, y - r)
		    bezier_1 (x + r*Bezier_arc_magic, y - r, x + r, y - r*Bezier_arc_magic, x + r, y)
			close_path
		ensure
			updated_x: current_x = x + r
			unchanged_y: current_y = y
			path_mode: is_path_mode
		end
		
	circle_2 (x, y, r : DOUBLE) is
			-- circle drawn clockwise
		require
			positive_radius:	r > 0
		do
		    --| emulate by drawing 4 quadrants
		    move (x + r, y)
		    bezier_1 (x + r, y - r*Bezier_arc_magic, x + r*Bezier_arc_magic, y - r, x, y - r)
		    bezier_1 (x - r*Bezier_arc_magic, y - r, x - r, y - r*Bezier_arc_magic, x - r, y)
		    bezier_1 (x - r, y + r*Bezier_arc_magic, x - r*Bezier_arc_magic, y + r, x, y + r)
		    bezier_1 (x + r*Bezier_arc_magic, y + r, x + r, y + r*Bezier_arc_magic, x + r, y)
			close_path		
		ensure
			updated_x: current_x = x + r
			unchanged_y: current_y = y
			path_mode: is_path_mode
		end
		
	ellipse (x, y, width, height: DOUBLE) is
			-- draw an ellipse within a rectangle whose lower left corner is at (`x',`y')
			-- and whose size is `width', `height' logical units
		require
		
		local
			bezier_ellipse_magic : DOUBLE
			offset_x, offset_y : DOUBLE
			centre_x, centre_y : DOUBLE
		do
			bezier_ellipse_magic := 0.2761423749154 --| 2/3 * (sqrt (2) - 1)
			centre_x := x + width/2
			centre_y := y + height/2
			offset_x := width * bezier_ellipse_magic
			offset_y := height * bezier_ellipse_magic
			move (x, centre_y)
			bezier_1 (x, centre_y + offset_y, centre_x - offset_x, y + height, centre_x, y+height)
			bezier_1 (centre_x + offset_x, y+height, x + width, centre_y + offset_y, x + width, centre_y)
			bezier_1 (x +width, centre_y - offset_y, centre_x + offset_x, y, centre_x, y)
			bezier_1 (centre_x - offset_x, y, x, centre_y - offset_y,x, centre_y)
			close_path
		ensure
			unchanged_x: equal_numbers ( current_x, x)
			changed_y: equal_numbers ( current_y, y + height / 2)
			path_mode: is_path_mode
		end
		
	pie (x, y, r, alpha, beta : DOUBLE) is
			-- draw piece of pie with origin (`x',`y'), radius `r' and
			-- going from `alpha' to `beta' radians 
			-- clockwise: alpha > beta; counterclockwise: beta > alpha 
		require
			positive_radius: r > 0
			alpha_bounds :   alpha.abs <= (2 * math.Pi)
			beta_bounds:     beta.abs <= (2 * math.Pi)
			not_more_than_a_circle: (beta - alpha).abs <= (2 * math.Pi)
		do
			arc (x, y, r, alpha, beta)
			lineto (x,y)
			close_path
		ensure
			new_current_x: equal_numbers (current_x, (x + r * math.cosine (alpha)))
			new_current_y: equal_numbers (current_y, (y + r * math.sine (alpha)))
			path_mode: is_path_mode
		end
		
	arc (x, y, r, alpha, beta : DOUBLE) is
			-- clockwise if alpha > beta
			-- counterclockwise if beta > alpha
		require
			positive_radius: r > 0
			alpha_bounds: 	 alpha.abs <= (2 * math.Pi)
			beta_bounds:	 beta.abs <= (2 * math.Pi)
			not_more_than_a_circle: (beta - alpha).abs <= (2 * math.Pi)
		local
			begin_x, begin_y, increment, angle : DOUBLE
		do
			begin_x := x + r * math.cosine (alpha)
			begin_y := y + r * math.sine (alpha)
			if alpha > beta then
				--| clockwise
				increment := -math.Pi/2
			else
				--| counterclockwise
				increment := math.Pi / 2
			end
			move (begin_x, begin_y)
			--| draw it quadrant by quadrant
			from
				angle := alpha
			until
				(beta - angle).abs <= math.Pi / 2
			loop
				arc_1_quadrant (x, y, r, angle, angle + increment)
				angle := angle + increment
			end
			--| last quadrant
			arc_1_quadrant (x, y, r, angle, beta)
		ensure
			new_current_x: equal_numbers (current_x, (x + r * math.cosine (beta)))
			new_current_y: equal_numbers (current_y, (y + r * math.sine (beta)))
			path_mode: is_path_mode
		end

feature -- Math constants
		
	math : EPDF_MATH is
			-- portable math constants and operations
		once
			!!Result
		end
		
feature {NONE} -- Implementation

	arc_1_quadrant (x, y, r, alpha, beta : DOUBLE) is
			-- arc for 1 quadrant
		require
			arc_angle_not_zero: (beta - alpha).abs >= 0
			arc_angle_less_quadrant: (beta - alpha).abs < (math.pi / 2 ) + 1.e-10
		local
			bacpr :  DOUBLE
			sin_alpha, sin_beta, cos_alpha, cos_beta : DOUBLE
		do
			bacpr := Bezier_arc_control_point_ratio (alpha, beta)
			sin_alpha := math.sine (alpha)
			sin_beta := math.sine (beta)
			cos_alpha := math.cosine (alpha)
			cos_beta := math.cosine (beta)
			bezier_1(
				x + r * (cos_alpha - bacpr * sin_alpha),
			 	y + r * (sin_alpha + bacpr * cos_alpha),
				x + r * (cos_beta + bacpr * sin_beta),	
				y + r * (sin_beta - bacpr * cos_beta),
				x + r * cos_beta,				
				y + r * sin_beta)
		end
		
	Bezier_arc_magic : DOUBLE is 0.552284749
		-- Bezier_arc_magic = Bezier_arc_control_point_ratio (0, math.Pi/2)
	
	Bezier_arc_control_point_ratio (alpha, beta : DOUBLE) : DOUBLE is
			-- 
		do
			Result := 4/3 * (1 - math.cosine((beta - alpha)/2)) / math.sine((beta - alpha)/2)
		end
		
end -- class PDF_GRAPHICS_STATE_OPERATORS
