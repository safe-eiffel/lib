indexing
	description: "Curses error handling, modeled after the C++ ncurses interface";
	cluster: 	"ecurses, base";
	interface: 	"mixin"
	status: 	"See notice at end of class";
	date: 		"$Date$";
	revision: 	"$Revision$";
	author: 	"Paul G. Crismer, Eric Fafchamps"

class 
	CURSES_ERROR_HANDLING

inherit
	EXCEPTIONS
	    export {NONE} all
	    end

feature

	enable_exceptions is
		-- raise an exception when an error occurs
	    do
		exceptions_enabled := True
	    end

	disable_exceptions is
		
	    do
		exceptions_enabled := false
	    end

	exceptions_enabled : BOOLEAN

	last_error : INTEGER
		-- value returned by last curses call; it is not necessarily
		-- an error value !!!

	curses_error_value : INTEGER is
		-- value indicating that last curses call was in 'error'
	    once
		Result := c_curses_err
	    end

	curses_ok_value : INTEGER is
		-- value indicating that last curses call was 'ok'
	    once
		Result := c_curses_ok
	    end

feature {NONE} -- helper procedure
	handle_curses_call ( code : INTEGER; message : STRING) is
	    do
		last_error := code
		if last_error = c_curses_err and exceptions_enabled then
			raise (message)
		end
	    end

feature {NONE} -- C interface

    c_curses_err: INTEGER is
	external "C [macro <ecurses.h>]"
	alias "ERR"
	end

    c_curses_ok: INTEGER is
	external "C [macro <ecurses.h>]"
	alias "OK"
	end

end -- class CURSES_ERROR_HANDLING
-----------------------------------------------------------
-- Copyright (C) 1999 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------

