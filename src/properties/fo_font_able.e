indexing
	description: "Objects that need to use a font."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	FO_FONT_ABLE
	
inherit
	ANY
		redefine
			is_equal
		end

feature -- Access

	font : FO_FONT
	
feature -- Element change

	set_font (new_font: FO_FONT) is
			-- Set `font' to `new_font'.
		do
			font := new_font
		ensure
			font_assigned: font = new_font
		end

feature -- Comparison

	is_equal (other : like Current) : BOOLEAN is
		do
			Result := same_fontable (other)
		end

	same_fontable (other : like Current) : BOOLEAN is		
		do
			Result := font.is_equal (other.font)
		end
		
invariant
	font_not_void: font /= Void
	
end -- class FO_FONT_ABLE
