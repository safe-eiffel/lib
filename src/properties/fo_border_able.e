indexing
	description: "Objects that have borders."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FO_BORDER_ABLE
		
feature -- Initialization

	make_borders_none is
		do
			create border_top.make_none
			create border_bottom.make_none
			create border_left.make_none
			create border_right.make_none	
		end
		
feature -- Access
	
	border_top : FO_BORDER
			-- Top border.
					
	border_bottom : FO_BORDER
			-- Bottom border.
			
	border_left : FO_BORDER
			-- Left border.
			
	border_right : FO_BORDER
			-- Right border.
			
feature -- Status report

	is_borders_uniform : BOOLEAN is
			-- Do all borders have the same width/style/color?
		do
			if border_top.is_equal (border_bottom) and border_top.is_equal (border_left) and border_top.is_equal (border_right) then
				Result := True
			end
		end

feature -- Element change

	set_uniform_borders (a_border : like border_top) is
			-- Set all borders to `a_border'
		require
			a_border_not_void: a_border /= Void
		do
			set_border_bottom (a_border)
			set_border_left (a_border)
			set_border_right (a_border)
			set_border_top (a_border)
		ensure
			border_bottom_set: border_bottom = a_border
			border_left_set: border_left = a_border
			border_right_set: border_right = a_border
			border_top_set: border_top = a_border
			is_borders_uniform: is_borders_uniform
		end
		
	set_border_top (a_border : like border_top) is
			-- Set top border to `a_border'.
		require
			a_border_not_void: a_border /= Void
		do
			border_top := a_border
		ensure
			border_top_set: border_top = a_border
		end

	set_border_bottom (a_border : like border_bottom) is
			-- Set bottom border to `a_border'.
		require
			a_border_not_void: a_border /= Void
		do
			border_bottom := a_border
		ensure
			border_bottom_set: border_bottom = a_border
		end
		
	set_border_left (a_border : like border_left) is
			-- Set left border to `a_border'.
		require
			a_border_not_void: a_border /= Void
		do
			border_left := a_border
		ensure
			border_left_set: border_left = a_border
		end
		
	set_border_right (a_border : like border_right) is
			-- Set right border to `a_border'.
		require
			a_border_not_void: a_border /= Void
		do
			border_right := a_border
		ensure
			border_right_set: border_right = a_border
		end
		
feature -- Comparison

	same_borders (other : FO_BORDER_ABLE) : BOOLEAN is
			-- Has `other' the same borders as `Current'?
		require
			other_not_void: other /= Void
		do
			Result := border_left.is_equal (other.border_left) and
					  border_right.is_equal (other.border_right) and
					  border_top.is_equal (other.border_top) and
					  border_bottom.is_equal (other.border_bottom)
		end
		
feature -- Basic operations
	
	post_render (document: FO_DOCUMENT; region: FO_RECTANGLE) is
		do
			render_borders (document, region)
		end
		
feature {NONE} -- Implementation

	set_line_properties (page : PDF_PAGE; border : FO_BORDER) is
			-- Set line properties (style/color) of `border' into `page'.
		local
			rule : DS_PAIR[ARRAY[INTEGER],INTEGER]
		do
			if border.style = border.style_none then
				page.set_line_solid
			else
				rule := border.style_rule
				page.set_line_dash (rule.first, rule.second)
			end
			if border.color /= Void then
				page.set_rgb_color_stroke (border.color.red/255, border.color.green/255, border.color.blue/255)
			end
			if border.width /= Void then
				page.set_line_width (border.width.as_points)
			end
		end
		
	border_none : FO_BORDER is
		once
			create Result.make_none
		end

	render_borders (document : FO_DOCUMENT; region : FO_RECTANGLE) is
			-- Render borders in `document' into `region'.
		local
			page : PDF_PAGE
		do
			if region /= Void and then region.height.sign = 1 then
				page := document.current_page
				if page.is_text_mode then
					page.end_text
				end
				page.gsave
				if is_borders_uniform and not border_left.is_none then
					--| draw rectangle
					set_line_properties (page, border_left)
					page.move (0, 0)
					page.rectangle (region.left.as_points, region.bottom.as_points, region.width.as_points, region.height.as_points)
					page.stroke
				else
					
					--| draw borders.
					if border_left /= Void and then not border_left.is_none then
						set_line_properties (page, border_left)
						page.move (region.left.as_points, region.bottom.as_points)
						page.lineto (region.left.as_points, region.top.as_points)
						page.stroke
					end
					if border_bottom /= Void and then not border_bottom.is_none then
						set_line_properties (page, border_bottom)
						page.move (region.left.as_points, region.bottom.as_points)
						page.lineto (region.right.as_points, region.bottom.as_points)
						page.stroke
					end
					if border_right /= Void and then not border_right.is_none then
						set_line_properties (page, border_right)
						page.move (region.right.as_points, region.bottom.as_points)
						page.lineto (region.right.as_points, region.top.as_points)
						page.stroke
					end
					if border_top /= Void and then not border_top.is_none then
						set_line_properties (page, border_top)
						page.move (region.left.as_points, region.top.as_points)
						page.lineto (region.right.as_points, region.top.as_points)
						page.stroke
					end
				end
				page.grestore
			end
		end
		
invariant
	
	border_left_not_void: border_left /= Void
	border_right_not_void: border_right /= Void
	border_top_not_void: border_top /= Void
	border_bottom_not_void: border_bottom /= Void

end
