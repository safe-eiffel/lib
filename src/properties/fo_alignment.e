indexing
	description: "Alignments"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	FO_ALIGNMENT

create
	make_start, make_end, make_left, make_right, make_center

feature -- Initialization

	make_start is
			-- Initialize `Current'.
		do
			value := a_start
		ensure is_start end

	make_end is do value := a_end ensure is_end end
	
	make_left is do value := a_left ensure is_left end
	
	make_right is do value := a_right ensure is_right end
	
	make_center is do value := a_center ensure is_center end
	
feature -- Access

	value : INTEGER
	
feature -- Measurement

feature -- Status report

	is_start : BOOLEAN is do Result := value = a_start end

	is_end : BOOLEAN is do Result := value = a_end end

	is_left : BOOLEAN is do Result := value = a_left end

	is_right : BOOLEAN is do Result := value = a_right end

	is_center : BOOLEAN is do Result := value = a_center end

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	a_start, a_end, a_left, a_right, a_center : INTEGER is unique
	
invariant
	exclusive_value: is_start xor is_end xor is_left xor is_right xor is_center

end -- class FO_ALIGNMENT
