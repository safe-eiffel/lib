indexing

	description: "Results objects "
	status: "Automatically generated.  DOT NOT MODIFY !"

class COPY_ROW

creation

	make

feature {NONE} -- Initialization

	make is
			-- -- Creation of buffers
		do
			create isbn.make (14)
			create serial_number.make
			create loc_store.make
			create loc_shelf.make
			create loc_row.make
			create borrower.make
		end

feature  -- Access

	isbn: ECLI_VARCHAR

	serial_number: ECLI_INTEGER

	loc_store: ECLI_INTEGER

	loc_shelf: ECLI_INTEGER

	loc_row: ECLI_INTEGER

	borrower: ECLI_INTEGER

end
