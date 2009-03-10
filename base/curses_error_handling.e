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

	ANY --| Needed To avoid SE errors about is_equal that is not visible in invariant of GENERAL due to export {NONE} all

	CURSES_ERROR_API
	    export {NONE} all
	    end

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
		Result := c_ecurses_err
	    end

	curses_ok_value : INTEGER is
		-- value indicating that last curses call was 'ok'
	    once
		Result := c_ecurses_ok
	    end

feature {NONE} -- helper procedure

	handle_curses_call ( code : INTEGER; message : STRING) is
	    do
		last_error := code
		if last_error = c_ecurses_err and exceptions_enabled then
			raise (message)
		end
	    end

end -- class CURSES_ERROR_HANDLING
-----------------------------------------------------------
-- Copyright (C) 1999-2009 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 2
-- (see forum.txt)
-----------------------------------------------------------

