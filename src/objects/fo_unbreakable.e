indexing

	description:

		"Vertical sequence of objects that should be rendered on a single page."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class FO_UNBREAKABLE

inherit
	FO_RENDERABLE
		redefine
			pre_render
		end

create {FO_DOCUMENT}
	make

feature {NONE} -- Initialization

	make is
		do
			create {DS_LINKED_LIST[FO_RENDERABLE]}unbreakables.make
		end

feature -- Access

	unbreakables : DS_LIST[FO_RENDERABLE]
			-- Unbreakable parts.

feature -- Measurement

	height : FO_MEASUREMENT
			-- Height after pre-rendering.

feature -- Comparison

feature -- Status report

	is_page_break_before: BOOLEAN is
			-- Must a page break occur before rendering?
		do
			if unbreakables.count > 1 then
				Result := unbreakables.first.is_page_break_before
			end
		end

	is_keep_with_next: BOOLEAN is
		do
		ensure then
			definition: not Result
		end

feature {FO_DOCUMENT, FO_RENDERABLE} -- Basic operations

	render_start (document: FO_DOCUMENT; region: FO_RECTANGLE) is
		local
			c : DS_LIST_CURSOR[FO_RENDERABLE]
			new_region : FO_RECTANGLE
			all_after : BOOLEAN
		do
			from
				c := unbreakables.new_cursor
				c.start
				new_region := region
				all_after := true
				set_render_before
			until
				c.off
			loop
				set_render_inside
				c.item.render_start (document, new_region)
				new_region := new_region.shrinked_top (c.item.last_rendered_region.height)
				if last_rendered_region = Void then
					last_rendered_region := c.item.last_rendered_region
				else
					last_rendered_region := last_rendered_region.merged (c.item.last_rendered_region)
				end
				height := height + c.item.height
				c.item.post_render (document, c.item.last_rendered_region)
				all_after := all_after and c.item.is_render_after
				c.forth
			end
			last_region := region
			if is_render_inside and all_after then
				set_render_after
			end
		end

	pre_render (region: FO_RECTANGLE) is
		local
			c : DS_LIST_CURSOR[FO_RENDERABLE]
		do
			from
				c := unbreakables.new_cursor
				c.start
			until
				c.off
			loop
				c.item.pre_render (region)
				if height = Void then
					height := c.item.height
				else
					height := height + c.item.height
				end
				c.forth
			end
		end

end


