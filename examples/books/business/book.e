indexing
	description: "BOOKs"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	BOOK

inherit
	PO_PERSISTENT
		redefine
			persistent_class_name
		end
	
creation

	make
	
feature -- Initialization

	make (an_isbn, a_title, an_author : STRING) is
			-- 
		require
			a_isbn_exists: an_isbn /= Void and an_isbn.count > 0 and an_isbn.count <= 14
			a_title_exists: a_title /= Void
			an_author_exists: an_author /= Void
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
	
	persistent_class_name : STRING is
		do
			create {BOOK_PERSISTENT_CLASS_NAME}Result.make
		end
		
invariant

	isbn_ok: isbn /= Void and then isbn.count > 0 and isbn.count <=14
	title_ok: title /= Void and then title.count > 0

end -- class BOOK
