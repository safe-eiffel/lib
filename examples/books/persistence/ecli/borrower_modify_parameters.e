indexing

	description: "Results objects "
	status: "Automatically generated.  DOT NOT MODIFY !"

class BORROWER_MODIFY_PARAMETERS

creation

	make

feature {NONE} -- Initialization

	make is
			-- -- Creation of buffers
		do
			create id.make
			create address.make (50)
			create name.make (30)
		end

feature  -- Access

	id: ECLI_INTEGER

	address: ECLI_VARCHAR

	name: ECLI_VARCHAR

end
