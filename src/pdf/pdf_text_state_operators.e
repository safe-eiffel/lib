indexing

	description: "PDF text operations."
	usage: "mix-in"
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

deferred class 

	PDF_TEXT_STATE_OPERATORS

inherit

	PDF_TEXT_STATE
	
feature -- Status report

	is_text_mode : BOOLEAN is
			-- 
		deferred
		end
		
	string_width (s : STRING) : DOUBLE is
			-- width of 's' in current text state
		require
			font_set: font /= Void
			font_size_gt0: font_size > 0
		deferred
		end
		
feature -- Status setting

	set_text_render_mode (a_mode : INTEGER) is
			-- set `text_render_mode' for text operations
			-- cannot change to non-clipping mode if in a clipping mode
		require
			good_mode: a_mode >= Text_Render_fill and a_mode <= Text_Render_clip
			clipping_constraint:  is_forbidden_change_to_nonclipping_mode implies
					     (a_mode >= Text_Render_Fill_n_clip and a_mode <= Text_Render_clip)
		deferred
		ensure
			mode_set: text_render_mode = a_mode
			clipping_rule: (is_text_render_mode_clipping and then is_text_mode) implies is_forbidden_change_to_nonclipping_mode
		end

	move_text_origin (x, y : DOUBLE) is
			-- begin a new line, with an (x,y) offset from the previous one
		require
			is_text_mode
		deferred
		ensure
			equal_numbers (line_x, old line_x + x)
			equal_numbers (line_y, old line_y + y)
			equal_numbers (text_x, line_x)
			equal_numbers (text_y, line_y)
		end

	put_string (s : STRING) is
			-- 
		require
			is_text_mode
		deferred
		ensure
			equal_numbers (text_x, old text_x + string_width (s))
			equal_numbers (text_y, line_y)
		end

	put_new_line is
			-- moves current position to next line (line_y = old line_y - leading)
		deferred
		ensure
			x: equal_numbers (line_x, old line_x) and equal_numbers (line_x, text_x) 
			y: equal_numbers (line_y, old line_y - text_leading) and equal_numbers (text_y, line_y)
		end
	
	put_new_line_string (s : STRING) is
			-- 
		require
			is_text_mode
		deferred
		ensure
			lx: equal_numbers (line_x, old line_x)
			tx: equal_numbers (text_x, line_x + string_width (s))
			y:  equal_numbers (line_y, old line_y - text_leading) and equal_numbers (text_y, line_y)
		end

	set_font (a_font : PDF_FONT; a_size : DOUBLE) is
			-- 
		deferred
		ensure
			font = a_font
			equal_numbers (font_size, a_size)
		end
		
	set_text_leading (l : DOUBLE) is
			-- set the space between lines
			-- it is advised to set `text_leading' >= `font_size'
		deferred
		ensure
			equal_numbers (text_leading, l)
		end

	set_character_spacing (s : DOUBLE) is
			-- set `character_spacing' to `s'
		deferred
		ensure
			equal_numbers (character_spacing, s)
		end
		
	set_word_spacing (w : DOUBLE) is
			-- blanks between words are padded by `word_spacing' units
		deferred
		ensure
			equal_numbers (word_spacing, w)
		end
		
	set_horizontal_scaling (s : DOUBLE) is
			-- scale/stretch by `horizontal_scaling' percent.  100 = normal size.
		deferred
		ensure
			equal_numbers (horizontal_scaling, s)
		end
	
	set_text_rise (r : DOUBLE) is
			-- rise text `text_rise' units above(+)/below(-) text baseline (line_y)
		deferred
		ensure
			equal_numbers (text_rise, r)
		end

	set_text_matrix (a_text_matrix : PDF_TRANSFORMATION_MATRIX) is
			-- set text transformation matrix `tm' to `a_text_matrix'
		require
			exists: a_text_matrix /= Void
		deferred
		ensure
			tm_set: tm.is_equal (a_text_matrix)
		end
		
end -- class PDF_TEXT_STATE_OPERATORS
