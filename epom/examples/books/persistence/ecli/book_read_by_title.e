indexing

	
		description: "read book by title"
	
	status: "Cursor/Query automatically generated for 'BOOK_READ_BY_TITLE'. DO NOT EDIT!"
	generated: "2005/08/11 12:39:01.656"

class BOOK_READ_BY_TITLE

inherit

	ECLI_CURSOR


create

	make

feature  -- -- Access

	parameters_object: BOOK_READ_BY_TITLE_PARAMETERS

	item: BOOK_ROW

feature  -- -- Element change

	set_parameters_object (a_parameters_object: BOOK_READ_BY_TITLE_PARAMETERS) is
			-- set `parameters_object' to `a_parameters_object'
		require
			a_parameters_object_not_void: a_parameters_object /= Void
		do
			parameters_object := a_parameters_object
			put_parameter (parameters_object.title,"title")
			bind_parameters
		ensure
			bound_parameters: bound_parameters
		end

feature  -- Constants

	definition: STRING is "select isbn, title, author from book where title like ?title%N%
%	"

feature {NONE} -- Implementation

	create_buffers is
			-- -- Creation of buffers
		local
			buffers: ARRAY[like value_anchor]
		do
			create item.make
			create buffers.make (1,3)
			buffers.put (item.isbn, 1)
			buffers.put (item.title, 2)
			buffers.put (item.author, 3)
			set_results (buffers)
		end

end -- class BOOK_READ_BY_TITLE
