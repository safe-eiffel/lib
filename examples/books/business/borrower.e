indexing
	description: "BORROWERs"
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	BORROWER

inherit
	PO_PERSISTENT
		redefine
			persistent_class_name
		end
	
creation

	make
	
feature -- Initialization

	make (an_id : INTEGER; a_name, an_address : STRING) is
			-- 
		require
			an_id_gt0: an_id > 0
			a_name /= Void
			an_address /= Void
		do
			id := an_id
			name := a_name
			address := an_address
		ensure
			id_set: id = an_id
			name_set: name = a_name
			address_set: address = an_address
			
		end
		
feature -- Access

	id : INTEGER
		
	name : STRING
	
	address : STRING
	
	borrowed_copies : DS_LIST [COPY] is
		do
			--|FIXME: TODO
		end

	persistent_class_name : STRING is
		do
			create {BORROWER_PERSISTENT_CLASS_NAME}Result.make
		end
		
invariant

	id_gt0: id > 0
	name_exists: name /= Void
	address_exists: address /= Void

end
