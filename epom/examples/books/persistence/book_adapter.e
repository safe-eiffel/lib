indexing

	description:

		"Access modules to persistent state of BOOK instances."

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class BOOK_ADAPTER

inherit

	PO_ADAPTER[BOOK]
		
	BOOK_PERSISTENT_CLASS_NAME
	
	PO_CACHE_USE [BOOK]
	
feature -- Access
	
feature -- Basic operations
		
	read_by_isbn (an_isbn : STRING) is
			-- Read book by `an_isbn'.
		require
			an_isbn_not_void: an_isbn /= Void
		deferred
		end

	read_by_title (a_title : STRING) is
			-- Read book by `a_title'.
		require
			a_title_not_void: a_title /= Void
		deferred
		end
	
	read_by_author (author_name : STRING) is
			-- Read books by `author_name'.
		require
			author_name_not_void:  author_name /= Void
		deferred
		end

feature {PO_ADAPTER} -- Factory

	create_pid_for_isbn (an_isbn : STRING) is
		require
			an_isbn_not_void:  an_isbn /= Void
		deferred
		ensure
			last_pid_not_void:  last_pid /= Void
		end
		
end
