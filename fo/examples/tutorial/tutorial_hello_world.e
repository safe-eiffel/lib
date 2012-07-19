indexing
	description: "FO Test for 'hello world'."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	TUTORIAL_HELLO_WORLD

create
	execute

feature {NONE} -- Initialization

	execute is
			-- Initialize `Current'.
		local
			block : FO_BLOCK
		do
			--| 1
			create writer.make ("hello_world.pdf")
			create document.make (writer)

			--| 2
			document.open

			--| 3
			create block.make_default

			--| 4
			block.append_string ("Hello World")

			--| 5
			document.append_block (block)

			--| 6
			document.close
		end

feature -- Access

	document : FO_DOCUMENT
	writer : FO_DOCUMENT_WRITER
	
end
