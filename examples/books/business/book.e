indexing

	description:

		"BOOKs"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class BOOK

inherit

	PO_PERSISTENT
		redefine
			persistent_class_name
		end
	
	BOOK_PERSISTENT_CLASS_NAME
	
creation

	make
	
feature -- Initialization

	make (an_isbn, a_title, an_author : STRING) is
			-- 
		require
			a_isbn_not_void:  an_isbn /= Void and an_isbn.count > 0 and an_isbn.count <= 14
			a_title_not_void:  a_title /= Void
			an_author_not_void:  an_author /= Void
		do
			isbn := an_isbn
			title := a_title
			author := an_author
		ensure
			isbn = an_isbn
			title = a_title
		end
		
feature -- Access

	isbn : STRING
	
	title : STRING
	
	author : STRING
		
invariant

	isbn_ok: isbn /= Void and then isbn.count > 0 and isbn.count <=14
	title_ok: title /= Void and then title.count > 0

end
