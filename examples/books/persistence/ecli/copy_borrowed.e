indexing

	
		description: "Get the borrowed copies"
	
	warning: "Generated cursor 'COPY_BORROWED' : DO NOT EDIT !"
	author: "QUERY_ASSISTANT"
	date: "$Date : $"
	revision: "$Revision : $"
	licensing: "See notice at end of class"

class COPY_BORROWED

inherit

	ECLI_CURSOR


creation

	make

feature  -- -- Access

	item: COPY_ID

feature  -- Constants

	definition: STRING is "[
select isbn, serial_number from copy where borrower is not null
	
]"

feature {NONE} -- Implementation

	create_buffers is
			-- -- Creation of buffers
		local
			buffers: ARRAY[like value_anchor]
		do
			create item.make
			create buffers.make (1,2)
			buffers.put (item.isbn, 1)
			buffers.put (item.serial_number, 2)
			set_results (buffers)
		end

end
