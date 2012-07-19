indexing

	
		description: "delete book"
	
	status: "Cursor/Query automatically generated for 'BOOK_DELETE'. DO NOT EDIT!"
	generated: "2005/08/11 12:39:02.406"

class BOOK_DELETE

inherit

	ECLI_QUERY


create

	make

feature  -- -- Access

	parameters_object: BOOK_ID

feature  -- -- Element change

	set_parameters_object (a_parameters_object: BOOK_ID) is
			-- set `parameters_object' to `a_parameters_object'
		require
			a_parameters_object_not_void: a_parameters_object /= Void
		do
			parameters_object := a_parameters_object
			put_parameter (parameters_object.isbn,"isbn")
			bind_parameters
		ensure
			bound_parameters: bound_parameters
		end

feature  -- Constants

	definition: STRING is "delete from book where isbn = ?isbn%N%
%	"

end -- class BOOK_DELETE
