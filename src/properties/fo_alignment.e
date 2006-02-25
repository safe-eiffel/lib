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
	make_left, make_right, make_center

feature -- Initialization
	
	make_left is do value := align_left ensure is_left end
	
	make_right is do value := align_right ensure is_right end
	
	make_center is do value := align_center ensure is_center end
	
feature -- Access

	value : INTEGER
	
feature -- Measurement

feature -- Status report

	is_left : BOOLEAN is do Result := value = align_left end

	is_right : BOOLEAN is do Result := value = align_right end

	is_center : BOOLEAN is do Result := value = align_center end

feature -- Constants

	align_left : INTEGER is 0
	align_right : INTEGER is 1
	align_center : INTEGER is 3
	
invariant
	exclusive_value: is_left xor is_right xor is_center

end
