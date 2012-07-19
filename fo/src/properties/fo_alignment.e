indexing

	description:

		"Alignment properties"

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_ALIGNMENT

create
	make_left, make_right, make_center, make_justify

feature -- Initialization

	make_left is
		do
			value := align_left
		ensure
			is_left: is_left
		end

	make_right is
		do
			value := align_right
		ensure
			is_right: is_right
		end

	make_center is
		do
			value := align_center
		ensure
			is_center: is_center
		end

	make_justify is
		do
			value := align_justify
		ensure
			is_justify: is_justify
		end

feature {NONE} -- Access

	value : INTEGER

feature -- Status report

	is_left : BOOLEAN is
			-- Is alignment left?
		do
			Result := value = align_left
		end

	is_right : BOOLEAN is
			-- Is alignment right?
		do
			Result := value = align_right
		end

	is_center : BOOLEAN is
			-- Is alignment center?
		do
			Result := value = align_center
		end

	is_justify : BOOLEAN is
			-- Is alignment justify?
		do
			Result := value = align_justify
		end

feature {NONE} -- Constants

	align_left : INTEGER is 0
	align_right : INTEGER is 1
	align_center : INTEGER is 3
	align_justify : INTEGER is 4

invariant

	exclusive_value: is_left xor is_right xor is_center xor is_justify

end
