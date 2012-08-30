note
	description: 
	
		"Objects that compare DS_PAIRs whose first element is a SRT_TUPLE"
		
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	KL_PAIR_FIRST_TUPLE_COMPARATOR [G]
	
inherit
	
	KL_PAIR_FIRST_COMPARATOR [SRT_TUPLE, G]
		redefine
			less_than, first_comparator
		end

create
	
	make

feature -- Access

	last_break_index : INTEGER
			-- Index of last breaking (>) comparison
	
	last_result : INTEGER
			-- Result of last `compare' operation

	first_comparator : KL_TUPLE_COMPARATOR
	
feature -- Status report

	less_than (a , b: DS_PAIR[SRT_TUPLE,G]): BOOLEAN
		do
			first_comparator.compare (a.first, b.first)
			last_result := first_comparator.last_result
			last_break_index := first_comparator.last_break_index
			Result := last_result = -1				
		end
end
