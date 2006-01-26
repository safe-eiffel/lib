indexing
	description: "Objects that..."

	usage: ""
	quality: ""
	refactoring: ""

	status: "see notice at end of class";
	date: "$Date$";
	revision: "$Revision$";
	author: ""

class FO_UNBREAKABLE

inherit
	FO_RENDERABLE
		redefine
			pre_render
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
	
feature -- Comparison

feature -- Status report

	is_page_break_before: BOOLEAN is
		do
			if unbreakables.count > 1 then
				Result := unbreakables.first.is_page_break_before
			end
		end
		
	is_keep_with_next: BOOLEAN is do  end
	
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

	render_start (document: FO_DOCUMENT; region: FO_RECTANGLE) is
		local
			c : DS_LIST_CURSOR[FO_RENDERABLE]
			new_region : FO_RECTANGLE
		do
			from
				c := unbreakables.new_cursor
				c.start
				new_region := region
				is_render_off := True
			until
				c.off
			loop
				c.item.render_start (document, new_region)
				new_region := new_region.shrinked_top (c.item.last_rendered_region.height)
				if last_rendered_region = Void then
					last_rendered_region := c.item.last_rendered_region
				else
					last_rendered_region := last_rendered_region.merged (c.item.last_rendered_region)
				end
				height := height + c.item.height
				is_render_off := is_render_off and c.item.is_render_off
				c.forth
			end
			last_region := region
			is_render_inside := not is_render_off
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
		
feature -- Obsolete

feature -- Inapplicable

feature -- Constants

feature {NONE} -- Implementation
		
invariant

	

end


