indexing
	description: "eCurses Hello World'"
	version: "$Revision$"
	date:	"$Date$"
	Author: "Paul G. Crismer"
class
	SLK_TEST	

inherit
	CURSES_APPLICATION


create
	make

feature
	make is
		local
			args : expanded ARGUMENTS
		do
			--| no_message_on_failure 
			--| catch (Developer_exception) --> not available in SmallEiffel
			-- initialize with soft label keys
			if args.argument_count < 1 then
				print_usage
			else
				if args.argument(1).is_equal ("55") then
					initialize_55
				elseif args.argument(1).is_equal ("44") then
					initialize_44
				elseif args.argument(1).is_equal ("444") then
					initialize_444
				elseif args.argument(1).is_equal ("444i") then
					initialize_444i
				else
					initialize_323
				end
				do_slk_test
			end
		rescue
			initialize
			standard_window.put_string ("This Curses library does not support the ")
			standard_window.put_string (args.argument(1).out)
			standard_window.put_string (" mode.%NNCurses : 323, 444, 444i.  PDCurses : 323, 44, 55%N")
			standard_window.put_string ("Press any key to exit")
			standard_window.read_character
			die (-1)
		end

	do_slk_test is
		local
			c : expanded CURSES_ATTRIBUTE_CONSTANTS
		do
			-- put labels
			soft_label_keys.set_label (1, "k1", soft_label_keys.left_justified)
			soft_label_keys.set_label (2, "k2", soft_label_keys.left_justified)
			soft_label_keys.set_label (3, "k3", soft_label_keys.left_justified)
			soft_label_keys.set_label (4, "k4", soft_label_keys.centered)
			soft_label_keys.set_label (5, "k5", soft_label_keys.centered)
			soft_label_keys.set_label (6, "k6", soft_label_keys.right_justified)
			soft_label_keys.set_label (7, "k7", soft_label_keys.right_justified)
			soft_label_keys.set_label (8, "k8", soft_label_keys.right_justified)
			soft_label_keys.refresh

			-- misc. initializations

			standard_window.disable_leave_cursor
			standard_window.enable_keypad
			standard_window.enable_metacharacters

			-- Title

			standard_window.set_attributes (c.attribute_bold)
			standard_window.move (0,0)
			standard_window.put_string ("Curses Soft Label Keys Test...");
			standard_window.set_attributes (c.attribute_normal)
			standard_window.move (1,0);
			standard_window.put_string ("Move cursor on menu entry, and press a space.");
			standard_window.refresh
			
			-- here comes true processing !

			show_menu
			from 
				quit := False
			until
				quit = True
			loop
				select_entry
				handle_selection
			end

			-- prepare to quit
			standard_window.clear_to_end
			soft_label_keys.clear
			standard_window.refresh
		end

	show_menu is
		do
			standard_window.move (menu_entry1,0)
			standard_window.put_string ("* Get Label%N%
							%* Clear%N%
							%* Restore%N%
						   	%* Set Attributes%N%
							%* Set Label%N%
							%* Quit%N");
			standard_window.move (menu_entry1,0)
			standard_window.refresh
		end

	select_entry is
		local
			k : expanded CURSES_KEY_CONSTANTS
			y : INTEGER
		do
			from
				standard_window.read_character
			until
				standard_window.last_character = ' '
			loop
				if standard_window.last_key = k.Key_up then
				  	if standard_window.cursor_y > 0 then
						standard_window.move (standard_window.cursor_y-1, 0)
					end
				elseif standard_window.last_key = k.key_down then
					if standard_window.cursor_y < standard_window.height - 1 then
						standard_window.move (standard_window.cursor_y+1, 0)
					end
				end
				standard_window.refresh
				y := standard_window.cursor_y
				standard_window.read_character
			end
		end

	handle_selection is
		local
			s : INTEGER
		do
			s := standard_window.cursor_y
			if s=menu_entry1 then
				get_label
			elseif s=menu_entry1 + 1 then
				soft_label_keys.clear
			elseif s=menu_entry1 + 2 then
				soft_label_keys.restore
			elseif s=menu_entry1 + 3 then
				set_attributes
			elseif s=menu_entry1 + 4 then
				set_label
			elseif s=menu_entry1 + 5 then
				quit := True
			end
			standard_window.move (s, 0)
			standard_window.refresh
		end

	set_attributes is
		do
			choose_label_number
			if last_label_number > 0 then
				choose_attribute
				soft_label_keys.set_attributes (last_attribute)
				soft_label_keys.set_label (last_label_number, soft_label_keys.item (last_label_number), soft_label_keys.centered)
				soft_label_keys.refresh
			end
		end

	set_label is
		do
			choose_label_number
			if last_label_number > 0 then
				standard_window.move (status_line, 0)
				standard_window.put_string ("Enter label :")
				standard_window.clear_to_end
				standard_window.refresh
				curses.enable_echo
				standard_window.read_line
				soft_label_keys.set_label (last_label_number, standard_window.last_string, soft_label_keys.centered)
				soft_label_keys.refresh
				curses.disable_echo
			end
		end

	get_label is
		do
			choose_label_number
			if last_label_number > 0 then
					standard_window.put_string ("Label is : ")
					standard_window.put_string (soft_label_keys.item (last_label_number))
					standard_window.refresh
			end				
		end

	
	menu_entry1 : INTEGER is 5

	quit : BOOLEAN

	status_line : INTEGER is
		do
			Result := standard_window.height-1
		end

	choose_label_number is
		local
			k : INTEGER
		do
			last_label_number := 0
			curses.enable_echo
			standard_window.move (status_line, 0)
			standard_window.put_string ("Enter key number : ")
			standard_window.clear_to_end
			standard_window.read_line
			if standard_window.last_string.is_integer then
				k := standard_window.last_string.to_integer
				standard_window.move (status_line, 0)
				standard_window.clear_to_end
				if k >=1 and k <= soft_label_keys.count then
					last_label_number := k
				else
					standard_window.put_string ("bad index : must be between 1 and ")
					standard_window.put_string (soft_label_keys.count.out)
					standard_window.put_string ("%N");
				end
			else
				standard_window.put_string ("Wrong label number")
			end	
			curses.disable_echo
		end

	last_label_number : INTEGER

	choose_attribute is
		local
			i : INTEGER
			k : expanded CURSES_KEY_CONSTANTS
		do
			standard_window.move (status_line, 0)
			standard_window.clear_to_end
			standard_window.put_string ("Choose an attribute. p = previous, n = next, SPACE = choose")
			from
				i := 1
				standard_window.read_character
			until
				standard_window.last_character = ' '
			loop
				standard_window.move (status_line, 0)
				standard_window.put_string (labels @ i)
				standard_window.clear_to_end
				standard_window.refresh
				standard_window.read_character
				if standard_window.last_character = 'p' then
					i := i - 1
				elseif standard_window.last_character = 'n' then
					i := i + 1
				end
				if i > labels.count then
				    i := 1
				elseif i < 1 then
				    i := labels.count
				end
			end
			last_attribute := attributes.item (i)	
		end


	last_attribute : INTEGER

	attributes : ARRAY[INTEGER] is
		local
			a : expanded CURSES_ATTRIBUTE_CONSTANTS
		once
			Result := <<a.attribute_blink, a.attribute_bold, a.attribute_dim,
					a.attribute_normal, a.attribute_protected, a.attribute_reverse,
				 	a.attribute_standout, a.attribute_underline >>
		end

	labels : ARRAY[STRING] is
		once
			Result := <<"blink", "bold", "dim", "normal", "protected", "reverse", "standout", "underline">>;
		end

	print_usage is
			-- print usage message
		do
			initialize
			standard_window.put_string (
				"Usage: slk_test <mode>%N%
				%       where mode is either 323, 44, 444, 444i or 55%N");
			standard_window.put_string ("Press a key to exit")
			standard_window.read_character
		end
		
end -- class BASIC_TEST
-------------------------------------------------------
-- Copyright 1999 Paul G. Crismer, Eric Fafchamps
-- Released under the Eiffel Forum free license
-------------------------------------------------------
-- $Log$
-- Revision 1.4  2007/11/15 10:01:55  pgcrism
-- ECMA 367 - create instead of creation
-- renamed entities whith reserved name (attribute, note)
--
-- Revision 1.3  2003/01/26 13:35:14  pgcrism
-- .xace files added; old sebuild.bat, ace and .se file have been deleted
--
-- Revision 1.2  2000/10/01 19:16:54  efa
-- Modifications/extensions for SmallEiffel portability
--
-- Revision 1.1.1.1  2000/01/07 11:33:35  pgcrism
-- Initial checkin
--
--
	
