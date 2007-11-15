indexing
	description: "eCurses Hello World'"
	version: "$Revision$"
	date:	"$Date$"
	Author: "Paul G. Crismer"
class
	HELLO_WORLD

inherit
	CURSES_APPLICATION

create
	make

feature
	make is
		do
			initialize
			standard_window.move (standard_window.height // 2, standard_window.width // 2)
			standard_window.put_string ("Hello, World")
			standard_window.move (standard_window.height-1, 0)
			standard_window.put_string ("Press any key....")
			standard_window.read_character
		end


end -- class HELLO_WORLD
-------------------------------------------------------
-- Copyright 1999 Paul G. Crismer, Eric Fafchamps
-- Released under the Eiffel Forum free license
-------------------------------------------------------
-- $Log$
-- Revision 1.3  2007/11/15 10:01:55  pgcrism
-- ECMA 367 - create instead of creation
-- renamed entities whith reserved name (attribute, note)
--
-- Revision 1.2  2003/01/26 13:35:14  pgcrism
-- .xace files added; old sebuild.bat, ace and .se file have been deleted
--
-- Revision 1.1.1.1  2000/01/07 11:33:32  pgcrism
-- Initial checkin
--
--
	
