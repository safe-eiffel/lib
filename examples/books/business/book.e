indexing

	description:

		"BOOKs"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class BOOK

inherit

	PO_PERSISTENT
	
	BOOK_PERSISTENT_CLASS_NAME
	
creation

	make
	
feature -- Initialization

	make (an_isbn, a_title, an_author : STRING) is
			-- Make with `an_isbn', `a_title', `an_author'.
		require
			a_isbn_valid:  an_isbn /= Void and an_isbn.count > 0 and an_isbn.count <= 14
			a_title_valid:  a_title /= Void and not a_title.is_empty
			an_author_not_void:  an_author /= Void and not an_author.is_empty
		do
			isbn := an_isbn
			title := a_title
			author := an_author
		ensure
			isbn_set: isbn = an_isbn
			title_set: title = a_title
			author_set: author = an_author
		end
		
feature -- Access

	isbn : STRING
	
	title : STRING
	
	author : STRING
		
invariant

	isbn_ok: isbn /= Void and then isbn.count > 0 and isbn.count <=14
	title_ok: title /= Void and then not title.is_empty
	author_set: author /= Void and then not author.is_empty
end
