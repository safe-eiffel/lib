indexing

    description: "Curses attribute constants."
    cluster: 	"ecurses, spec";
    interface: 	"mixin"
    status: 	"See notice at end of class";
    date: 	"$Date$";
    revision: 	"$Revision$";
    author: 	"Paul G. Crismer, Eric Fafchamps"

class CURSES_ATTRIBUTE_CONSTANTS

inherit
	
	RCURSES_ATTRIBUTE_CONSTANTS_IDS
		export
			{NONE} all
		end
	
	RCURSES_CLIENT_API
		export
			{NONE} all
		end

feature

    Attribute_attributes: INTEGER is 
		do
			remote_curses.send_request (Id_attribute_attributes, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Attribute_normal: INTEGER is 
		do
			remote_curses.send_request (Id_attribute_normal, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Attribute_standout: INTEGER is 
		do
			remote_curses.send_request (Id_attribute_standout, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Attribute_underline: INTEGER is 
		do
			remote_curses.send_request (Id_attribute_underline, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Attribute_reverse: INTEGER is 
		do
			remote_curses.send_request (Id_attribute_reverse, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Attribute_blink: INTEGER is 
		do
			remote_curses.send_request (Id_attribute_blink, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Attribute_dim: INTEGER is 
		do
			remote_curses.send_request (Id_attribute_dim, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Attribute_bold: INTEGER is 
		do
			remote_curses.send_request (Id_attribute_bold, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Attribute_altcharset: INTEGER is 
		do
			remote_curses.send_request (Id_attribute_altcharset, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Attribute_invisible: INTEGER is 
		do
			remote_curses.send_request (Id_attribute_invisible, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end

    Attribute_protected: INTEGER is 
		do
			remote_curses.send_request (Id_attribute_protected, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end


    Attribute_color: INTEGER is 
		do
			remote_curses.send_request (Id_attribute_color, <<>>)
			Result := remote_curses.last_results.item (1).to_integer	
		end


end  -- class CURSES_ATTRIBUTE_CONSTANTS

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------


