indexing

	
		description: "Read Borrower"
	
	warning: "Generated cursor 'BORROWER_READ' : DO NOT EDIT !"
	author: "QUERY_ASSISTANT"
	date: "$Date : $"
	revision: "$Revision : $"
	licensing: "See notice at end of class"

class BORROWER_READ

inherit

	ECLI_CURSOR


creation

	make

feature  -- -- Access

	parameters_object: BORROWER_ID

	item: BORROWER_ROW

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
% select id, name, address from borrower where id = ?id %
% "

feature {NONE} -- Implementation

	create_buffers is
			-- -- Creation of buffers
		local
			buffers: ARRAY[like value_anchor]
		do
			create item.make
			create buffers.make (1,3)
			buffers.put (item.id, 1)
			buffers.put (item.name, 2)
			buffers.put (item.address, 3)
			set_results (buffers)
		end

end
