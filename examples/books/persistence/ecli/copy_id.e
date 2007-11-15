indexing

	description: "Buffer objects for database transfer."
	status: "Automatically generated.  DOT NOT MODIFY !"
	generated: "2007/01/30 15:29:38.797"

class COPY_ID

create

	make

feature {NONE} -- Initialization

	make is
			-- Creation of buffers
		do
			create isbn.make (14)
			create serial_number.make
		ensure
			isbn_is_null: isbn.is_null
			serial_number_is_null: serial_number.is_null
		end

feature  -- Access

	isbn: ECLI_VARCHAR

	serial_number: ECLI_INTEGER

end -- class COPY_ID
