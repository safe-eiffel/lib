indexing

	description: "Results objects "
	status: "Automatically generated.  DOT NOT MODIFY !"

class BORROWER_ROW

creation

	make

feature {NONE} -- Initialization

	make is
			-- -- Creation of buffers
		do
			create id.make
			create name.make (30)
			create address.make (50)
		end

feature  -- Access

	id: ECLI_INTEGER

	name: ECLI_VARCHAR

	address: ECLI_VARCHAR

end
