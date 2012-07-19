indexing
	description:

		"Objects that can link to some target destination."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class
	FO_LINKABLE

feature -- Access

	destination : FO_DESTINATION
		-- As link origin: destination pointed to.

feature -- Element change

	set_destination (a_destination : like destination) is
		require
			a_destination_not_void: a_destination /= Void
		do
			destination := a_destination
		ensure
			destination_set: destination = a_destination
		end

end
