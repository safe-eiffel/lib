indexing

	description: "Results objects "
	status: "Automatically generated.  DOT NOT MODIFY !"

class COPY_ID

creation

	make

feature {NONE} -- Initialization

	make is
			-- -- Creation of buffers
		do
			create isbn.make (14)
			create serial_number.make
		end

feature  -- Access

	isbn: ECLI_VARCHAR

	serial_number: ECLI_INTEGER

end -- class COPY_ID
