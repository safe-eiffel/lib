indexing
	description: "Graphviz color"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	GRAPHVIZ_COLOR

inherit
	ANY
		rename
		export
		undefine
		redefine
		select
		end

creation
	make_graphviz, make_rgb

feature -- Initialization
		
	make_rgb (ar, ag, ab : DOUBLE) is
			-- 
		do
			r := ar
			g := ag
			b := ab
		end

	make_graphviz (n : STRING; ar, ag, ab : DOUBLE) is
			-- 
		require
			n /= Void
		do
			name := n
			make_rgb (ar, ag, ab)
		end
		
feature -- Access

	name : STRING
	
	r, g, b : DOUBLE
	
feature -- Basic operations

	draw_pdf (p : PDF_PAGE) is
		do
			p.set_rgb_color_stroke (r, g, b)	
		end
		
feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end -- class GRAPHVIZ_COLOR
--
-- Copyright: 2001, Paul G. Crismer, <pgcrism@planetinternet.be>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
