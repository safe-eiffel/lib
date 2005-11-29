indexing

	description: "Buffer objects for database transfer."
	status: "Automatically generated.  DOT NOT MODIFY !"
	generated: "2005/08/11 12:39:02.906"

class BOOK_MODIFY_PARAMETERS

creation

	make

feature {NONE} -- Initialization

	make is
			-- -- Creation of buffers
		do
			create isbn.make (14)
			create title.make (100)
			create author.make (30)
		ensure
			isbn_is_null: isbn.is_null
			title_is_null: title.is_null
			author_is_null: author.is_null
		end

feature  -- Access

	isbn: ECLI_VARCHAR

	title: ECLI_VARCHAR

	author: ECLI_VARCHAR

end -- class BOOK_MODIFY_PARAMETERS
