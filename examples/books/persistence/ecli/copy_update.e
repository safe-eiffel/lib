indexing

	
		description: "Update copy"
	
	warning: "Generated cursor 'COPY_UPDATE' : DO NOT EDIT !"
	author: "QUERY_ASSISTANT"
	date: "$Date : $"
	revision: "$Revision : $"
	licensing: "See notice at end of class"

class COPY_UPDATE

inherit

	ECLI_QUERY


creation

	make

feature  -- -- Access

	parameters_object: COPY_UPDATE_PARAMETERS

feature  -- -- Element change

	set_parameters_object (a_parameters_object: COPY_UPDATE_PARAMETERS) is
			-- Set `parameters_object' to `a_parameters_object'.
		require
			a_parameters_object_not_void: a_parameters_object /= Void
		do
			parameters_object := a_parameters_object
			put_parameter (parameters_object.loc_store,"loc_store")
			put_parameter (parameters_object.loc_shelf,"loc_shelf")
			put_parameter (parameters_object.loc_row,"loc_row")
			put_parameter (parameters_object.borrower,"borrower")
			put_parameter (parameters_object.isbn,"isbn")
			put_parameter (parameters_object.serial_number,"serial_number")
			bind_parameters
		ensure
			bound_parameters: bound_parameters
		end

feature  -- Constants

	definition: STRING is "%
% update copy %
% set loc_store=?loc_store, loc_shelf = ?loc_shelf, loc_row=?loc_row, borrower=?borrower %
% where isbn=?isbn and serial_number =?serial_number %
% "

end
