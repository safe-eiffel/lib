indexing
	description: 	"Curses panel API";
    	cluster: 	"ecurses, spec"
    	interface: 	"mixin"
    	status: 	"See notice at do end of class"
    	date: 		"$Date$"
    	revision: 	"$Revision$"
    	author: 	"Paul G. Crismer, Eric Fafchamps"
class 
	CURSES_PANEL_API

inherit
	
	RCURSES_PANEL_API_IDS
		export
			{NONE} all
		end

	RCURSES_CLIENT_API
		export
			{NONE} all
		end

feature

	panel_window (p : POINTER) : POINTER is
    	local
    		an_identifier: STRING
    	do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_panel_window, <<an_identifier>>)
			Result := pointer_from_identifier (remote_curses.last_results.item (1))
		end	

	update_panels is
    	do
			remote_curses.send_request (Id_update_panels, <<>>)
		end	

	hide_panel (p : POINTER) : INTEGER is
    	local
    		an_identifier: STRING
    	do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_hide_panel, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	show_panel (p : POINTER) : INTEGER is
    	local
    		an_identifier: STRING
    	do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_show_panel, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	del_panel (p : POINTER) : INTEGER is
    	local
    		an_identifier: STRING
    	do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_del_panel, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer
			release_identifier (p)
		end	

	top_panel (p : POINTER) : INTEGER is
    	local
    		an_identifier: STRING
    	do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_top_panel, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	bottom_panel (p : POINTER) : INTEGER is
    	local
    		an_identifier: STRING
    	do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_bottom_panel, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	new_panel (w : POINTER) : POINTER is
    	local
    		an_identifier: STRING
    	do
			an_identifier := identifier_from_pointer (w)
			remote_curses.send_request (Id_new_panel, <<an_identifier>>)
			Result := new_pointer_for_identifier (remote_curses.last_results.item (1))
		end	

	panel_above (p: POINTER) : POINTER is
    	local	
    		an_identifier: STRING
    	do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_panel_above, <<an_identifier>>)
			Result := pointer_from_identifier (remote_curses.last_results.item (1))
		end	

	panel_below (p: POINTER) : POINTER is
    	local
    		an_identifier: STRING
    	do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_panel_below, <<an_identifier>>)
			Result := pointer_from_identifier (remote_curses.last_results.item (1))
		end	

	set_panel_userptr(p, u : POINTER) : INTEGER is
    	do
			print ("Not supported in curses remote access")
		end	

	panel_userptr(p : POINTER) : POINTER is 
    	do
			print ("Not supported in curses remote access")
		end	

	move_panel (p : POINTER; y, x : INTEGER) : INTEGER is
    	local
    		an_identifier: STRING
    	do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_move_panel, <<an_identifier, y, x>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	replace_panel (p, w : POINTER) : INTEGER is
    	local
    		identifier_1: STRING
			identifier_2:STRING
    	do
			identifier_1 := identifier_from_pointer (p)
			identifier_2 := identifier_from_pointer (w)
			remote_curses.send_request (Id_replace_panel, <<identifier_1, identifier_2>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

	panel_hidden (p : POINTER) : INTEGER is
    	local
    		an_identifier: STRING
    	do
			an_identifier := identifier_from_pointer (p)
			remote_curses.send_request (Id_panel_hidden, <<an_identifier>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end	

end -- class CURSES_PANEL_API

-----------------------------------------------------------
-- Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 2
-- (see forum.txt)
-----------------------------------------------------------

