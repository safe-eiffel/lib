indexing

	
		description: "delete book"
	
	status: "Cursor/Query automatically generated for 'BOOK_UPDATE'. DO NOT EDIT!"
	generated: "2005/08/11 12:39:02.093"

class BOOK_UPDATE

inherit

	ECLI_QUERY


create

	make

feature  -- -- Access

	parameters_object: BOOK_MODIFY_PARAMETERS

feature  -- -- Element change

	set_parameters_object (a_parameters_object: BOOK_MODIFY_PARAMETERS) is
			-- set `parameters_object' to `a_parameters_object'
		require
			a_parameters_object_not_void: a_parameters_object /= Void
		do
			parameters_object := a_parameters_object
			put_parameter (parameters_object.isbn,"isbn")
			put_parameter (parameters_object.title,"title")
			put_parameter (parameters_object.author,"author")
			bind_parameters
		ensure
			bound_parameters: bound_parameters
		end

feature  -- Constants

	definition: STRING is "update book set title = ?title , author = ?author where isbn = ?isbn	"

end -- class BOOK_UPDATE
