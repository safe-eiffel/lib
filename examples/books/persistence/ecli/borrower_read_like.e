indexing

	
		description: "Search for borrower with name like some pattern"
	
	warning: "Generated cursor 'BORROWER_READ_LIKE' : DO NOT EDIT !"
	author: "QUERY_ASSISTANT"
	date: "$Date : $"
	revision: "$Revision : $"
	licensing: "See notice at end of class"

class BORROWER_READ_LIKE

inherit

	ECLI_CURSOR


creation

	make

feature  -- -- Access

	parameters_object: BORROWER_READ_LIKE_PARAMETERS

	item: BORROWER_ID

feature  -- -- Element change

	set_parameters_object (a_parameters_object: BORROWER_READ_LIKE_PARAMETERS) is
			-- Set `parameters_object' to `a_parameters_object'.
		require
			a_parameters_object_not_void: a_parameters_object /= Void
		do
			parameters_object := a_parameters_object
			put_parameter (parameters_object.name,"name")
			bind_parameters
		ensure
			bound_parameters: bound_parameters
		end

feature  -- Constants

	definition: STRING is " %
% select id from borrower where name like ?name %
% "

feature {NONE} -- Implementation

	create_buffers is
			-- -- Creation of buffers
		local
			buffers: ARRAY[like value_anchor]
		do
			create item.make
			create buffers.make (1,1)
			buffers.put (item.id, 1)
			set_results (buffers)
		end

end
