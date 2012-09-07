note
	description: 
	
		"Objects that can compare an arrangement of SRT_TUPLE components"

	author: "PGC"
	date: "$Date$"
	revision: "$Revision$"

class
	KL_ARRANGEABLE_TUPLE_COMPARATOR

inherit
	KL_TUPLE_COMPARATOR
		redefine
			index, index_count
		end

create

	make 
		
feature {NONE} -- Initialization

	make (an_array : ARRAY[INTEGER]; a_prototype : SRT_TUPLE)
			-- make from 'an_array' according to 'a_prototype' tuple
		require
			prototype: a_prototype /= Void
			array: an_array /= Void and then an_array.count <= a_prototype.count
			arranged_array: is_index_arrangement (an_array, a_prototype)
		do
			arrangement := an_array
			prototype := a_prototype
		ensure
			prototype_set: prototype = a_prototype
			arrangement: index_arrangement = an_array
		end
	
feature -- Access
	
	prototype : SRT_TUPLE 
		-- prototype tuple

	index_arrangement : ARRAY [INTEGER]
		do
			Result := arrangement
		end
				
feature -- Status report

	can_compare (a, b : SRT_TUPLE) : BOOLEAN
		do
			Result := (a.conforms_to (prototype) and b.conforms_to (prototype))
		ensure then
			prototype_conformance: Result = (a.conforms_to (prototype) and b.conforms_to (prototype))
		end
		
	is_index_arrangement (an_array : ARRAY[INTEGER]; a_prototype : SRT_TUPLE) : BOOLEAN
			-- does 'an_array' contain an arrangement without repeating values of 1..an_array.count ?
		require
			prototype: a_prototype /= Void
			array: an_array /= Void and then an_array.count <= a_prototype.count
		local
			index_set : ARRAY[BOOLEAN]
			k : INTEGER
		do
			--| create boolean array
			create index_set.make (1, a_prototype.count)
			--| an_array contains an arrangement of integers in 1..an_array.count
			--| verify by flagging met indexes
			from
				k := 1
				Result := True
			variant
				an_array.count - k
			until
				(not Result) or else (k > an_array.count)
			loop
				if index_set @ (an_array.item (k)) then
					Result := False
				else
					index_set.put (True, an_array.item (k))
				end
				k := k + 1
			end
		end
			
feature {NONE} -- Implementation

	index (i : INTEGER) : INTEGER
		do
			Result := arrangement @ i
		end


	index_count (t : SRT_TUPLE) : INTEGER
		do
			Result := arrangement.count
		end

	arrangement : ARRAY[INTEGER]
	
invariant
	
	prototype_not_void: prototype /= Void
	arrangement_not_void: arrangement /= Void
	valid_arrangement_count: arrangement.count <= prototype.count
	
end -- class KL_ARRANGEABLE_TUPLE_COMPARATOR
