note

	
			description: "Select participants count by remaining amount to pay"
		
	status: "Cursor/Query automatically generated for 'PARTICIPANTS_COUNT_BY_REMAINING'. DO NOT EDIT!"
	generated: "2013/05/08 18:11:42.062"
	generator_version: "v1.7.2"
	source_filename: "access_modules.xml"

class PARTICIPANTS_COUNT_BY_REMAINING

inherit

	ECLI_CURSOR
		redefine
			initialize
		end


create

	make

feature  -- -- Access

	parameters_object: detachable PARTICIPANTS_COUNT_BY_REMAINING_PARAMETERS

	item: PARTICIPANT_COUNT

feature  -- -- Element change

	set_parameters_object (a_parameters_object: PARTICIPANTS_COUNT_BY_REMAINING_PARAMETERS)
			-- set `parameters_object' to `a_parameters_object'
		require
			a_parameters_object_not_void: a_parameters_object /= Void
		do
			parameters_object := a_parameters_object
			put_parameter (parameters_object.remaining_amount,"remaining_amount")
			bind_parameters
		ensure
			bound_parameters: bound_parameters
		end

feature  -- Constants

	definition: STRING = "[
select count (*) as count from PARTICIPANT p, REGISTRATION r where
			r.participant_id = p.identifier AND
			(r.registration_fee - r.paid_amount) > ?remaining_amount
]"

feature {NONE} -- Implementation

	create_buffers
			-- Creation of buffers
		local
			buffers: like results
		do
			create buffers.make (1,0)
			buffers.force (item.count, 1)
			set_results (buffers)
		end

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			Precursor
			create item.make
		end

end
