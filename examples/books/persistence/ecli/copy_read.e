indexing

	
		description: "Read copy"
	
	warning: "Generated cursor 'COPY_READ' : DO NOT EDIT !"
	author: "QUERY_ASSISTANT"
	date: "$Date : $"
	revision: "$Revision : $"
	licensing: "See notice at end of class"

class COPY_READ

inherit

	ECLI_CURSOR


creation

	make

feature  -- -- Access

	parameters_object: COPY_ID

	item: COPY_ROW

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
select isbn, serial_number, LOC_STORE, LOC_SHELF, LOC_ROW, BORROWER 
from COPY 
where isbn=?isbn and serial_number=?serial_number
	
]"

feature {NONE} -- Implementation

	create_buffers is
			-- -- Creation of buffers
		local
			buffers: ARRAY[like value_anchor]
		do
			create item.make
			create buffers.make (1,6)
			buffers.put (item.isbn, 1)
			buffers.put (item.serial_number, 2)
			buffers.put (item.loc_store, 3)
			buffers.put (item.loc_shelf, 4)
			buffers.put (item.loc_row, 5)
			buffers.put (item.borrower, 6)
			set_results (buffers)
		end

end -- class COPY_READ
