indexing
	description: "Document layout constants. For initial display by PDF reader."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_LAYOUT_CONSTANTS

feature -- Constants

	Layout_single_page : STRING is "SinglePage" 
				-- Display one page at a time.
				
	Layout_one_column : STRING is "OneColumn" 
				-- Display the pages in one column.
				
	Layout_two_column_left : STRING is "TwoColumnLeft"
				-- Display the pages in two columns, with oddnumbered
				-- pages on the left.
				
	Layout_two_column_right : STRING is "TwoColumnRight"
				-- Display the pages in two columns, with oddnumbered
				-- pages on the right.

end -- class PDF_LAYOUT_CONSTANTS
