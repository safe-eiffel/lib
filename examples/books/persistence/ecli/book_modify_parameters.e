indexing

	description: "Results objects "
	status: "Automatically generated.  DOT NOT MODIFY !"

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
		end

feature  -- Access

	isbn: ECLI_VARCHAR

	title: ECLI_VARCHAR

	author: ECLI_VARCHAR

end
