indexing

	description: "Buffer objects for database transfer."
	status: "Automatically generated.  DOT NOT MODIFY !"
	generated: "2005/08/11 12:39:01.953"

class BOOK_READ_BY_TITLE_PARAMETERS

creation

	make

feature {NONE} -- Initialization

	make is
			-- -- Creation of buffers
		do
			create title.make (100)
		ensure
			title_is_null: title.is_null
		end

feature  -- Access

	title: ECLI_VARCHAR

end -- class BOOK_READ_BY_TITLE_PARAMETERS
