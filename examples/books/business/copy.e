indexing

	description:

		"COPY of a BOOK"

	copyright: "Copyright (c) 2004, Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class COPY

inherit

	PO_PERSISTENT
		redefine
			persistent_class_name
		end
	
	COPY_PERSISTENT_CLASS_NAME

creation

	make

creation

	{COPY_ADAPTER} make_lazy
	
feature {NONE} -- Initialization

	make (a_book : BOOK; a_number : INTEGER) is
			-- create copy `a_number' for `a_book'
		require
			a_book_not_void:  a_book /= Void
			a_number_positive: a_number >= 0
		do
			create book_reference.set_item (a_book)
			number := a_number
			create borrower_reference.make_void
		ensure
			book_set: book = a_book
			number_set: number = a_number
		end

	make_lazy (a_reference : PO_REFERENCE[BOOK]; a_number : INTEGER) is
			-- create copy `a_number' for a book passed by `a_reference'
		require
			a_reference_not_void:  a_reference /= Void and then not a_reference.is_void
			a_number_positive: a_number >= 0
		do
			create borrower_reference.make_void
			book_reference := a_reference
			number := a_number
		ensure
			book_reference_set: book_reference = a_reference
			number_set: number = a_number
		end
		
feature -- Access

	book : BOOK is
		do
			Result := book_reference.item
		end
		
	
	number : INTEGER
	
	store : INTEGER
	
	shelf : INTEGER
	
	row : INTEGER
	
	borrower : BORROWER is
			-- 
		do
			if not borrower_reference.is_void then
				Result := borrower_reference.item
			end
		end

		
feature -- Status report

	is_borrowable : BOOLEAN is
			-- can this copy be borrowed by someone ?
		do 
			Result := not borrower_reference.is_identified
		end	
		
feature -- Basic operations

	set_location (a_store, a_shelf, a_row : INTEGER) is
			-- set location to `a_store', `a_shelf', `a_location'
		do
			row := a_row
			store := a_store
			shelf := a_shelf
		ensure
			row_set: row = a_row
			store_set: store = a_store
			shelf_set: shelf = a_shelf
		end

	borrow (a_borrower : BORROWER) is
			-- borrow this copy by `a_borrower'
		require
			borrowable: is_borrowable
			a_borrower_not_void: a_borrower /= Void
		do
			borrower_reference.set_item (a_borrower)
		ensure
			borrower_set: borrower = a_borrower
		end

	set_borrowable is
			-- set the book borrowable
		require
			borrowed: not is_borrowable
		do
			borrower_reference.reset
		ensure
			is_borrowable: is_borrowable
		end
		
feature {COPY_ADAPTER} -- Implementation

	borrower_reference : PO_REFERENCE[BORROWER]
	book_reference: PO_REFERENCE[BOOK]
	
invariant

	book_exists : book /= Void
	number_positive: number >= 0

end
