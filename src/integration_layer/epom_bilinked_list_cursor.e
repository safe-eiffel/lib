indexing

	description: "Cursors for epom bilinked list traversals"
	author:     "Fafchamps Eric"
	date:       "$Date$"
	revision:   "$Revision$"

class EPOM_BILINKED_LIST_CURSOR [G->EPOM_PERSISTENT]

inherit

	DS_BILINKED_LIST_CURSOR [G]
		redefine
			append_left,
			append_right,
			container,
			extend_left,
			extend_right,
			force_left,
			force_right,
			replace,
			prune_left,
			prune_right,
			put_left,
			put_right,
			remove,
			remove_right,
			remove_left,
			swap
		end

creation

	make

feature -- Access

	container: EPOM_BILINKED_LIST [G]
			-- List traversed

feature -- Element change

	append_left (other: DS_LINEAR [G]) is
			-- Add items of `other' to left of cursor position.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
		do
			Precursor (other)
			container.def_modified
		ensure then
			container_is_modified: container.is_modified
		end

	append_right (other: DS_LINEAR [G]) is
			-- Add items of `other' to right of cursor position.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
		do
			Precursor (other)
			container.def_modified
		ensure then
			container_is_modified: container.is_modified
		end

	extend_left (other: DS_LINEAR [G]) is
			-- Add items of `other' to left of cursor position.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
		do
			Precursor (other)
			container.def_modified
		ensure then
			container_is_modified: container.is_modified
		end

	extend_right (other: DS_LINEAR [G]) is
			-- Add items of `other' to right of cursor position.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
		do
			Precursor (other)
			container.def_modified
		ensure then
			container_is_modified: container.is_modified
		end

	force_left (v: G) is
			-- Add `v' to left of cursor position.
			-- Do not move cursors.
		do
			Precursor (v)
			container.def_modified
		ensure then
			container_is_modified: container.is_modified
		end

	force_right (v: G) is
			-- Add `v' to right of cursor position.
			-- Do not move cursors.
		do
			Precursor (v)
			container.def_modified
		ensure then
			container_is_modified: container.is_modified
		end

	put_left (v: G) is
			-- Add `v' to left of cursor position.
			-- Do not move cursors.
		do
			Precursor (v)
			container.def_modified
		ensure then
			container_is_modified: container.is_modified
		end

	put_right (v: G) is
			-- Add `v' to right of cursor position.
			-- Do not move cursors.
		do
			Precursor (v)
			container.def_modified
		ensure then
			container_is_modified: container.is_modified
		end


	replace (v: G) is
			-- Replace item at cursor position by `v'.
			-- (Performance: O(1).)
		do
			container.removed_items.force_last (item)
			Precursor (v)
			container.def_modified
		ensure then
			new_removed_count: container.removed_items.count = old (container.removed_items.count) + 1
			container_is_modified: container.is_modified
		end

	swap (other: DS_DYNAMIC_CURSOR [G]) is
			-- Exchange items at current and `other''s positions.
			-- Note: cursors may reference two different containers.
			-- (from DS_DYNAMIC_CURSOR)
		do
			Precursor (other)
			container.def_modified
		ensure then
			container_is_modified: container.is_modified
		end

feature -- Removal

	prune_left (n: INTEGER) is
			-- Remove `n' items to left of cursor position.
			-- Move all cursors `off'.
		do
			Precursor (n)
		ensure then
			new_removed_count: container.removed_items.count = old (container.removed_items.count) + n
			container_is_modified: container.is_modified
		end

	prune_right (n: INTEGER) is
			-- Remove `n' items to right of cursor position.
			-- Move all cursors `off'.
		do
			Precursor (n)
		ensure then
			new_removed_count: container.removed_items.count = old (container.removed_items.count) + n
			container_is_modified: container.is_modified
		end

	remove is
			-- Remove item at cursor position.
			-- Move any cursors at this position `forth'.
		do
			Precursor
		ensure then
			new_removed_count: container.removed_items.count = old (container.removed_items.count) + 1
			container_is_modified: container.is_modified
		end

	remove_left is
			-- Remove item to left of cursor position.
			-- Move any cursors at this position `forth'.
		do
			Precursor
		ensure then
			new_removed_count: container.removed_items.count = old (container.removed_items.count) + 1
			container_is_modified: container.is_modified
		end

	remove_right is
			-- Remove item to right of cursor position.
			-- Move any cursors at this position `forth'.
		do
			Precursor
		ensure then
			new_removed_count: container.removed_items.count = old (container.removed_items.count) + 1
			container_is_modified: container.is_modified
		end

end -- class EPOM_BILINKED_LIST_CURSOR


--
-- Copyright: 2001, Eric Fafchamps, <eric.fafchamps@belgacom.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
