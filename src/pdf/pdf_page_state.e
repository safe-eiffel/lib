indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_PAGE_STATE

inherit

	PDF_TEXT_STATE
		rename
			copy as text_copy
		end
		
	PDF_GRAPHICS_STATE
		rename
			copy as graphics_copy
		end

	ANY
		redefine
			copy
		select
			copy
		end
create
	make

feature -- Access

	make is
			-- 
		do
			make_text_state
			make_graphics_state
		end
		
feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

	copy (other : like Current) is
		do
			text_copy (other)
			graphics_copy (other)
		end
	
		
feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end -- class PDF_PAGE_STATE
