indexing

	
		description: "Insert a copy"
	
	status: "Cursor/Query automatically generated for 'COPY_WRITE'. DO NOT EDIT!"
	generated: "2007/01/30 15:29:38.782"

class COPY_WRITE

inherit

	ECLI_QUERY


create

	make

feature  -- -- Access

	parameters_object: COPY_WRITE_PARAMETERS

feature  -- -- Element change

	set_parameters_object (a_parameters_object: COPY_WRITE_PARAMETERS) is
			-- set `parameters_object' to `a_parameters_object'
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

	definition: STRING is "[
insert into copy values (?isbn, ?serial_number, ?loc_store, ?loc_shelf, ?loc_row, ?borrower )
]"

end -- class COPY_WRITE
