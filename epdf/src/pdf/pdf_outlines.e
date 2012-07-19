indexing
	description: "Outlines node object."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

class
	PDF_OUTLINES

inherit
	PDF_OBJECT
		redefine
			make, put_pdf
		end

	PDF_OUTLINE_NODE
		undefine
			make
		end

create

	make

feature -- Initialization

	make (a_number: INTEGER) is
			--
		do
			Precursor (a_number)
			create list.make
		end

feature -- Access

	node_anchor : PDF_OUTLINE_ITEM

feature -- Measurement

	open_count : INTEGER is
		do
			Result := children_open_count
		end

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

	put_pdf (medium: PDF_OUTPUT_MEDIUM) is
			-- put Current on `medium'
		local
			c : INTEGER
		do
			medium.put_string (object_header)
			medium.put_string (Begin_dictionary)
			if not list.is_empty then
				medium.put_string ("/First ")
				medium.put_string (list.first.indirect_reference)
				medium.put_new_line
				medium.put_string ("/Last ")
				medium.put_string (list.last.indirect_reference)
				medium.put_new_line
				c := open_count
				if c > 0 then
					medium.put_string ("/Count ")
					medium.put_string (c.out)
					medium.put_new_line
				end
			end
			medium.put_string (End_dictionary)
			medium.put_string (Object_footer)
		end

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations


feature {NONE} -- Implementation

invariant
	parent_is_void: parent = Void

end -- class PDF_OUTLINES
