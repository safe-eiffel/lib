indexing
	description: "Rows containing multiple successive blocks."

	usage: ""
	quality: ""
	refactoring: ""

	status: "see notice at end of class";
	date: "$Date$";
	revision: "$Revision$";
	author: ""

class FO_ROW

inherit
	
	FO_RENDERABLE
		redefine
			pre_render, render_forth
		end

	FO_BORDER_ABLE
		redefine
			render_borders
		end
		
	KL_IMPORTED_ARRAY_ROUTINES
	
create

	make, make_widths
	
feature {NONE} -- Initialization

	make (n : INTEGER; desired_total_width : FO_MEASUREMENT) is
			-- Row of `desired_total_width' made of `n' blocks.
		local
		do
			make_borders_none
			initialize_blocks (n)
			initialize_widths (n, desired_total_width)
			width := desired_total_width
		ensure
			width_set: width = desired_total_width
			capacity_set: capacity = n
		end
		
	make_widths (n : INTEGER; desired_widths : ARRAY[FO_MEASUREMENT]) is
			-- Row of `n' blocks, with `desired_widths' for each block.
		require
			positive_n: n > 0
			desired_widths_not_void: desired_widths /= Void
			desired_widths_count_n: desired_widths.count = n
			desired_widths_no_void: not ANY_ARRAY_.has (desired_widths, Void)
		do
			make_borders_none
			initialize_blocks (n)
			block_widths := desired_widths
			width := sum_of_widths
		ensure
			capacity_set: capacity = n
		end
		
feature -- Access

	blocks : ARRAY [FO_BLOCK]
		-- Blocks.
		
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
			Result := blocks.capacity
		end
			
feature -- Comparison

feature -- Status report

	is_page_break_before : BOOLEAN is
		local
			i : INTEGER
		do
			from
				i := blocks.lower
			until
				i > blocks.upper
			loop
				Result := Result or blocks.item (i) /= Void and then blocks.item (i).is_page_break_before
				i := i + 1
			end
		end

	is_keep_with_next : BOOLEAN is
		local
			i : INTEGER
		do
			from
				i := blocks.lower
			until
				i > blocks.upper
			loop
				Result := Result or blocks.item (i) /= Void and then blocks.item (i).is_keep_with_next
				i := i + 1
			end
		end
		
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
				blocks.item (i).pre_render (current_region)
				if height = Void then
					height := blocks.item (i).height
				else
					height := height.max (blocks.item (i).height)
				end
				
				i := i + 1
			end
			precursor {FO_RENDERABLE} (region)
		end
		
	render_start (document: FO_DOCUMENT; region : FO_RECTANGLE) is
		local
			i : INTEGER
		do
			is_prerendered := False
			is_render_off := True
			is_render_inside := False
			last_rendered_region := Void
			compute_regions (region)
			from 
				i := blocks.lower
				is_render_off := True
			until i > blocks.upper
			loop
				blocks.item (i).render_start (document, render_regions.item (i))
				is_render_off := is_render_off and blocks.item (i).is_render_off
				is_render_inside := is_render_inside or blocks.item (i).is_render_inside
				if last_rendered_region = Void then
					last_rendered_region := blocks.item (i).last_rendered_region
				elseif blocks.item (i).is_prerendered then
					last_rendered_region := last_rendered_region.merged (blocks.item (i).last_rendered_region)
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
				i := blocks.lower
				is_render_off := True
			until i > blocks.upper
			loop
				if not blocks.item (i).is_render_off then
					blocks.item (i).render_forth (document, render_regions.item (i))
					is_render_off := is_render_off and blocks.item (i).is_render_off
					is_render_inside := is_render_inside and blocks.item (i).is_render_inside
					if last_rendered_region = Void then
						last_rendered_region := blocks.item (i).last_rendered_region
				elseif blocks.item (i).is_prerendered then
					last_rendered_region := last_rendered_region.merged (blocks.item (i).last_rendered_region)
					end
				end
				i := i + 1
			end
			last_region := region
		end

	render_borders (document : FO_DOCUMENT; region : FO_RECTANGLE) is
		local
			i : INTEGER
		do		
			compute_regions (region)
			from
				i := blocks.lower
			until
				i > blocks.upper
			loop
				blocks.item (i).render_borders (document, render_regions.item (i))
				i := i + 1
			end
		end
		
feature -- Obsolete

feature -- Inapplicable

feature -- Constants

feature {NONE} -- Implementation

	initialize_blocks (n : INTEGER) is
		do
			create blocks.make (1,n)
		end
		
--	initialize_margins (n : INTEGER) is
--		do
--			
--		end
		
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
		
invariant		
	
	blocks_not_void: blocks /= Void
	block_widths_not_void: block_widths /= Void
	block_widths_have_no_void: not ANY_ARRAY_.has (block_widths, Void)
	
end

