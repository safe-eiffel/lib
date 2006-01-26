indexing
	description: "Objects that can be rendered on a document."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FO_RENDERABLE

feature -- Access

	last_region : FO_RECTANGLE
			-- Last region of prerendering.

	last_rendered_region : FO_RECTANGLE
			-- Last rendered region.

	height : FO_MEASUREMENT is									
			-- Height of prerendered items.
		deferred
		ensure
			height_not_void: height /= Void
		end
		
feature -- Status report

	is_render_off : BOOLEAN

	is_render_inside : BOOLEAN
		
	is_renderable (region : FO_RECTANGLE) : BOOLEAN is	
		do
			Result := True
		end

	is_prerendered : BOOLEAN

	is_page_break_before : BOOLEAN is
			-- Must a page break occure before rendering?
		deferred
		end

	is_keep_with_next : BOOLEAN is		
			-- Must Current be kept on same page of next renderable?
		deferred
		end
		
					
feature -- Basic operations

	
	render_start (document : FO_DOCUMENT; region : FO_RECTANGLE) is
			-- Render Current on `document', stopping after rendering region.height
		require
			document_not_void: document /= Void
			document_is_open: document.is_open
			region_not_void: region /= Void
			region_width_positive: region.width.sign = 1
		deferred
		ensure
			last_region_set: last_region = region
			render_state: is_render_off xor is_render_inside
			is_prerendered_implies_last_rendered_region_not_void: is_prerendered implies last_rendered_region /= Void
			rendered_region_ok: (is_prerendered and not is_render_off) implies last_rendered_region.height <= region.height
		end

	render_forth (document : FO_DOCUMENT; region : FO_RECTANGLE) is
		require
			is_render_inside: is_render_inside
			document_not_void: document /= Void
			document_is_open: document.is_open
			region_not_void: region /= Void
			region_width_positive: region.width.sign = 1
						
		do	
		ensure
			last_region_set: last_region = region
			render_state: is_render_off xor is_render_inside
			last_rendered_region_not_void: last_rendered_region /= Void
			rendered_region_ok: last_rendered_region.height <= region.height
		end

	pre_render (region : FO_RECTANGLE) is				
		require
			region_not_void: region /= Void
			region_width_positive: region.width.sign = 1
			is_renderable: is_renderable (region)
		do
			last_region := region
			is_prerendered := True
		ensure
			last_region_set: last_region = region
		end

feature {NONE} -- Implementation

end -- class FO_RENDERABLE
