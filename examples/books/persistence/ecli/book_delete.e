indexing

	
		description: "delete book"
	
	warning: "Generated cursor 'BOOK_DELETE' : DO NOT EDIT !"
	author: "QUERY_ASSISTANT"
	date: "$Date : $"
	revision: "$Revision : $"
	licensing: "See notice at end of class"

class BOOK_DELETE

inherit

	ECLI_QUERY


creation

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

	definition: STRING is "delete from book where isbn = ?isbn%
%	"

end -- class BOOK_DELETE
