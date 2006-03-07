indexing
	description:

		"Objects that contain horizontally consecutive renderable items."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class FO_ROW

inherit

	FO_RENDERABLE
		redefine
			render_forth, pre_render, is_renderable, post_render
		end

	KL_IMPORTED_ARRAY_ROUTINES

create

	make, make_widths

feature {NONE} -- Initialization

	make (n : INTEGER; desired_total_width : FO_MEASUREMENT) is
			-- Row of `desired_total_width' made of `n' items.
		do
			initialize_items (n)
			initialize_widths (n, desired_total_width)
			width := desired_total_width
		ensure
			width_set: width = desired_total_width
			capacity_set: capacity = n
		end

	make_widths (n : INTEGER; desired_widths : ARRAY[FO_MEASUREMENT]) is
			-- Row of `n' items, with `desired_widths' for each block.
		require
			positive_n: n > 0
			desired_widths_not_void: desired_widths /= Void
			desired_widths_count_n: desired_widths.count = n
			desired_widths_no_void: not ANY_ARRAY_.has (desired_widths, Void)
		do
			initialize_items (n)
			block_widths := desired_widths
			width := sum_of_widths
		ensure
			capacity_set: capacity = n
		end

feature -- Access

	item (index: INTEGER) : FO_RENDERABLE is
			-- `index'-th borderable in row.
		require
			index_within_limits: index >= 1 and index <= capacity
		do
			Result := items.item (index)
		end

	block_widths : ARRAY [FO_MEASUREMENT]
		-- Desired widths.

	width : FO_MEASUREMENT
		-- Desired Width of Row.

	height : FO_MEASUREMENT
		-- Height of pre-rendered Row.

	last_regions : ARRAY[FO_RECTANGLE]
		-- Regions of last pre-render.

feature -- Measurement

	capacity : INTEGER is
		do
			Result := items.upper - items.lower + 1
		end

feature -- Comparison

feature -- Status report

	is_page_break_before : BOOLEAN is
		local
			i : INTEGER
		do
			from
				i := items.lower
			until
				i > items.upper
			loop
				Result := Result or items.item (i) /= Void and then items.item (i).is_page_break_before
				i := i + 1
			end
		end

	is_keep_with_next : BOOLEAN is
		local
			i : INTEGER
		do
			from
				i := items.lower
			until
				i > items.upper
			loop
				Result := Result or items.item (i) /= Void and then items.item (i).is_keep_with_next
				i := i + 1
			end
		end

	is_renderable (region: FO_RECTANGLE) : BOOLEAN is
		local
			i : INTEGER
		do
			compute_regions (region)
			from
				i := items.lower
				Result := True
			until
				not Result or else i > items.upper
			loop
				Result := Result and (items.item (i) /= Void and then items.item (i).is_renderable (render_regions.item (i)))
				i := i + 1
			end
		end

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	put (a_renderable : FO_RENDERABLE; index : INTEGER) is
			-- Put `a_renderable' at `index'-th position.
		require
			a_renderable_not_void: a_renderable /= Void
			index_within_limits: index >= 1 and index <= capacity
		do
			items.put (a_renderable, index)
		end

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature {FO_DOCUMENT, FO_BORDER_ABLE, FO_TABLE} -- Basic operations

	pre_render (region: FO_RECTANGLE) is
		local
			i : INTEGER
			left, right : FO_MEASUREMENT
			current_region : FO_RECTANGLE
		do
			create last_regions.make (1, capacity)
			--| foreach block
			--| calculate region
			--| pre-render
			from
				i := 1
				left := region.left
				right := left + block_widths.item (i)
			until
				i > capacity
			loop
				create current_region.set (left,
					region.bottom,
					right,
					region.top)
				last_regions.put (current_region, i)
				items.item (i).pre_render (current_region)
				if height = Void then
					height := items.item (i).height
				else
					height := height.max (items.item (i).height)
				end

				i := i + 1
			end
			precursor {FO_RENDERABLE}(region)
		end

	render_start (document: FO_DOCUMENT; region : FO_RECTANGLE) is
		local
			i : INTEGER
			current_item : FO_RENDERABLE
		do
			is_prerendered := False
			is_render_off := True
			is_render_inside := False
			last_rendered_region := Void
			compute_regions (region)
			from
				i := items.lower
				is_render_off := True
			until i > items.upper
			loop
				current_item := items.item (i)
				current_item.render_start (document, render_regions.item (i))
				is_render_off := is_render_off and items.item (i).is_render_off
				is_render_inside := is_render_inside or items.item (i).is_render_inside
				if last_rendered_region = Void then
					last_rendered_region := items.item (i).last_rendered_region
				elseif items.item (i).last_rendered_region /= Void then
					last_rendered_region := last_rendered_region.merged (items.item (i).last_rendered_region)
				end
				i := i + 1
			end
			last_region := region
		end

	render_forth (document : FO_DOCUMENT; region : FO_RECTANGLE) is
		local
			i : INTEGER
		do
			compute_regions (region)
			from
				last_rendered_region := Void
				i := items.lower
				is_render_off := True
			until i > items.upper
			loop
				if not items.item (i).is_render_off then
					items.item (i).render_forth (document, render_regions.item (i))
					is_render_off := is_render_off and items.item (i).is_render_off
					is_render_inside := is_render_inside and items.item (i).is_render_inside
					if last_rendered_region = Void then
						last_rendered_region := items.item (i).last_rendered_region
					elseif items.item (i).is_prerendered then
						last_rendered_region := last_rendered_region.merged (items.item (i).last_rendered_region)
					end
				end
				i := i + 1
			end
			last_region := region
		end

	post_render (document : FO_DOCUMENT; region : FO_RECTANGLE) is
		local
			i : INTEGER
		do
			compute_regions (region)
			from
				i := items.lower
			until
				i > items.upper
			loop
				items.item (i).post_render (document, render_regions.item (i))
				i := i + 1
			end
		end

feature -- Obsolete

feature -- Inapplicable

feature -- Constants

feature {NONE} -- Implementation

	initialize_items (n : INTEGER) is
		do
			create items.make (1,n)
		end

	initialize_widths (n : INTEGER; desired_width : FO_MEASUREMENT) is
		local
			proportion, current_width : FO_MEASUREMENT
			i : INTEGER
		do
			create block_widths.make (1,n)
			create proportion.points (n)
			current_width := desired_width / proportion
			from
				i := 1
			until
				i > n
			loop
				block_widths.put (current_width, i)
				i := i + 1
			end
		end

	sum_of_widths : FO_MEASUREMENT is
		local
			i : INTEGER
		do
			from
				i := block_widths.lower + 1
				Result := block_widths.item (block_widths.lower)
			until
				i > block_widths.upper
			loop
				Result := Result + block_widths.item (i)
				i := i + 1
			end
		end

	render_regions : ARRAY[FO_RECTANGLE]

	compute_regions (region : FO_RECTANGLE) is
			-- Compute `render_regions' based on the total `region'.
		require
			region_not_void: region /= Void
		local
			ratio : FO_MEASUREMENT
			i : INTEGER
			current_width : FO_MEASUREMENT
			current_region : FO_RECTANGLE
			left, right : FO_MEASUREMENT
			total_width : FO_MEASUREMENT
		do
			from
				create render_regions.make (1, capacity)
				create total_width.points (0)
				i := block_widths.lower
			until
				i > block_widths.upper
			loop
				ratio := width / block_widths.item (i)
				current_width := region.width / ratio
				left := region.left + total_width
				if i = block_widths.upper then
					right := region.right
				else
					right := left + current_width
				end
				create current_region.set (left,
					region.bottom,
					right,
					region.top)
				total_width := total_width + current_width
				render_regions.put (current_region, i)
				i := i + 1
			end
		end


	items : ARRAY [FO_RENDERABLE]
		-- items.

invariant

	items_not_void: items /= Void
	block_widths_not_void: block_widths /= Void
	block_widths_have_no_void: not ANY_ARRAY_.has (block_widths, Void)

end

