indexing

	description	: "Books sample application for EPOM"
	
	copyright: "(c) 2004, Paul G. Crismer and others"
	
class BOOKS_APPLICATION

inherit

	BOOKS_DATASTORE_ACCESS
		
creation

	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			initialize_persistence_framework
			if is_persistence_framework_initialized then
				populate
				borrow_copy_to_borrower ("1", 1, 1)
				borrow_copy_to_borrower ("1", 2, 2)
				show
				delete_copy ("1", 1)
				store.disconnect				
			end
		end
		
		

feature -- Access

	last_book : BOOK
	
	books : ARRAY[BOOK]
	
feature -- Basic operations

	populate is
			-- Populate BOOKS database.
		do
			populate_books
			populate_borrowers
			populate_copies
		end

		
	borrow_copy_to_borrower (book_isbn : STRING; copy_number : INTEGER; borrower_id : INTEGER) is
			-- Borrow some copy identified by (`book_isbn',`copy_number') for borrower `borrower_id'.
		require
			book_isbn_exists: book_isbn /= Void and not book_isbn.is_empty
			copy_number_gt0: copy_number > 0
			borrower_id_gt0: borrower_id > 0
		local
			book_copy : COPY
			borrower : BORROWER
		do
			copy_adapter.read_from_isbn_and_number (book_isbn,copy_number)
			check 
				copy_adapter.status.is_ok
			end
			if copy_adapter.last_cursor.count > 0 then
				book_copy := copy_adapter.last_cursor.first
				if book_copy.is_borrowable then
					borrower_adapter.read_by_id (borrower_id)
					check
						borrower_adapter.status.is_ok
					end
					borrower := borrower_adapter.last_cursor.first
					if borrower /= Void then
						book_copy.borrow (borrower)
						book_copy.update
					end
				end 
			end
		end

	show is
			-- Show various objects.
		do
			show_books
			show_borrowed_copies
		end
		

feature -- Implementation

	populate_books is
			-- Populate books.
		do
			create books.make (1,3)
			write_book ("1", "Title One", "Author one", book_adapter)
			books.put (last_book, 1)
			write_book ("2", "Title two", "Author two", book_adapter)
			books.put (last_book, 2)
			write_book ("3", "Title three", "Author three", book_adapter)
			books.put (last_book, 3)
		end

	populate_borrowers is
			-- Populate borrowers.
		do
			write_borrower (1, "Borrower 1", "One, borrower rd., MOON-1")
			write_borrower (2, "Borrower 2", "Two, borrower rd., MARS-2")
			write_borrower (3, "Borrower 3", "Three, borrower rd., VENUS-3")
		end

	populate_copies is
			-- Populate copies.
		do
			write_copy (books.item (1),1,1,1,1)
			write_copy (books.item (1),2,1,1,2)
			write_copy (books.item (1),3,1,1,3)
			write_copy (books.item (2),1,1,2,1)
			write_copy (books.item (2),2,1,2,2)
			write_copy (books.item (2),3,1,2,3)
			write_copy (books.item (2),4,1,2,4)
			write_copy (books.item (3),1,5,1,1)
			write_copy (books.item (3),2,6,1,1)
			write_copy (books.item (3),3,7,1,1)
			write_copy (books.item (3),4,8,1,1)
			write_copy (books.item (3),5,8,2,1)
		end

	show_books is
		local
			the_book : BOOK
			the_cursor : PO_CURSOR[BOOK]
			adapter : BOOK_ADAPTER
		do
			pom.search_adapter ("BOOK")
			if pom.found then
				adapter ?= pom.last_adapter
				if adapter /= Void then
					adapter.read_by_title ( "%%")
					if not adapter.status.is_error then
						from
							the_cursor := adapter.last_cursor
							the_cursor.start
							print ("BOOKS%N")
							print ("-----%N")
						until
							the_cursor.off
						loop
							the_book := the_cursor.item
							print ("Isbn: "+the_book.isbn + " title:'"+the_book.title+"'%N")
							the_cursor.forth
						end
						print ("%N%N")
					end
				end
			end
		end

	show_borrowed_copies is
			-- Show copies that have been borrowed.
		local
			the_book : BOOK
			the_cursor : PO_CURSOR[COPY]
			the_copy : COPY
		do
			copy_adapter.read_borrowed
			if copy_adapter.status.is_ok then
				from
					the_cursor := copy_adapter.last_cursor
					the_cursor.start
					print ("Borrowed books%N")
					print ("--------------%N")
				until
					the_cursor.off
				loop
					the_copy := the_cursor.item
					the_book := the_copy.book
					print ("'"+ the_book.title+ "' copy "+the_cursor.item.number.out + " borrowed by '"+the_copy.borrower.name+"'");
					print ("%N")
					the_cursor.forth
				end
			end
		end
		

	write_book (book_isbn, book_title, book_author : STRING; adapter : BOOK_ADAPTER) is
			-- Write new book object [`book_isbn', `book_title', `book_author'] through `adapter'.
		local
			b : BOOK
		do
			!! b.make (book_isbn, book_title, book_author)
			try_write (b)
			last_book := b
		end
	
	write_borrower (borrower_id : INTEGER; borrower_name, borrower_address : STRING) is
			-- Write new borrower object [`borrower_id', `borrower_name', `borrower_address'].
		local
			b : BORROWER
		do
			create b.make (borrower_id, borrower_name, borrower_address)
			try_write (b)
		end

	write_copy (book : BOOK; a_number: INTEGER; a_store: INTEGER; a_shelf: INTEGER; a_row: INTEGER) is
			-- Write new copy of `book', having attributes `a_number', `a_store', `a_shelf', `a_row'.
		local
			book_copy : COPY
		do
			create book_copy.make (book, a_number)
			book_copy.set_location (a_store, a_shelf, a_row)
			try_write (book_copy)
		end

	delete_copy (isbn : STRING; a_copy : INTEGER) is		
		local
			l_copy : COPY
		do
			copy_adapter.read_from_isbn_and_number (isbn, a_copy)
			if copy_adapter.status.is_ok and then copy_adapter.last_cursor.count > 0 then
				l_copy := copy_adapter.last_cursor.first
				copy_adapter.delete (l_copy)
			end
		end
		
	try_write (o : PO_PERSISTENT) is
			-- Try writing `o'.
		do
			if not o.exists then
				o.write
				if not o.is_persistent then
					print (o.status.message)
				end
			end
		end		

end
