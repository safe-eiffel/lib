indexing
	description: "SmallEiffel compilation test for all exported ecurses features (only for compile, do not execute this system!)"
	version: "$Revision$"
	date:	"$Date$"
	Author: "Paul G. Crismer, Eric Fafchamps"
class
	COMPILE_TEST

inherit
	CURSES_APPLICATION

creation
	make

feature
	make is
		do
			t_curses_application
			t_curses_error_handling
			t_curses_pad
			t_curses_panel
			t_curses_soft_label_keys
			t_curses_system
			t_curses_window
		end

feature -- tests

	t_curses_application is
		do
			initialize
			initialize_323
			initialize_44
			initialize_444
			initialize_444i
			initialize_55
			b := initialized

		end	
			
	t_curses_error_handling is
		do
			i := curses_error_value
			i := curses_ok_value
			disable_exceptions
			enable_exceptions
			b := exceptions_enabled
			i := last_error
		end	

	t_curses_pad is
		local
			pad: CURSES_PAD
		do
			!!pad.make_pad(i,i)
			!!pad.make_subpad (pad,i,i,i,i)
			pad.refresh
			pad.memory_refresh
			pad.set_view (i,i,i,i,i,i)
			i := pad.view_upper_y
			i := pad.view_upper_x
			i := pad.view_lower_y
			i := pad.view_lower_x
			i := pad.first_y
			i := pad.first_x
			i := pad.height
			i := pad.width
			i := pad.origin_y
			i := pad.origin_x
		end

	t_curses_panel is
		local
			panel: CURSES_PANEL
		do
			!!panel.make (i,i,i,i)
			!!panel.make_standard_panel
			b := panel.panel_exists
			panel.close
			panel.hide
			panel.show
			panel.bring_to_front
			panel.send_to_back
			b := panel.hidden
			panel.move_window (i,i)
			panel.refresh
			panel.memory_refresh
			panel.redraw
			panel.refresh
			panel.memory_refresh
			panel.redraw
		end	

	t_curses_soft_label_keys is
		local
			slk: CURSES_SOFT_LABEL_KEYS
		do
			!!slk.make_323
			!!slk.make_44
			!!slk.make_444i
			!!slk.make_55
			i := slk.count
			s := slk.item (i)
			i := slk.current_attributes
			i := slk.left_justified
			i := slk.centered
			i := slk.right_justified
			slk.set_label (i, s, i)
			slk.refresh
			slk.clear
			slk.restore
			slk.set_attributes (i)
			slk.enable_attributes (i)
			slk.disable_attributes (i)				
		end

	t_curses_system is
		do
			i := curses.maximum_height
			i := curses.maximum_width
			i := curses.tabulation_size
			i := curses.maximum_colors
			i := curses.maximum_color_pairs
			b := curses.is_color_used
			b := curses.has_colors
			curses.enable_character_reading_mode
			curses.enable_line_reading_mode
			curses.enable_echo
			curses.disable_echo
			curses.enable_raw_reading_mode
			curses.disable_raw_reading_mode
			curses.enable_flush_input_on_interrupt
			curses.disable_flush_input_on_interrupt
			curses.enable_cr_nl_translation
			curses.disable_cr_nl_translation
			curses.use_colors
			curses.define_default_color_pairs
			curses.define_color_pair (i,i,i)
			curses.escape_to_shell
			curses.resume_from_shell
			curses.save_terminal_state
			curses.restore_terminal_state
			curses.set_cursor_visibility (i)
			curses.sleep (i)
			s := curses.printable_representation (i)
			s := curses.key_name (i)
		end

	t_curses_window is
		local
			w: CURSES_WINDOW
		do
			!!w.make_from_pointer (p)
			!!w.make (i,i,i,i)
			!!w.make_subwindow_absolute (w,i,i,i,i)
			!!w.make_subwindow_relative (w,i,i,i,i)
			w.on_create
			w.on_close
			w.close
			w.move_window (i,i)
			w.refresh
			w.memory_refresh
			w.do_update
			w.touch (i,i)
			w.untouch (i,i)
			b := w.is_line_touched (i)
			b := w.is_touched
			b := w.keypad_enabled
			b := w.leave_cursor_enabled
			b := w.metacharacters_enabled
			b := w.auto_update
			w.enable_keypad
			w.disable_keypad
			w.enable_leave_cursor
			w.disable_leave_cursor
			w.enable_metacharacters
			w.disable_metacharacters
			w.enable_auto_update
			w.disable_auto_update
			w.enable_blocking_input
			w.disable_blocking_input
			w.set_blocking_input_timeout (i)
			w.move (i,i)
			i := w.cursor_x
			i := w.cursor_y
			b := w.is_color_used
			w.define_color_pair (i,i,i)
			w.use_color_pair (i)
			i := w.width
			i := w.height
			i := w.origin_x
			i := w.origin_y
			w := w.parent_window
			i := w.subwindows.count
			c := w.last_character
			i := w.last_key
			s := w.last_string
			b := w.is_last_key_special	
			b := w.exists		
			b := w.closed
			i := w.current_attributes
			i := w.current_attribute
			i := w.current_background
			c := w.current_background_character
			i := w.current_background_attributes
			w.set_current_background (i)
			w.apply_current_background
			w.set_background (c,i,i)
			w.put_character (c)
			w.put (i)
			w.put_string (s)
			w.put_n_string (s,i)
			w.insert_character (c)
			w.insert (i)
			w.insert_string (s)
			w.insert_n_string (s,i)
			w.delete_character
			w.delete_line
			w.insert_line
			w.insert_multiple_lines (i)
			w.delete_multiple_lines (i)
			w.clear_to_end
			w.clear
			w.clear_and_redraw_screen
			w.clear_to_bottom
			w.set_scroll_region (i,i)
			w.enable_scrolling
			w.disable_scrolling
			b := w.scrolling_enabled
			w.scroll_up (i)
			w.scroll_down (i)
			w.read_character
			w.read_line
			i := w.current_color_pair
			i := w.foreground_color
			i := w.background_color
			w.set_standard_border
			w.set_border (i,i,i,i,i,i,i,i)
			w.draw_h_line (i,i)
			w.draw_v_line (i,i)
			w.enable_attribute (i)
			w.disable_attribute (i)
			w.set_attribute (i)
			w.set_attributes (i)
			w.change_n_attribute_and_color (i,i,i)
			w.beep
			w.flash			
		end
	

feature -- Dummies

	c: CHARACTER
	i: INTEGER
	b: BOOLEAN	
	p: POINTER
	s: STRING

	

end -- class COMPILE_TEST
-------------------------------------------------------
-- Copyright 1999 Paul G. Crismer, Eric Fafchamps
-- Released under the Eiffel Forum free license
-------------------------------------------------------
-- $Log$
-- Revision 1.1  2000/10/01 19:16:54  efa
-- Modifications/extensions for SmallEiffel portability
--
	
