indexing

	description: "Results objects "
	status: "Automatically generated.  DOT NOT MODIFY !"

class BOOK_READ_BY_TITLE_PARAMETERS

creation

	make

feature {NONE} -- Initialization

	make is
			-- -- Creation of buffers
		do
			create title.make (100)
		end

feature  -- Access

	title: ECLI_VARCHAR

end -- class BOOK_READ_BY_TITLE_PARAMETERS
