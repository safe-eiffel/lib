indexing

	description:

		"Objects that hold outline items."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_OUTLINES

create
	make

feature {} -- Initialization

	make is
		do
			create list.make
		end

feature -- Measurement

	count : INTEGER is
			-- Count of items
		do
			Result := list.count
		end

feature -- Status report

	has (node : FO_OUTLINE_NODE) : BOOLEAN is
			-- Does Current have `node' item ?
		do
			Result := list.has (node)
		end

feature -- Element change

	put_last (node : FO_OUTLINE_NODE) is
			-- Put `node' at the last position.
		require
			node_not_void: node /= Void
			node_is_root: node.is_root
			only_one_node: not has (node)
		do
			list.put_last (node)
		ensure
			inserted_node: has (node)
		end

feature -- Basic operations

	do_all (an_action: PROCEDURE [ANY, TUPLE [FO_OUTLINE_NODE]]) is
			-- Do `an_action' for all items in Current.
		require
			an_action_not_void: an_action /= Void
		do
			list.do_all (an_action)
		end

feature {} -- Implementation

	list : DS_LINKED_LIST[FO_OUTLINE_NODE]

invariant
	list_not_void: list /= Void
	no_void: not has (Void)

end
