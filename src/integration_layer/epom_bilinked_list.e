indexing
	description: "Bilinked list objects which logs removed items"
	author: "Fafchamps Eric"
	date: "$Date$"
	revision: "$Revision$"

class
	EPOM_BILINKED_LIST [G->EPOM_PERSISTENT]

inherit
	EPOM_PERSISTENT_COLLECTION [G]
		undefine
			copy, is_equal
		redefine
			is_modified
		end

	DS_BILINKED_LIST [G]
		redefine
			append,
			append_first,
			append_last,
			append_left,
			append_left_cursor,
			append_right,
			append_right_cursor,
			delete,
			extend,
			extend_first,
			extend_last,
			extend_left,
			extend_left_cursor,
			extend_right,
			extend_right_cursor,
			force,
			force_first,
			force_last,
			force_left,
			force_left_cursor,
			force_right,
			force_right_cursor,		
			keep_first,
			keep_last,
			prune,
			prune_first,
			prune_last,
			prune_left_cursor,
			prune_right_cursor,
			put,
			put_first,
			put_last,
			put_left,
			put_left_cursor,
			put_right,
			put_right_cursor,
			remove,
			remove_at_cursor,
			remove_first,
			remove_last,
			remove_left_cursor,
			remove_right_cursor,
			replace,
			replace_at,
			replace_at_cursor,
			swap,
			wipe_out,
			new_cursor
		end

creation
	make


feature -- Access

	new_cursor: EPOM_BILINKED_LIST_CURSOR [G] is
			-- New external cursor for traversal
		do
			!! Result.make (Current)
		end

feature -- Element change

	append (other: DS_LINEAR [G]; i: INTEGER) is
			-- Add items of `other' at `i'-th position.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
			-- (Performance: O(i+other.count).)
			-- Was declared in DS_LINKED_LIST as synonym of `extend' and `append'.
		do
			Precursor (other, i)
			set_modified
		ensure then
			is_modified: is_modified
		end

	append_first (other: DS_LINEAR [G]) is
			-- Add items of `other' to beginning of list.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
			-- (Performance: O(other.count).)
			-- Was declared in DS_LINKED_LIST as synonym of `extend_first' and `append_first'.
		do
			Precursor (other)
			set_modified
		ensure then
			is_modified: is_modified
		end

	append_last (other: DS_LINEAR [G]) is
			-- Add items of `other' to end of list.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
			-- (Performance: O(other.count).)
			-- Was declared in DS_LINKED_LIST as synonym of `extend_last' and `append_last'.
		do
			Precursor (other)
			set_modified
		ensure then
			is_modified: is_modified
		end

	append_left (other: DS_LINEAR [G]) is
			-- Add items of `other' to left of internal cursor position.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
		do
			Precursor (other)
			set_modified
		ensure then
			is_modified: is_modified
		end

	append_left_cursor (other: DS_LINEAR [G]; a_cursor: like new_cursor) is
			-- Add items of `other' to left of `a_cursor' position.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
			-- (Synonym of `a_cursor.extend_left (other)'.)
			-- (Performance: O(other.count).)
			-- Was declared in DS_BILINKED_LIST as synonym of `extend_left_cursor' and `append_left_cursor'.
		do
			Precursor (other, a_cursor)
			set_modified
		ensure then
			is_modified: is_modified
		end

	append_right (other: DS_LINEAR [G]) is
			-- Add items of `other' to right of internal cursor position.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
		do
			Precursor (other)
			set_modified
		ensure then
			is_modified: is_modified
		end

	append_right_cursor (other: DS_LINEAR [G]; a_cursor: like new_cursor) is
			-- Add items of `other' to right of `a_cursor' position.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
			-- (Synonym of `a_cursor.extend_right (other)'.)
			-- (Performance: O(other.count).)
			-- Was declared in DS_LINKED_LIST as synonym of `extend_right_cursor' and `append_right_cursor'.
		do
			Precursor (other, a_cursor)
			set_modified
		ensure then
			is_modified: is_modified
		end

	extend (other: DS_LINEAR [G]; i: INTEGER) is
			-- Add items of `other' at `i'-th position.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
			-- (Performance: O(i+other.count).)
			-- Was declared in DS_LINKED_LIST as synonym of `extend' and `append'.
		do
			Precursor (other, i)
			set_modified
		ensure then
			is_modified: is_modified
		end

	extend_first (other: DS_LINEAR [G]) is
			-- Add items of `other' to beginning of list.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
			-- (Performance: O(other.count).)
			-- Was declared in DS_LINKED_LIST as synonym of `extend_first' and `append_first'.
		do
			Precursor (other)
			set_modified
		ensure then
			is_modified: is_modified
		end

	extend_last (other: DS_LINEAR [G]) is
			-- Add items of `other' to end of list.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
			-- (Performance: O(other.count).)
			-- Was declared in DS_LINKED_LIST as synonym of `extend_last' and `append_last'.
		do
			Precursor (other)
			set_modified
		ensure then
			is_modified: is_modified
		end

	extend_left (other: DS_LINEAR [G]) is
			-- Add items of `other' to left of internal cursor position.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
		do
			Precursor (other)
			set_modified
		ensure then
			is_modified: is_modified
		end

	extend_left_cursor (other: DS_LINEAR [G]; a_cursor: like new_cursor) is
			-- Add items of `other' to left of `a_cursor' position.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
			-- (Synonym of `a_cursor.extend_left (other)'.)
			-- (Performance: O(other.count).)
			-- Was declared in DS_BILINKED_LIST as synonym of `extend_left_cursor' and `append_left_cursor'.
		do
			Precursor (other, a_cursor)
			set_modified
		ensure then
			is_modified: is_modified
		end

	extend_right (other: DS_LINEAR [G]) is
			-- Add items of `other' to right of internal cursor position.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
		do
			Precursor (other)
			set_modified
		ensure then
			is_modified: is_modified
		end

	extend_right_cursor (other: DS_LINEAR [G]; a_cursor: like new_cursor) is
			-- Add items of `other' to right of `a_cursor' position.
			-- Keep items of `other' in the same order.
			-- Do not move cursors.
			-- (Synonym of `a_cursor.extend_right (other)'.)
			-- (Performance: O(other.count).)
			-- Was declared in DS_LINKED_LIST as synonym of `extend_right_cursor' and `append_right_cursor'.
		do
			Precursor (other, a_cursor)
			set_modified
		ensure then
			is_modified: is_modified
		end

	force (v: G; i: INTEGER) is
			-- Add `v' at `i'-th position.
			-- Do not move cursors.
			-- (Performance: O(i).)
			-- Was declared in DS_LINKED_LIST as synonym of `put' and `force'.
		do
			Precursor (v, i)
			set_modified
		ensure then
			is_modified: is_modified
		end

	force_first (v: G) is
			-- Add `v' to beginning of list.
			-- Do not move cursors.
			-- (Performance: O(1).)
			-- Was declared in DS_LINKED_LIST as synonym of `put_first' and `force_first'.
		do
			Precursor (v)
			set_modified
		ensure then
			is_modified: is_modified
		end

	force_last (v: G) is
			-- Add `v' to end of list.
			-- Do not move cursors.
			-- (Performance: O(1).)
			-- Was declared in DS_LINKED_LIST as synonym of `put_last' and `force_last'.
		do
			Precursor (v)
			set_modified
		ensure then
			is_modified: is_modified
		end

	force_left (v: G) is
			-- Add `v' to left of internal cursor position.
			-- Do not move cursors.
		do
			Precursor (v)
			set_modified
		ensure then
			is_modified: is_modified
		end

	force_left_cursor (v: G; a_cursor: like new_cursor) is
			-- Add `v' to left of `a_cursor' position.
			-- Do not move cursors.
			-- (Synonym of `a_cursor.put_left (v)'.)
			-- (Performance: O(1).)
			-- Was declared in DS_BILINKED_LIST as synonym of `put_left_cursor' and `force_left_cursor'.
		do
			Precursor (v, a_cursor)
			set_modified
		ensure then
			is_modified: is_modified
		end

	force_right (v: G) is
			-- Add `v' to right of internal cursor position.
			-- Do not move cursors.
		do
			Precursor (v)
			set_modified
		ensure then
			is_modified: is_modified
		end

	force_right_cursor (v: G; a_cursor: like new_cursor) is
			-- Add `v' to right of `a_cursor' position.
			-- Do not move cursors.
			-- (Synonym of `a_cursor.put_right (v)'.)
			-- (Performance: O(1).)
			-- Was declared in DS_LINKED_LIST as synonym of `put_right_cursor' and `force_right_cursor'.
		do
			Precursor (v, a_cursor)
			set_modified
		ensure then
			is_modified: is_modified
		end

	put (v: G; i: INTEGER) is
			-- Add `v' at `i'-th position.
			-- Do not move cursors.
			-- (Performance: O(i).)
			-- Was declared in DS_LINKED_LIST as synonym of `put' and `force'.
		do
			Precursor (v, i)
			set_modified
		ensure then
			is_modified: is_modified
		end

	put_first (v: G) is
			-- Add `v' to beginning of list.
			-- Do not move cursors.
			-- (Performance: O(1).)
			-- Was declared in DS_LINKED_LIST as synonym of `put_first' and `force_first'.
		do
			Precursor (v)
			set_modified
		ensure then
			is_modified: is_modified
		end

	put_last (v: G) is
			-- Add `v' to end of list.
			-- Do not move cursors.
			-- (Performance: O(1).)
			-- Was declared in DS_LINKED_LIST as synonym of `put_last' and `force_last'.
		do
			Precursor (v)
			set_modified
		ensure then
			is_modified: is_modified
		end

	put_left (v: G) is
			-- Add `v' to left of internal cursor position.
			-- Do not move cursors.
		do
			Precursor (v)
			set_modified
		ensure then
			is_modified: is_modified
		end

	put_left_cursor (v: G; a_cursor: like new_cursor) is
			-- Add `v' to left of `a_cursor' position.
			-- Do not move cursors.
			-- (Synonym of `a_cursor.put_left (v)'.)
			-- (Performance: O(1).)
			-- Was declared in DS_BILINKED_LIST as synonym of `put_left_cursor' and `force_left_cursor'.
		do
			Precursor (v, a_cursor)
			set_modified
		ensure then
			is_modified: is_modified
		end

	put_right (v: G) is
			-- Add `v' to right of internal cursor position.
			-- Do not move cursors.
		do
			Precursor (v)
			set_modified
		ensure then
			is_modified: is_modified
		end

	put_right_cursor (v: G; a_cursor: like new_cursor) is
			-- Add `v' to right of `a_cursor' position.
			-- Do not move cursors.
			-- (Synonym of `a_cursor.put_right (v)'.)
			-- (Performance: O(1).)
			-- Was declared in DS_LINKED_LIST as synonym of `put_right_cursor' and `force_right_cursor'.
		do
			Precursor (v, a_cursor)
			set_modified
		ensure then
			is_modified: is_modified
		end

	replace (v: G; i: INTEGER) is
			-- Replace item at index `i' by `v'.
			-- Do not move cursors.
			-- (Performance: O(2i).)
		do
			removed_items.force_last (item (i))
			Precursor (v, i)
			set_modified
		ensure then
			is_modified: is_modified
			new_removed_count: removed_items.count = old (removed_items.count) + 1
		end

	replace_at (v: G) is
			-- Replace item at internal cursor position by `v'.
			-- Do not move cursors.
		do
			Precursor (v)
			set_modified
		ensure then
			is_modified: is_modified
		end

	replace_at_cursor (v: G; a_cursor: like new_cursor) is
			-- Replace item at `a_cursor' position by `v'.
			-- Do not move cursors.
			-- (Synonym of `a_cursor.replace (v)'.)
		do
			Precursor (v, a_cursor)
			set_modified
		ensure then
			is_modified: is_modified
		end

	swap (i, j: INTEGER) is
			-- Exchange items at indexes i and j.
			-- Do not move cursors.
			-- (Performance: O(max(i,j)).)
		do
			Precursor (i, j)
			set_modified
		ensure then
			is_modified: is_modified
		end

feature -- Status report

	removed_items: DS_BILINKED_LIST[G] is
			-- List of removed items.
		do
			if removed_items_i = Void then
				!!removed_items_i.make
			end
			Result := removed_items_i
		end

	is_modified: BOOLEAN is
			-- Is this object modified since it's last retrieve or store command?
		do
			from
				Result := Precursor
				start
			until
				off or Result
			loop
				if item_for_iteration.is_modified then
					Result := True
				end
				forth
			end		 	
		end


feature -- Removal


	delete (v: G) is
			-- Remove all occurrences of `v'.
			-- (Use `equality_tester''s comparison criterion
			-- if not void, use `=' criterion otherwise.)
			-- Move all cursors `off'.
			-- (Performance: O(2count).)
		do
			if not is_empty then
				from
					start
					search_forth (v)
				until 
					after
				loop
					removed_items.force_last (item_for_iteration)
					search_forth (v)
				end
			end
			Precursor (v)
			set_modified
		ensure then
			is_modified: is_modified
			new_removed_count: removed_items.count = old (removed_items.count + occurrences(v))
		end;


	keep_first (n: INTEGER) is
			-- Keep `n' first items in list.
			-- Move all cursors `off'.
			-- (Performance: O(2n).)
		local
			i: INTEGER;
			j: INTEGER;
		do
			if n /= 0 and n /= count then
				from
					i := 1
					j := count - n
					finish
				until
					i > j
				loop
					removed_items.force_last (item_for_iteration)
					back
					i := i + 1
				end										
			else
				--| wipe_out managed removed_items
			end
			Precursor (n)
			set_modified
		ensure then
			is_modified: is_modified
			new_removed_count: removed_items.count = old (removed_items.count) + (old (count) - n)
		end;

	keep_last (n: INTEGER) is
			-- Keep `n' last items of list.
			-- Move all cursors `off'.
			-- (Performance: O(2n).)
		local
			i: INTEGER;
			j: INTEGER;
		do
			if n /= 0 and n /= count then
				from
					i := 1
					j := count - n
					start
				until
					i > j
				loop
					removed_items.force_last (item_for_iteration)
					forth
					i := i + 1
				end							
			else
				--| wipe_out managed removed_items
			end
			Precursor (n)
			set_modified
		ensure then
			is_modified: is_modified
			new_removed_count: removed_items.count = old (removed_items.count) + (old (count) - n)
		end;

	prune (n: INTEGER; i: INTEGER) is
			-- Remove `n' items at and after `i'-th position.
			-- Move all cursors `off'.
			-- (Performance: O(2i+2n).)
		local
			j: INTEGER
		do
			if i /= 1 and n /= 0 then
				from
					j := 1
					go_i_th (i)
				until
					j > n
				loop
					removed_items.force_last (item_for_iteration)
					forth
					j := j + 1
				end			
			else
				--| prune_first managed removed_items
			end
			Precursor (n, i)
			set_modified
		ensure then
			is_modified: is_modified
			new_removed_count: removed_items.count = old (removed_items.count) + n
		end; 

	prune_first (n: INTEGER) is
			-- Remove `n' first items from list.
			-- Move all cursors `off'.
			-- (Performance: O(2n).)
		local
			i: INTEGER;
		do
			if n /= count and n /= 0 then
				from
					i := 1
					start
				until
					i > n
				loop
					removed_items.force_last (item_for_iteration)
					forth
					i := i + 1
				end
			else
				--| wipe_out managed removed_items
			end
			Precursor (n)
			set_modified
		ensure then
			is_modified: is_modified
			new_removed_count: removed_items.count = old (removed_items.count) + n
		end;

	prune_last (n: INTEGER) is
			-- Remove `n' last items from list.
			-- Move all cursors `off'.
			-- (Performance: O(2n).)
		local
			i: INTEGER;
		do
			if count /= n and count /= 0 then
				from
					i := 1
					finish
				until
					i > n
				loop
					removed_items.force_last (item_for_iteration)
					back
					i := i + 1
				end			
			else
				--| wipe_out managed removed_items
			end
			Precursor (n) 
			set_modified
		ensure then
			is_modified: is_modified
			new_removed_count: removed_items.count = old (removed_items.count) +  n
		end;

	prune_left_cursor (n: INTEGER; a_cursor: like new_cursor) is
			-- Remove `n' items to left of `a_cursor' position.
			-- Move all cursors `off'.
			-- (Synonym of `a_cursor.prune_left (n)'.)
			-- (Performance: O(2n).)
		local
			i: INTEGER;
		do
			if not a_cursor.after and n /= 0 then
				from
					i := 1
					go_to (a_cursor)
				until
					i > n
				loop
					back
					removed_items.force_last (item_for_iteration)
					i := i + 1
				end
				
			else
				--| prune_last managed removed_persistent_items
			end
			Precursor (n, a_cursor)
			set_modified
		ensure then
			is_modified: is_modified
			new_removed_count: removed_items.count = old (removed_items.count) +  n
		end;

	prune_right_cursor (n: INTEGER; a_cursor: like new_cursor) is
			-- Remove `n' items to right of `a_cursor' position.
			-- Move all cursors `off'.
			-- (Synonym of `a_cursor.prune_right (n)'.)
			-- (Performance: O(2n).)
		local
			i: INTEGER;
		do
			if not a_cursor.before and n /= 0 then
				from
					i := 1
					go_to (a_cursor)
				until
					i > n
				loop
					forth
					removed_items.force_last (item_for_iteration)
					i := i + 1
				end
			else
				--| prune_first managed remove_items
			end
			Precursor (n, a_cursor)
			set_modified
		ensure then
			is_modified: is_modified
			new_removed_count: removed_items.count = old (removed_items.count) +  n
		end;

	remove (i: INTEGER) is
			-- Remove item at `i'-th position.
			-- Move any cursors at this position `forth'.
			-- (Performance: O(i).)
		do
			if i /= 1 and i /= count  then
				removed_items.force_last (item (i))
			else
				--| remove_first or remove_last manages removed_items
			end
			Precursor (i)
			set_modified
		ensure then
			is_modified: is_modified
			new_removed_count: removed_items.count = old (removed_items.count) + 1
		end;

	remove_at_cursor (a_cursor: like new_cursor) is
			-- Remove item at `a_cursor' position.
			-- Move any cursors at this position `forth'.
			-- (Synonym of `a_cursor.remove'.)
			-- (Performance: O(1).)
		do
			if not a_cursor.is_first and not a_cursor.is_last then
				removed_items.force_last (a_cursor.item)
			else
				--| remove_first or remove_last manages removed_items
			end
			Precursor (a_cursor)
			set_modified
		ensure then
			is_modified: is_modified
			new_removed_count: removed_items.count = old (removed_items.count) + 1
		end;

	remove_first is
			-- Remove item at beginning of list.
			-- Move any cursors at this position `forth'.
			-- (Performance: O(1).)
		do
			if count = 1 then
				--| wipe out managed removed items
			else
				removed_items.force_last (first)
			end
			Precursor
			set_modified
		ensure then
			is_modified: is_modified
			new_removed_count: removed_items.count = old (removed_items.count) + 1
		end;


	remove_last is
			-- Remove item at beginning of list.
			-- Move any cursors at this position `forth'.
			-- (Performance: O(1).)
		do
			removed_items.force_last (last)
			Precursor
			set_modified
		ensure then
			is_modified: is_modified
			new_removed_count: removed_items.count = old (removed_items.count) + 1
		end;


	remove_left_cursor (a_cursor: like new_cursor) is
			-- Remove item to left of `a_cursor' position.
			-- Move any cursors at this position `forth'.
			-- (Synonym of `a_cursor.remove_left'.)
			-- (Performance: O(1).)
		local
			left_cell: like first_cell
		do
			if a_cursor.after then
				--| feature remove_last will manage removed item
			else
				left_cell := a_cursor.current_cell.left
				if left_cell /= void then
					removed_items.force_last (left_cell.item)
				end
			end
			Precursor (a_cursor)
			set_modified
		ensure then
			is_modified: is_modified
			new_removed_count: removed_items.count = old (removed_items.count) + 1
		end;

	remove_right_cursor (a_cursor: like new_cursor) is
			-- Remove item to right of `a_cursor' position.
			-- Move any cursors at this position `forth'.
			-- (Synonym of `a_cursor.remove_right'.)
			-- (Performance: O(1).)
		local
			right_cell: like first_cell
		do
			if a_cursor.before then
				--| feature remove_first will manage removed item
			else
				right_cell := a_cursor.current_cell.right
				if right_cell /= void then
					removed_items.force_last (right_cell.item)
				end
			end
			Precursor (a_cursor)
			set_modified
		ensure then
			is_modified: is_modified
			new_removed_count: removed_items.count = old (removed_items.count) + 1
		end


	wipe_out is
			-- Remove all items from list.
			-- Move all cursors `off'.
			-- (Performance: O(1).)
		do
			from
				start
			until
				off
			loop
				removed_items.force_last (item_for_iteration)
				forth
			end
			Precursor
			set_modified
		ensure then
			is_modified: is_modified
			new_removed_count: removed_items.count = old (removed_items.count) + old (count)
		end;



feature {NONE} -- Implementation

	removed_items_i: DS_BILINKED_LIST [G]


end -- class EPOM_BILINKED_LIST

--
-- Copyright: 2001, Eric Fafchamps, <eric.fafchamps@belgacom.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
