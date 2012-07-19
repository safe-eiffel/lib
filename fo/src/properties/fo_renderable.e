indexing

	description:

		"Objects that can be rendered on a document."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class
	FO_RENDERABLE

inherit
	FO_RENDER_STATE

feature -- Access

	last_region : FO_RECTANGLE
			-- Last region of prerendering.

	last_rendered_region : FO_RECTANGLE
			-- Last rendered region.

	height : FO_MEASUREMENT is
			-- Height of prerendered items.
		require
			is_prerendered: is_prerendered
		deferred
		ensure
			height_not_void: height /= Void
		end

feature -- Status report

	is_renderable (region : FO_RECTANGLE) : BOOLEAN is
			-- Can Current be rendered in `region'?
		do
			Result := True
		end

	is_prerendered : BOOLEAN
			-- Has the prerendering stage occured?

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
			last_rendered_region_not_void: last_rendered_region /= Void
			rendered_region_ok: last_rendered_region.height <= region.height
		end

	pre_render (region : FO_RECTANGLE) is
			-- Execute any action needed before rendering on `region'.
		require
			region_not_void: region /= Void
			region_width_positive: region.width.sign = 1
--			is_renderable: is_renderable (region)
		do
			last_region := region
			is_prerendered := True
		ensure
			last_region_set: last_region = region
			is_prerendered: is_prerendered
		end

	post_render (document : FO_DOCUMENT; region : FO_RECTANGLE) is
			-- Execute any action needed after a `render_start' or a `render_forth'.
		require
			document_not_void: document /= Void
			document_is_open: document.is_open
			region_not_void: region /= Void
			region_width_positive: region.width.sign >= 0
		do
		end

feature {NONE} -- Implementation

end
