indexing

	
		description: "Delete borrower"
	
	warning: "Generated cursor 'BORROWER_DELETE' : DO NOT EDIT !"
	author: "QUERY_ASSISTANT"
	date: "$Date : $"
	revision: "$Revision : $"
	licensing: "See notice at end of class"

class BORROWER_DELETE

inherit

	ECLI_QUERY


create

	make

feature  -- -- Access

	parameters_object: BORROWER_ID

feature  -- -- Element change

	set_parameters_object (a_parameters_object: BORROWER_ID) is
			-- Set `parameters_object' to `a_parameters_object'.
		require
			a_parameters_object_not_void: a_parameters_object /= Void
		do
			parameters_object := a_parameters_object
			put_parameter (parameters_object.id,"id")
			bind_parameters
		ensure
			bound_parameters: bound_parameters
		end

feature  -- Constants

	definition: STRING is " %
% delete from borrower where id = ?id %
% "

end
