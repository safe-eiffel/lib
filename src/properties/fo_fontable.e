indexing

	description: 
	
		"Objects that need to use a font."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_FONTABLE
	
inherit
	ANY
		redefine
			is_equal
		end

feature -- Access

	font : FO_FONT
	
feature -- Measurement

	character_spacing: FO_MEASUREMENT
			-- Space between characters.

	word_spacing: FO_MEASUREMENT
			-- Space between words.

	stretch: FO_MEASUREMENT
			-- Streching factor. 100 = no stretch; 50 = narrow; 150 = wide.
	
feature -- Element change

	set_font (new_font: FO_FONT) is
			-- Set `font' to `new_font'.
		do
			font := new_font
		ensure
			font_assigned: font = new_font
		end


	set_stretch (a_stretch: FO_MEASUREMENT) is
			-- Set `stretch' to `a_stretch'.
		require
			stretch_is_positive: a_stretch.sign = 1
		do
			stretch := a_stretch
		ensure
			stretch_assigned: stretch = a_stretch
		end

	set_character_spacing (a_character_spacing: like character_spacing) is
			-- Set `character_spacing' to `a_character_spacing'.
		require
			a_character_spacing_not_void: a_character_spacing /= Void
		do
			character_spacing := a_character_spacing
		ensure
			character_spacing_assigned: character_spacing = a_character_spacing
		end

	set_word_spacing (a_word_spacing: like word_spacing) is
			-- Set `word_spacing' to `a_word_spacing'.
		require
			a_word_spacing_not_void: a_word_spacing /= Void
		do
			word_spacing := a_word_spacing
		ensure
			word_spacing_assigned: word_spacing = a_word_spacing
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
	
end
