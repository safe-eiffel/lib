indexing

	description: "Buffer objects for database transfer."
	status: "Automatically generated.  DOT NOT MODIFY !"
	generated: "2007/01/30 15:29:38.797"

class EXISTS_COUNT

create

	make

feature {NONE} -- Initialization

	make is
			-- Creation of buffers
		do
			create exists_count.make
		ensure
			exists_count_is_null: exists_count.is_null
		end

feature  -- Access

	exists_count: ECLI_INTEGER

end -- class EXISTS_COUNT
