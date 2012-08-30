note
	description: 
	
		"Objects that compare SRT_TUPLE"

	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	KL_TUPLE_COMPARATOR

inherit
	KL_COMPARATOR [SRT_TUPLE]
	
feature -- Access

	last_break_index : INTEGER
			-- Index of last breaking (>) comparison
	
	last_result : INTEGER
			-- Result of last `compare' operation

	item_anchor : SRT_TUPLE
	
feature -- Status report

	less_than (a , b: like item_anchor): BOOLEAN
		do
			compare (a,b)
			Result := last_result = -1				
		end

	break_index (a, b : like item_anchor) : INTEGER
		require
			arguments_ok: a /= Void and b /= Void
			conformance : a.conforms_to (b)
		do
			compare (a,b)
			Result := last_break_index
		end

	breaked (a, b : like item_anchor) : BOOLEAN
		require
			arguments_ok: a /= Void and b /= Void
			conformance : a.conforms_to (b)
		do
			Result := (break_index (a,b) < a.count)
		ensure
			Result implies (last_break_index < a.count)
		end
		 
feature -- Status setting

	compare (a, b : SRT_TUPLE)
		local
			i, count : INTEGER
		do
			from
				i := 1
				count := index_count (a)
			until
				i > count or else not a.item (index (i)).is_equal(b.item (index (i)))
			loop
				i := i + 1
			end
			if i > count then
				last_result := 0
				last_break_index := i
			else
				if a.item (index(i)) < b.item (index (i)) then
					-- a < b
					last_result := -1 
				else
					--| a.item (index(i)) > b.item (index (i))
					-- a > b
					last_result := +1 
				end
				last_break_index := i
			end

		ensure then
			equality: last_result = 0 implies last_break_index > index (a.count)
			greater:  last_result =+1 implies ((last_break_index <= a.count) and (a.item (index(last_break_index)) > b.item (index(last_break_index))))
			less   :  last_result =-1 implies ((last_break_index <= a.count) and (a.item (index(last_break_index)) < b.item (index(last_break_index))))
			last_result: last_result >= - 1 and last_result <= 1
		end

feature {NONE} -- Implementation

	index (i : INTEGER) : INTEGER
		do
			Result := i
		end

	index_count (t : SRT_TUPLE) : INTEGER
		do
			Result := t.count
		end

end -- class KL_TUPLE_COMPARATOR
