note

	
			description: "Select participants matching a last name"
		
	status: "Cursor/Query automatically generated for 'PARTICIPANTS_BY_NAME'. DO NOT EDIT!"
	generated: "2012/09/03 16:46:50.845"
	generator_version: "v1.6"
	source_filename: "access_modules.xml"

class PARTICIPANTS_BY_NAME

inherit

	ECLI_CURSOR


create

	make

feature  -- -- Access

	parameters_object: PARTICIPANTS_BY_NAME_PARAMETERS

	item: PARTICIPANT_ROW

feature  -- -- Element change

	set_parameters_object (a_parameters_object: PARTICIPANTS_BY_NAME_PARAMETERS)
			-- set `parameters_object' to `a_parameters_object'
		require
			a_parameters_object_not_void: a_parameters_object /= Void
		do
			parameters_object := a_parameters_object
			put_parameter (parameters_object.last_name,"last_name")
			bind_parameters
		ensure
			bound_parameters: bound_parameters
		end

feature  -- Constants

	definition: STRING = "[
select * from PARTICIPANT where
			last_name = ?last_name
]"

feature {NONE} -- Implementation

	create_buffers
			-- Creation of buffers
		local
			buffers: ARRAY[like value_anchor]
		do
			create item.make
			create buffers.make (1,9)
			buffers.put (item.identifier, 1)
			buffers.put (item.first_name, 2)
			buffers.put (item.last_name, 3)
			buffers.put (item.street, 4)
			buffers.put (item.no, 5)
			buffers.put (item.zip, 6)
			buffers.put (item.city, 7)
			buffers.put (item.state, 8)
			buffers.put (item.country, 9)
			set_results (buffers)
		end

end
