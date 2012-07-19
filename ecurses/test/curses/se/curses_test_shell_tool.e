indexing
	description: "Tool to invoke the operating system SHELL in SmallEiffel "
	author: "Fafchamps Eric"
	date: "$Date$"
	revision: "$Revision$"

class
	CURSES_TEST_SHELL_TOOL
inherit
	EXCEPTIONS

feature -- Basic routines

	system_request (s: STRING) is
			-- Pass to the operating system a request to execute `s'.
		require
			s_exists: s /= Void
		local
			is_rescued: BOOLEAN
		do
			--| Exceptions are ignored here because each time a SIGCHLD (child terminated) occurs
			if not is_rescued then
				system (s)
			end
		rescue
			is_rescued := True
			retry
		end


end -- class CURSES_TEST_SHELL_TOOL
