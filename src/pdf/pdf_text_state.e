indexing
	description: "PDF text states.  They are modified by text operations."
	author: "Paul G. Crismer"
	library: "ePDF"
	
class

	PDF_TEXT_STATE

inherit 
	PDF_NUMBER_OPERATORS
		undefine
			copy
		end

	ANY
		redefine
			copy
		end
		
creation
	make_text_state
	
feature {NONE} -- Initialization

	make_text_state is
			-- 
		do
			!!tm.set_identity
			!!tlm.set_identity
			line_x := 0
			line_y := 0
			text_x := 0
			text_y := 0
			character_spacing := 0
			word_spacing := 0
			horizontal_scaling := 100
			text_leading := 0
			font := Void
			font_size := 0
			text_render_mode := Text_render_stroke		
		ensure
			tm.is_identity
			tlm.is_identity
			line_x = 0
			line_y = 0
			text_x = 0
			character_spacing = 0
			word_spacing = 0
			horizontal_scaling = 100
			font = Void
			font_size = 0
			text_render_mode = Text_render_stroke
		end

feature -- Access - Text state

	tm : PDF_TRANSFORMATION_MATRIX
			-- text matrix; holds intermediate x and y values
			
	tlm : PDF_TRANSFORMATION_MATRIX
			-- text line matrix
			
	line_x : DOUBLE
			-- x origin of current line
	
	line_y : DOUBLE
			-- y origin of current line
			
	text_x : DOUBLE
			-- x origin of current text
			
	text_y : DOUBLE
			-- y origin of current text
			-- invariant: text_y = line_y

	character_spacing : DOUBLE
			-- Tc

	word_spacing : DOUBLE
			-- Tw

	horizontal_scaling : DOUBLE
			-- Th -  percentage : default = 100

	text_leading : DOUBLE
			-- Tl

	font : PDF_FONT
			-- Tf

	text_rise : DOUBLE
			-- Trise

	font_size : DOUBLE
			-- Tfs

	text_render_mode : INTEGER
			-- text_render mode
			
feature -- Status report - Text state
		
	is_text_render_mode_clipping : BOOLEAN is
			-- is current text_render mode a clipping one ?
		do
			Result := (text_render_mode >= Text_render_fill_n_clip and text_render_mode <= Text_render_clip)
		end

	is_forbidden_change_to_nonclipping_mode : BOOLEAN
	
	is_default_text_state : BOOLEAN is
			-- 
		do
			Result := (		tm.is_identity and
					tlm.is_identity and
					equal_numbers (line_x, 0) and
					equal_numbers (line_y, 0) and
					equal_numbers (text_x, 0)and
					equal_numbers (text_y, 0) and
					equal_numbers (character_spacing, 0) and
					equal_numbers (word_spacing, 0) and
					equal_numbers (horizontal_scaling, 100) and
					equal_numbers (text_leading, 0) and
					font = Void and
					equal_numbers (font_size, 0) and
					text_render_mode = Text_render_stroke		
			)
		end
		
feature -- Constants - Text state

	Text_render_fill : INTEGER is 0
	Text_render_stroke : INTEGER is 1
	Text_render_fill_then_stroke : INTEGER is 2
	Text_render_invisible : INTEGER is 3
	Text_render_fill_n_clip : INTEGER is 4
	Text_render_stroke_n_clip : INTEGER is 5
	Text_render_fill_then_stroke_n_clip : INTEGER is 6
	Text_render_clip : INTEGER is 7

feature -- Duplication

	copy (other : like Current) is
		do
			copy_text_state (other)
		end
		
feature {PDF_TEXT_STATE} -- Implementation

	copy_text_state (other : PDF_TEXT_STATE) is
			-- copy text_state
		require
			text_state_exists: other /= Void
		do
			tm.copy (other.tm)
			tlm.copy (other.tlm)
			line_x := other.line_x
			line_y := other.line_y
			text_x := other.text_x
			text_y := other.text_y
			character_spacing := other.character_spacing
			word_spacing := other.word_spacing
			horizontal_scaling := other.horizontal_scaling
			text_leading := other.text_leading
			font := other.font
			text_rise := other.text_rise
			font_size := other.font_size
			text_render_mode := other.text_render_mode
		end
		
invariant

	text_y_coordinate: text_y = line_y
	
end -- class PDF_TEXT_STATE