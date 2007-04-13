indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_NAME_TREE_DIRECTORY

inherit
	PDF_NAME_TREE_NODE
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_number : INTEGER) is
		do
			precursor (a_number)
			create children.make
		end

feature -- Access

	lower_key : STRING is
		do
			Result := children.first.lower_key
		end

	upper_key : STRING is
		do
			Result := children.last.upper_key
		end

feature -- Measurement

	count : INTEGER is do Result := children.count end

feature -- Status report

	valid_node (node : PDF_NAME_TREE_NODE) : BOOLEAN is
		do
			if node /= Void then
				if count > 0 then
					Result := node.lower_key > upper_key
				else
					Result := True
				end
			end
		end

feature -- Element change

	put (node : PDF_NAME_TREE_NODE) is
		require
			valid_node: valid_node (node)
			count_less_capacity: count < capacity
		do
			children.put_last (node)
		end


feature {NONE} -- Implementation

	children : DS_LINKED_LIST[PDF_NAME_TREE_NODE]

	content_name : PDF_NAME is do result := names.kids end

	content_array : STRING is
		do
			create result.make (100)
			Result.append_string ("[%N")
			from
				children.start
			until
				children.after
			loop
				Result.append_string (children.item_for_iteration.indirect_reference)
				Result.append_character ('%N')
				children.forth
			end
			Result.append_character (']')
		end

invariant

	children_not_void: children /= Void
	children_count_positive: children.count >= 0
	children_count_le_capacity: children.count <= capacity

end
