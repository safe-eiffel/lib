indexing
	description: "Objects that should be rendered on a single page"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	FO_UNBREAKABLE

inherit
	FO_RENDERABLE
		redefine
			pre_render,
			render_forth
		end

create
	make

feature {NONE} -- Initialization

	make is
		do
			create {DS_LINKED_LIST[FO_RENDERABLE]}unbreakables.make
		end

feature -- Access

	unbreakables : DS_LIST[FO_RENDERABLE]

feature -- Measurement

	height : FO_MEASUREMENT

feature -- Status report

	is_keep_with_next : BOOLEAN is
		do
			Result := False
		end

	is_page_break_before : BOOLEAN

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	pre_render (region: FO_RECTANGLE) is
		local
			cursor : DS_LIST_CURSOR[FO_RENDERABLE]
		do
			if not equal (region, last_region) then
				from
					cursor := unbreakables.new_cursor
					cursor.start
					create height.make_zero
				until
					cursor.after
				loop
					cursor.item.pre_render (region)
					height := height + cursor.item.height
					cursor.forth
				end
			end
			Precursor (region)
		end

	render_start (document: FO_DOCUMENT; region: FO_RECTANGLE) is
		do
			set_render_before
			render_cursor := unbreakables.new_cursor
			render_cursor.start
			render_forth (document, region)
		end

	render_forth (document: FO_DOCUMENT; region: FO_RECTANGLE) is
		local
			renderable : FO_RENDERABLE
		do
			if not render_cursor.off then
				from
					available_region := region.twin
					render_cursor.item.pre_render (available_region)
				until
					render_cursor.off or else render_cursor.item.height > available_region.height
				loop
					from
						renderable := render_cursor.item
						renderable.render_start (document, available_region)
						update_render_regions (renderable)
						if renderable.last_rendered_region /= Void then
							renderable.post_render (document, renderable.last_rendered_region)
						end
					until
						renderable.is_render_after or else renderable.height.is_zero
					loop
						renderable.render_forth (document, available_region)
						if renderable.last_rendered_region /= Void then
							renderable.post_render (document, renderable.last_rendered_region)
						end
						update_render_regions (renderable)
					end
					render_cursor.forth
					if not render_cursor.off then
						renderable := render_cursor.item
						renderable.pre_render (available_region)
					end
				end
			end
			if render_cursor.off then
				set_render_after
			end
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	render_cursor : DS_LIST_CURSOR[FO_RENDERABLE]

	available_region : FO_RECTANGLE

	update_render_regions (renderable : FO_RENDERABLE) is
		do
			if renderable.last_rendered_region /= Void then
				available_region := available_region.shrinked_top (renderable.last_rendered_region.height)
			end
			if last_rendered_region /= Void then
				last_rendered_region := last_rendered_region.merged (renderable.last_rendered_region)
			else
				last_rendered_region := renderable.last_rendered_region
			end
		end

invariant
	invariant_clause: True -- Your invariant here

end
