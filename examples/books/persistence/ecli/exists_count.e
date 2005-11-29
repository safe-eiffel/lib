indexing

	description: "Buffer objects for database transfer."
	status: "Automatically generated.  DOT NOT MODIFY !"
	generated: "2005/08/11 12:39:02.546"

class EXISTS_COUNT

creation

	make

feature {NONE} -- Initialization

	make is
			-- -- Creation of buffers
		do
			create exists_count.make
		ensure
			exists_count_is_null: exists_count.is_null
		end

feature  -- Access

	exists_count: ECLI_INTEGER

end -- class EXISTS_COUNT
