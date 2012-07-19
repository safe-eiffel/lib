indexing

	description:

		"Objects that represent an outline item."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class
	FO_OUTLINE_NODE

create
	make_root,
	make_child

feature {NONE} -- Initialization

	make_root (a_text : STRING; a_destination : FO_DESTINATION) is
			-- Make a node with `a_text' and `a_destination'.
		require
			a_text_not_void: a_text /= Void
			a_destination_not_void: a_destination /= Void
		do
			create children_impl.make
			text := a_text
			destination := a_destination
		end

	make_child (a_parent : FO_OUTLINE_NODE; a_text : STRING; a_destination : FO_DESTINATION) is
			-- Make a node with `a_text' and `a_destination', direct child of `a_parent'.
		require
			a_parent_not_void: a_parent /= Void
			a_text_not_void: a_text /= Void
			a_destination_not_void: a_destination /= Void
		do
			create children_impl.make
			parent := a_parent
			parent.add_child (Current)
			text := a_text
			destination := a_destination
		ensure
			parent_set: parent = a_parent
			current_child_parent: parent.children.has (Current)
			text_set: text = a_text
			destination_set: destination = a_destination
		end

feature -- Access

	text : STRING
			-- Text shown in the outline tree.

	destination : FO_DESTINATION
			-- Destination to go.

	parent : FO_OUTLINE_NODE
			-- Parent outline item.

	children : DS_LINEAR[FO_OUTLINE_NODE] is
			-- Direct children.
		do
			Result := children_impl
		end

feature -- Status report

	is_leaf : BOOLEAN is
			-- Does Current have no children (Is Current a leaf)?
		do
			Result := children.count = 0
		end

	is_root : BOOLEAN is
			-- Does Current have no parent (Is Current a root node)?
		do
			Result := parent = Void
		end

	is_open : BOOLEAN
			-- Must the node be shown open?

feature -- Status setting

	enable_is_open is
			-- Initially show the node as open.
		do
			is_open := True
		ensure
			is_open: is_open
		end

	disable_is_open is
			-- Initially show the node as closed.
		do
			is_open := True
		ensure
			not_is_open: not is_open
		end

feature {FO_OUTLINE_NODE} -- Element change

	add_child (a_child : FO_OUTLINE_NODE) is
			-- Add `a_child' in `children'
		require
			a_child_not_void: a_child /= Void
			a_child_parented_to_current: a_child.parent = Current
			new_child: not children.has (a_child)
		do
			children_impl.put_last (a_child)
		ensure
			child_in_children: children.has (a_child)
		end


feature {NONE} -- Implementation

	children_impl : DS_LINKED_LIST[FO_OUTLINE_NODE]

invariant

	destination_not_void: destination /= Void
	text_not_void: text /= Void
	children_not_void: children /= Void

end
