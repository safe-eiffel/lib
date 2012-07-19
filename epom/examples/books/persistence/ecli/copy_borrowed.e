indexing

	
		description: "Get the borrowed copies"
	
	status: "Cursor/Query automatically generated for 'COPY_BORROWED'. DO NOT EDIT!"
	generated: "2007/01/30 15:29:38.750"

class COPY_BORROWED

inherit

	ECLI_CURSOR


create

	make

feature  -- -- Access

	item: COPY_ID

feature  -- Constants

	definition: STRING is "[
select isbn, serial_number from copy where borrower is not null and borrower > 0
]"

feature {NONE} -- Implementation

	create_buffers is
			-- Creation of buffers
		local
			buffers: ARRAY[like value_anchor]
		do
			create item.make
			create buffers.make (1,2)
			buffers.put (item.isbn, 1)
			buffers.put (item.serial_number, 2)
			set_results (buffers)
		end

end -- class COPY_BORROWED
