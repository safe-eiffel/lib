indexing

	description: "Results objects "
	status: "Automatically generated.  DOT NOT MODIFY !"

class BOOK_ID

creation

	make

feature {NONE} -- Initialization

	make is
			-- -- Creation of buffers
		do
			create isbn.make (14)
		end

feature  -- Access

	isbn: ECLI_VARCHAR

end -- class BOOK_ID
