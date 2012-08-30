note
	description: "Abstraction of a composite key, viewed as a tuple of comparable"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	SRT_TUPLE

inherit
	UTL_INDEXABLE_CONTAINER[COMPARABLE]
		rename
			container as tuple
		export
			{NONE} make, make_from_array
		undefine
		redefine
			conforms_to, out
		select
		end

create
	make, make_from_array
	
feature -- Status report
		
	conforms_to (other : ANY) : BOOLEAN
			-- does 'other' conform to Current ?
		local
			i : INTEGER
			other_tuple : SRT_TUPLE
		do
			other_tuple ?= other
			if other_tuple /= Void and then count = other_tuple.count then
				from
					i := 1
				until
					i > count or else not conforms_item (other_tuple.item (i),i)
				loop
					i := i + 1
				end
				if i > count then
					Result := True
				end
			end
		ensure then
			-- for all i in [1..count] : conforms_item (other.item (i), i)
		end

feature -- Conversion

	out : STRING
		local
			i : INTEGER
		do
			create Result.make (count*3)
			from
				i := 1
			variant
				count + 1 - i
			until
				i > count
			loop
				Result.append ((item (i)).out)
				Result.append ("|")
				i := i + 1
			end
			Result.keep_head (Result.count - 1)
		end
						
invariant
	invariant_clause: -- Your invariant here

end -- class SRT_TUPLE
