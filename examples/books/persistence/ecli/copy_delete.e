indexing

	
		description: "Delete copy"
	
	warning: "Generated cursor 'COPY_DELETE' : DO NOT EDIT !"
	author: "QUERY_ASSISTANT"
	date: "$Date : $"
	revision: "$Revision : $"
	licensing: "See notice at end of class"

class COPY_DELETE

inherit

	ECLI_QUERY


creation

	make

feature  -- -- Access

	parameters_object: COPY_ID

feature  -- -- Element change

	set_parameters_object (a_parameters_object: COPY_ID) is
			-- set `parameters_object' to `a_parameters_object'
		require
			a_parameters_object_not_void: a_parameters_object /= Void
		do
			parameters_object := a_parameters_object
			put_parameter (parameters_object.isbn,"isbn")
			put_parameter (parameters_object.serial_number,"serial_number")
			bind_parameters
		ensure
			bound_parameters: bound_parameters
		end

feature  -- Constants

	definition: STRING is "[
delete from copy where isbn=?isbn and serial_number=?serial_number
	
]"

end -- class COPY_DELETE
