indexing
	description: "Access modules to persistent state of BOOK instances."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BOOK_ADAPTER

inherit
	PO_ADAPTER[BOOK]
		
feature -- Access

	class_name : STRING is once create {BOOK_PERSISTENT_CLASS_NAME}Result.make end
	
feature -- Basic operations
		
	read_by_isbn (an_isbn : STRING) is
			-- read book by `an_isbn'
		require
			an_isbn_not_void: an_isbn /= Void
		deferred
		end

	read_by_title (a_title : STRING) is
			-- read book by `a_title'
		require
			a_title_not_void: a_title /= Void
		deferred
		end
	
	read_by_author (author_name : STRING) is
			-- read books by `author_name'
		require
			author_name_exists: author_name /= Void
		deferred
		end

feature {PO_ADAPTER} -- Factory

	create_pid_for_isbn (an_isbn : STRING) is
		require
			an_isbn_exists: an_isbn /= Void
		deferred
		ensure
			last_pid_exists: last_pid /= Void
		end
		
end -- class BOOK_ADAPTER
