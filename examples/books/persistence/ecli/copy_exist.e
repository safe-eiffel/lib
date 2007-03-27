indexing

	
		description: "Does a COPY exist?"
	
	status: "Cursor/Query automatically generated for 'COPY_EXIST'. DO NOT EDIT!"
	generated: "2007/01/30 15:29:38.750"

class COPY_EXIST

inherit

	ECLI_CURSOR


creation

	make

feature  -- -- Access

	parameters_object: COPY_ID

	item: EXISTS_COUNT

feature  -- -- Element change

	set_parameters_object (a_parameters_object: COPY_ID) is
			-- set `parameters_object' to `a_parameters_object'
		require
			a_parameters_object_not_void: a_parameters_object /= Void
		do
			parameters_object := a_parameters_object
			put_parameter (parameters_object.isbn,"isbn")
			put_parameter (parameters_object.serial_number,"serial_number")
			bind_parameters
		ensure
			bound_parameters: bound_parameters
		end

feature  -- Constants

	definition: STRING is "[
select count (*) as exists_count from COPY where isbn=?isbn and serial_number=?serial_number
]"

feature {NONE} -- Implementation

	create_buffers is
			-- Creation of buffers
		local
			buffers: ARRAY[like value_anchor]
		do
			create item.make
			create buffers.make (1,1)
			buffers.put (item.exists_count, 1)
			set_results (buffers)
		end

end -- class COPY_EXIST
