indexing

	
		description: "Update borrower"
	
	warning: "Generated cursor 'BORROWER_UPDATE' : DO NOT EDIT !"
	author: "QUERY_ASSISTANT"
	date: "$Date : $"
	revision: "$Revision : $"
	licensing: "See notice at end of class"

class BORROWER_UPDATE

inherit

	ECLI_QUERY


create

	make

feature  -- -- Access

	parameters_object: BORROWER_MODIFY_PARAMETERS

feature  -- -- Element change

	set_parameters_object (a_parameters_object: BORROWER_MODIFY_PARAMETERS) is
			-- Set `parameters_object' to `a_parameters_object'.
		require
			a_parameters_object_not_void: a_parameters_object /= Void
		do
			parameters_object := a_parameters_object
			put_parameter (parameters_object.id,"id")
			put_parameter (parameters_object.address,"address")
			put_parameter (parameters_object.name,"name")
			bind_parameters
		ensure
			bound_parameters: bound_parameters
		end

feature  -- Constants

	definition: STRING is " %
% update borrower set name=?name, address =?address where id=?id %
% "

end
