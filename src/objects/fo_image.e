indexing
	description: 
	
		"Images"

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"


class FO_IMAGE

inherit
	FO_RENDERABLE
		redefine
			pre_render, is_equal, render_forth
		end
	
	FO_MARGIN_ABLE
		redefine	
			is_equal
		end

	FO_ALIGN_ABLE
		undefine
			is_equal
		end
		
	FO_BORDER_ABLE
		undefine
			is_equal
		end
		
create	

	make_from_png
	
feature {NONE} -- Initialization

	make_from_png (image_name: STRING; document : FO_DOCUMENT) is
			-- Make from PNG `image_name' on `document'.
		require
			image_name_not_void: image_name /= Void
			document_not_void: document /= Void
			document_is_open: document.is_open
		do
			make_borders_none
			create margins.make
			file_name := image_name
			document.writer.document.create_png_image (file_name)
			pdf_image := document.writer.document.last_image
			set_dpi (72)
			create align.make_left
		ensure
			file_name_set: file_name = image_name
			dpi_points: dpi = 72
		end
		
feature -- Access

	file_name : STRING
	
feature -- Measurement

	height : FO_MEASUREMENT
	
	width : FO_MEASUREMENT

	dpi : INTEGER
		
feature -- Comparison

feature -- Status report

	is_page_break_before : BOOLEAN
	
	is_keep_with_next : BOOLEAN
	
feature -- Status setting

feature -- Cursor movement

feature -- Element change

	set_dpi (resolution : INTEGER) is
		require
			resolution_positive: resolution > 0
		do
			dpi := resolution
			create height.points (pdf_image.height / dpi)
			create width.points (pdf_image.width / dpi)
		end
	
	set_width (a_width : FO_MEASUREMENT) is	
		local
			hw : FO_MEASUREMENT
		do
			width := a_width
			create hw.points (pdf_image.height / pdf_image.width)
			height := width * hw
			dpi := (width.as_inches / pdf_image.width).truncated_to_integer
		end
		
feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature {FO_DOCUMENT, FO_RENDERABLE} -- Basic operations

	render_start (document: FO_DOCUMENT; region: FO_RECTANGLE) is
		do
			pre_render (region)
			is_render_off := True
			is_render_inside := False
			if fits_in (region) then
				is_render_inside := True
				render_forth (document, region)
				is_render_inside := False
			else
				is_prerendered := False
				last_rendered_region := Void
				is_render_off := False
				is_render_inside := True
			end
		end

	render_forth (document:FO_DOCUMENT; region: FO_RECTANGLE) is
		local
			ratio : FO_MEASUREMENT
			x, y : FO_MEASUREMENT
			actual_region : FO_RECTANGLE
		do
			actual_region := margins.content_region (region)
			 is_prerendered := True
			if align /= Void then
				if align.is_center then
					x := actual_region.left + (actual_region.width - width) / create {FO_MEASUREMENT}.points (2)
					y := actual_region.top - height
				elseif align.is_left then
					x := actual_region.left
					y := actual_region.top - height
				elseif align.is_right then
					x := actual_region.right - width
					y := actual_region.top - height
				end
			else
			end
			if document.current_page.is_text_mode then
				document.current_page.end_text
			end
			document.current_page.gsave
			document.current_page.translate (x.as_points, y.as_points)
			document.current_page.scale (width.as_points, height.as_points)
			document.current_page.put_image (pdf_image)
			document.current_page.grestore
			create last_rendered_region.set (
				region.left,
				region.top - height - margins.top - margins.bottom,
				region.right,
				region.top)
			is_render_off := True
			is_render_inside := False
			last_region := region
		end
		
	pre_render (region : FO_RECTANGLE) is
		do
			last_region := region
			is_prerendered := True
		end
		
feature -- Obsolete

feature -- Comparison

	is_equal (other : like Current) : BOOLEAN is
		do
			Result := same_marginable (other) and then file_name.is_equal (other.file_name)
		end
		

feature -- Constants

feature {NONE} -- Implementation

	pdf_image : PDF_IMAGE
	
	fits_in (region : FO_RECTANGLE) : BOOLEAN is		
		do
			result := region.width > width + margins.left + margins.right 
				  and region.height >= height + margins.top + margins.bottom
		end
		
invariant

	pdf_image_not_void: pdf_image /= Void
	height_not_void: height /= Void
	width_not_void: width /= Void
	
end
