indexing
	description: "LRU cache entries."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PO_LRU_ENTRY

create
	make

feature {NONE} -- Initialization

	make (a_pid : PO_PID) is
			-- Make for `a_pid'.
		require
			a_pid_not_void: a_pid /= Void
		do
			pid := a_pid
		end
		
feature -- Access

	pid : PO_PID
			-- Pid

	time : INTEGER_64
			-- Last access time


feature -- Measurement

	count : INTEGER_64
			-- Count of accesses
			
feature -- Element change

	record_access (a_time : INTEGER_64) is
			-- Record item acces on `a_time'
		require
			a_time_greater_time: a_time > time
		do
			time := a_time
			count := count + 1
		ensure
			time_set: time = a_time
			count_incremented: count = old count + 1
		end

invariant
	pid_not_void: pid /= Void
	
end
