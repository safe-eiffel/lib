indexing

	description: "Buffer objects for database transfer."
	status: "Automatically generated.  DOT NOT MODIFY !"
	generated: "2007/01/30 15:29:38.797"

class COPY_UPDATE_PARAMETERS

create

	make

feature {NONE} -- Initialization

	make is
			-- Creation of buffers
		do
			create loc_store.make
			create loc_shelf.make
			create loc_row.make
			create borrower.make
			create isbn.make (14)
			create serial_number.make
		ensure
			loc_store_is_null: loc_store.is_null
			loc_shelf_is_null: loc_shelf.is_null
			loc_row_is_null: loc_row.is_null
			borrower_is_null: borrower.is_null
			isbn_is_null: isbn.is_null
			serial_number_is_null: serial_number.is_null
		end

feature  -- Access

	loc_store: ECLI_INTEGER

	loc_shelf: ECLI_INTEGER

	loc_row: ECLI_INTEGER

	borrower: ECLI_INTEGER

	isbn: ECLI_VARCHAR

	serial_number: ECLI_INTEGER

end -- class COPY_UPDATE_PARAMETERS
