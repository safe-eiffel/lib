indexing

	description: "Buffer objects for database transfer."
	status: "Automatically generated.  DOT NOT MODIFY !"
	generated: "2005/08/11 12:39:02.812"

class BOOK_ID

create

	make

feature {NONE} -- Initialization

	make is
			-- -- Creation of buffers
		do
			create isbn.make (14)
		ensure
			isbn_is_null: isbn.is_null
		end

feature  -- Access

	isbn: ECLI_VARCHAR

end -- class BOOK_ID
