indexing
	description: "Tool to invoke the operating system SHELL in ISE Eiffel"
	author: "Fafchamps Eric"
	date: "$Date$"
	revision: "$Revision$"

class
	CURSES_TEST_SHELL_TOOL

feature -- Basic routines

	system_request (s: STRING) is
			-- Pass to the operating system a request to execute `s'.
			-- If `s' is empty, use the default shell as command.
		require
			s_exists: s /= Void
		local
			execution_environment: EXECUTION_ENVIRONMENT
		do
			!!execution_environment
			execution_environment.system (s)
		end

end -- class CURSES_TEST_SHELL_TOOL
