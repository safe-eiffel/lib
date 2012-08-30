note
	description: "indexable container"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

deferred class

	UTL_INDEXABLE_CONTAINER [G]

feature -- Initialisation

	make (element_count : INTEGER)
		do
			create container.make (1, element_count)
		ensure
			count_set: count = element_count
		end
			

	make_from_array (a : ARRAY[G])
		require
			a /= Void
		do
			container := a
		ensure
			same_count: count = a.count
			same_content: item(lower).is_equal (a.item(a.lower)) 
					-- for_each i in [lower..upper] it_holds item(i).is_equal (a.item(i)
		end


	item (index : INTEGER) : G
			-- 'index'th item
		require
			valid_index: valid_index (index)
		do
			Result := container.item (index)
		end

feature -- Measurement

	lower : INTEGER
			-- lower element index
		do
			Result := container.lower
		end
		
	upper : INTEGER
			-- upper element index
		do
			Result := container.upper
		end
		
	count : INTEGER
			-- number of elements
		do
			Result := container.count
		end
		
feature -- Status report

	valid_index (i : INTEGER) : BOOLEAN
		do
			Result := (i >= lower and then i <= upper)
		ensure
			Result = (i >= lower and then i <= upper)
		end

	conforms_item (other : G; index : INTEGER) : BOOLEAN
			-- does 'other' conform to item 'index'
		require
			valid_index: valid_index (index)
			valid_other: other /= Void
		do
			if item (index) = Void then
				Result := True
			else
				Result := (item(index).conforms_to (other))
			end
		ensure
			conformance: Result implies (item(index) = Void or else item(index).conforms_to(other))
		end
		
feature -- Status setting

	put (a_value : G; an_index : INTEGER)
		require
			valid_index: valid_index (an_index)
			conforming_value: conforms_item (a_value, an_index)
		do
			container.put (a_value, an_index)
		ensure
			value_set: item (an_index) = a_value
		end

feature {NONE} -- Implementation

	container : ARRAY [G]

end -- class UTL_INDEXABLE_CONTAINER
