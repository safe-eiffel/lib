indexing

	description: "Results objects "
	status: "Automatically generated.  DOT NOT MODIFY !"

class COPY_WRITE_PARAMETERS

creation

	make

feature {NONE} -- Initialization

	make is
			-- -- Creation of buffers
		do
			create loc_store.make
			create loc_shelf.make
			create loc_row.make
			create borrower.make
			create isbn.make (14)
			create serial_number.make
		end

feature  -- Access

	loc_store: ECLI_INTEGER

	loc_shelf: ECLI_INTEGER

	loc_row: ECLI_INTEGER

	borrower: ECLI_INTEGER

	isbn: ECLI_VARCHAR

	serial_number: ECLI_INTEGER

end -- class COPY_WRITE_PARAMETERS
