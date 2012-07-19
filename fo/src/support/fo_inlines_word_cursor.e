indexing

	description:

		"Cursor on words among a sequence of inlines."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class FO_INLINES_WORD_CURSOR

create
	make

feature {NONE} -- Initialization

	make (inlines : DS_LIST[FO_INLINE]) is
		do
			internal_cursor := inlines.new_cursor
		end

feature -- Access

	item_text : STRING is
		do
			Result := word_text
		end


	item_width : FO_MEASUREMENT is
		do
			Result := word_width
		end

	item_height : FO_MEASUREMENT is
		do
			Result := word_height
		end

	item_begin : FO_CHARACTER_REFERENCE is
		do
			Result := word_begin
		end

	item_end : FO_CHARACTER_REFERENCE is
		do
			Result := word_end
		end

	item_inlines : DS_LIST[FO_INLINE] is
		do
			Result := word_inlines
		end

	item_character (n : INTEGER) : FO_CHARACTER_REFERENCE is
			-- Coordinates of n-th character of current word.
		require
			n_positive: n > 0
			n_less_text_count: n <= item_text.count
			not_item_empty: not item_empty
		local
			count, i : INTEGER
			c : DS_LIST_CURSOR[FO_INLINE]
		do
			from
				c := item_inlines.new_cursor
				c.start
				count := 0
			until
				c.off or else count = n
			loop
				from
					if count = 0 then
						i := word_begin.position
					else
						i := 1
					end
				until
					count = n or else i > c.item.count or else c.off
				loop
					i := i + 1
					count := count + 1
				end
				if count < n then
					c.forth
				end
			end
			if count = n then
				create Result.make (c.item, i - 1)
			end
		end

	last_hyphen : CHARACTER

feature -- Measurement

	prefix_width_hyphenated (prefix_end : INTEGER; hyphen : CHARACTER) : FO_MEASUREMENT is
			-- width of word prefix [1..prefix_end] + hyphen.
		require
			prefix_end_valid: prefix_end > 0 and prefix_end <= item_text.count
		local
			pair : DS_PAIR[FO_MEASUREMENT,FO_MEASUREMENT]
		do
			pair := prefix_extra_width (prefix_end, hyphen)
			Result := pair.first + pair.second
		end

	prefix_width (prefix_end : INTEGER) : FO_MEASUREMENT is
		do
			Result := prefix_extra_width (prefix_end, '%U').first
		end

feature -- Comparison

feature -- Status report

	off : BOOLEAN is
		do
			Result := word_off
		end

	item_empty : BOOLEAN

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	hyphenate (h : FO_HYPHENATION; width : FO_MEASUREMENT) is
			-- Hyphenate current word so that current item is less than `width'
			-- If hyphenation is not possible, current item is cut so that it is less than width
		require
			h_not_void: h /= Void
			width_not_void: width /= Void
			width_positive: width > width.zero
		local
			last_end : INTEGER
			hy_width, last_width : FO_MEASUREMENT
			points_cursor : DS_LIST_CURSOR[INTEGER]
			done : BOOLEAN
		do
			h.hyphenate (item_text)
			from
				points_cursor := h.hyphenation_points.new_cursor
				points_cursor.finish
				if points_cursor.after then
					points_cursor.back
				end
				last_end := 0
				create last_width.make_zero
			until
				points_cursor.before or else done
			loop
				hy_width := prefix_width_hyphenated (points_cursor.item, h.hyphen)
				if hy_width < width then
					last_end := points_cursor.item
					done := True
				end
				points_cursor.back
			end
			if not done then
				keep_head_not_greater (width)
				last_hyphen := '%U'
			else
				last_hyphen := h.hyphen
				keep_head (last_end)
--				word_width := word_width + word_inlines.last.character_width (h.hyphen)
			end
		end

	keep_head_not_greater (width : FO_MEASUREMENT) is
			-- Keep head of word not larger than `width'.
			-- The next `forth' operation shall make the remaining of the word.
		require
			width_less_item_width: width /= Void and (width < item_width)
		local
			wbegin : like word_begin
			wcount : INTEGER
			wwidth, cwidth : FO_MEASUREMENT
			done : BOOLEAN
			cpair, cpairlast : FO_CHARACTER_REFERENCE
			wtext : STRING
			c : CHARACTER
		do
			--| find longest prefix whose length <= width
			from
				create wwidth.points (0)
				wcount := 1
				create wbegin.make (word_begin.inline, word_begin.position)
				create wtext.make (item_text.count)
				done := False
			until
				done or else wcount > item_text.count
			loop
				cpair := item_character (wcount)
				c := cpair.inline.item (cpair.position)
				cwidth := cpair.inline.character_width (c)
				if wwidth + cwidth > width then
					done := True
				else
					cpairlast := cpair
					wtext.append_character (c)
					wwidth := wwidth + cwidth
					wcount := wcount + 1
				end
			end
			--| always one character too far
			wcount := wcount - 1
			if wcount = 0 then
				keep_head_zero
			elseif wcount <= item_text.count then
				keep_head (wcount)
			end
		ensure
			item_width_le_width: item_width <= width
		end

	keep_head (wcount : INTEGER) is
			-- Keep `wcount' characters of current word
		require
			wcount_positive: wcount > 0
			wcount_less_text_count: wcount <= item_text.count
		local
			cpairlast : FO_CHARACTER_REFERENCE
			wwidth : FO_MEASUREMENT
		do
			--| keep w_count characters
			cpairlast := item_character (wcount)
--				check done: done end
			--| [wcount + 1 ..] = remaining word
			remaining_subword_begin := item_character (wcount + 1)
			remaining_subword_end := word_end
			--| [1..wcount] = new word.
			word_end := cpairlast
			from
				item_inlines.start
			until
				item_inlines.off or else item_inlines.item_for_iteration = word_end.inline
			loop
				item_inlines.forth
			end
			create {DS_LINKED_LIST[FO_INLINE]}remaining_subword.make
			if word_end.inline = remaining_subword_begin.inline then
				remaining_subword.put_last (word_end.inline)
			end
			--| save then remove inlines for remaining_subword							
			from
				item_inlines.forth
			until
				item_inlines.off
			loop
				remaining_subword.put_last (item_inlines.item_for_iteration)
				item_inlines.remove_at
			end
			wwidth := prefix_width (wcount)
			remaining_subword_width := item_width - wwidth
			remaining_subword_height := item_height
			word_width := wwidth
			remaining_subword_text := item_text.substring (wcount + 1, item_text.count)
			word_text := item_text.substring (1, wcount)
		ensure
			word_text_head: word_text.is_equal ((old word_text).substring (1, wcount))
		end

	keep_head_zero is
		do
			remaining_subword_begin := item_character (1)
			remaining_subword_end := word_end
			remaining_subword_width := item_width
			remaining_subword_height := item_height
			remaining_subword_text := item_text.substring (1, item_text.count)
			create word_width.make_zero
			word_end := word_begin.twin
			word_text := ""
			from
				item_inlines.start
			until
				item_inlines.off or else item_inlines.item_for_iteration = word_end.inline
			loop
				item_inlines.forth
			end
			create {DS_LINKED_LIST[FO_INLINE]}remaining_subword.make
			if word_end.inline = remaining_subword_begin.inline then
				remaining_subword.put_last (word_end.inline)
			end
			--| save then remove inlines for remaining_subword							
			from
				item_inlines.forth
			until
				item_inlines.off
			loop
				remaining_subword.put_last (item_inlines.item_for_iteration)
				item_inlines.remove_at
			end
			item_empty := True
		end

--	keep_head_hyphenated (prefix_end : INTEGER; hyphen : CHARACTER) is
--		do
--			keep_head (prefix_end)
--			last_hyphen := hyphen
--		end

	append_item (line : FO_LINE) is
			-- append item to `line'.
		local
			item_inlines_cursor : DS_LIST_CURSOR[FO_INLINE]
			pos_begin, pos_end : INTEGER
		do
			if item_begin.inline = item_end.inline then
				-- One inline from begin to end
				pos_begin := item_begin.position
				pos_end := item_end.position.min (item_end.inline.count)
				if not item_empty and then pos_begin <= pos_end then
					line.add_inline (item_begin.inline.substring (pos_begin,pos_end))
				else
					do_nothing
				end
			else
				-- More than one inline from begin to end
				-- . Iterate over item inlines
				from
					item_inlines_cursor := item_inlines.new_cursor
					item_inlines_cursor.start
				until
					item_inlines_cursor.off
				loop
					if item_inlines_cursor.item = item_begin.inline then
						line.add_inline (item_begin.inline.substring (item_begin.position, item_begin.inline.count))
					elseif item_inlines_cursor.item = item_end.inline then
						line.add_inline (item_end.inline.substring (1, item_end.position))
					else
						line.add_inline (item_inlines_cursor.item)
					end
					item_inlines_cursor.forth
				end
			end
			if last_hyphen /= '%U' then
				line.append_character (last_hyphen)
			end
			last_hyphen := '%U'
		end

	start is
		do
			item_empty := False
			word_start
		end

	forth is
		do
			item_empty := False
			word_forth
		end

feature -- Obsolete

feature -- Inapplicable

feature -- Constants

feature {NONE} -- Implementation

	remaining_subword : like word_inlines

	remaining_subword_begin : like word_begin
	remaining_subword_end : like word_end
	remaining_subword_text : like item_text
	remaining_subword_width : like item_width
	remaining_subword_height : like item_height

	word_start is
		do
			internal_cursor.start
			word_state := state_start
			if not internal_cursor.off then
				word_off := False
				create word_begin.make (internal_cursor.item, 1)
				get_word
			else
				word_off := True
			end
		ensure
			consistent_position: not word_off implies (word_begin.inline = word_end.inline implies word_begin.position <= word_end.position)
		end

	word_forth is
		require
			not word_off
		do
			if next_word_begin /= Void then
				word_begin := next_word_begin.twin
			else
				--| FIXME
			end
			get_word

		ensure
			consistent_position: not word_off implies (word_begin.inline = word_end.inline implies word_begin.position <= word_end.position)
		end

	word_off : BOOLEAN

	state_nl : INTEGER is 10
	state_start : INTEGER is 0
	state_word_letter : INTEGER is 1
	state_word_blank : INTEGER is 2
	state_done : INTEGER is 100

	word_state : INTEGER

	word_done : BOOLEAN

	get_word is
		local
			c : CHARACTER
		do
			if remaining_subword /= Void then
				word_begin := remaining_subword_begin
				word_end := remaining_subword_end
				word_inlines := remaining_subword
				word_text := remaining_subword_text
				word_width := remaining_subword_width
				word_height := remaining_subword_height
				remaining_subword := Void
				remaining_subword_begin := Void
				remaining_subword_end := Void
				remaining_subword_height := Void
				remaining_subword_text := Void
				remaining_subword_width := Void
			else
				create {DS_LINKED_LIST[FO_INLINE]}word_inlines.make
				create word_end.make (word_begin.inline, word_begin.position)
				create word_text.make (100)
				create word_width.points (0)
				create word_height.points (0)
				from
					--| sweep through different inlines
					word_done := False
					must_consume_last_char := False
				until
					internal_cursor.off or else word_done
				loop
					from
						--| sweep through characters in same inline
					until
						word_end.position > internal_cursor.item.count or else word_done
					loop
						c := internal_cursor.item.item (word_end.position)
						handle_state (c)
					end
					forth_internal_cursor
				end
				if internal_cursor.off then
				    if word_text.is_empty and not must_consume_last_char then
						word_off := True
					else
						handle_state (last_char)
					end
				end
				if not word_off then
					if word_end /= Void and then word_begin.inline = word_end.inline
						and then word_begin.position = word_begin.inline.count and then word_end.position < word_begin.position then
						word_off := True
					end
	--			print (word_text)
	--			print (c_new_line)
	--			io.read_line
				end
			end
		end

	handle_state (c : CHARACTER) is
		do
			inspect word_state
			when state_nl then
				handle_nl_state (c)
			when state_word_letter then
				handle_wl_state (c)
			when state_word_blank then
				handle_wb_state (c)
			else
				handle_start (c)
			end
		end

	handle_start (c : CHARACTER) is
		do
			if is_new_line_character (c) then
				word_state := state_nl
			elseif is_break_character (c) then
				word_state := state_word_blank
			else
				word_state := state_word_letter
			end
			forth_word_end
			set_last_char (c)
		end

	handle_nl_state (c : CHARACTER) is
		do
			word_finish
			create word_width.make_zero
			word_state := state_start
			set_last_char (c)
		end

	handle_wl_state (c: CHARACTER) is
		do
			if is_new_line_character (c) then
				word_finish
				word_state := state_start
			elseif is_break_character (c) then
				word_finish
--				word_append_last_char
				word_state := state_start -- state_word_blank
			else
				word_append_last_char
				word_state := state_word_letter
			end
			set_last_char (c)
		end

	handle_wb_state (c: CHARACTER) is
		do
			if is_new_line_character (c) then
				word_finish
				word_state := state_start
			elseif is_break_character (c) then
				word_finish
--				word_append_last_char
				word_state := state_start -- state_word_blank
			else
				word_finish
				word_state := state_start
			end
			set_last_char (c)
		end

	word_finish is
			-- finish current word appending last_char to it
		do
			word_text.append_character (last_char)
			must_consume_last_char := False
			word_width := word_width + word_end.inline.character_width (last_char)
			word_height := word_height.max (word_end.inline.font.bounding_box.height)
			if word_end.position > 1 then
				create next_word_begin.make (word_end.inline, word_end.position)
				word_end.back
			else
				create next_word_begin.make (word_end.inline, 1)
				if last_word_end /= Void then
					word_end := last_word_end
				end
			end
			word_done := True
		end

	word_append_last_char is
		do
			word_text.append_character (last_char)
			must_consume_last_char := False
			word_width := word_width + last_char_inline.character_width (last_char)
			word_height := word_height.max (last_char_inline.font.bounding_box.height)
			forth_word_end
		end

	forth_word_end is
		do
			if not internal_cursor.off then
				word_end.forth
			end
		end

	forth_internal_cursor is
		do
			if not word_done then
--				--| Add current internal_cursor.item to word
--				word_item.put_last (last_char_inline)
				--| Advance to next inline
				internal_cursor.forth
				if not internal_cursor.off then
					if word_end.position - 1 > 0 then
						create last_word_end.make (word_end.inline, word_end.position - 1)
					else
						last_word_end := word_end.twin
					end
					word_end.make (internal_cursor.item, 1)
				else
					--| adjust end
					word_end.back
				end
			end
		end

	internal_cursor : DS_LIST_CURSOR[FO_INLINE]

	word_inlines : DS_LIST[FO_INLINE]

	word_length : INTEGER
	word_text : STRING

	word_begin : FO_CHARACTER_REFERENCE
	word_end : FO_CHARACTER_REFERENCE

	word_height : FO_MEASUREMENT

	next_word_begin : FO_CHARACTER_REFERENCE

	last_char : CHARACTER
	last_char_inline : FO_INLINE

	set_last_char (c: CHARACTER) is
		do
			last_char := c
			if not internal_cursor.off then
				last_char_inline := internal_cursor.item
				if not word_inlines.has (last_char_inline) then
					word_inlines.put_last (last_char_inline)
				end
			end
			must_consume_last_char := True
		end

	must_consume_last_char : BOOLEAN

	last_word_end : FO_CHARACTER_REFERENCE

	word_width : FO_MEASUREMENT

	render_cursor : DS_LIST_CURSOR[FO_LINE]

	is_break_character (c : CHARACTER) : BOOLEAN is
		do
			inspect c
			when ' ', '%T', '-', '/' then
				Result := True
			else

			end
		end

	is_new_line_character (c : CHARACTER) : BOOLEAN is
		do
			inspect c
			when '%N' then
				Result := True
			else

			end
		end

	is_discardable_character (c : CHARACTER) : BOOLEAN is
		do
		end

	prefix_extra_width (prefix_end : INTEGER; extra : CHARACTER) : DS_PAIR[FO_MEASUREMENT, FO_MEASUREMENT] is
		require
			prefix_end_valid: prefix_end > 0 and prefix_end <= item_text.count
		local
			index : INTEGER
			character : FO_CHARACTER_REFERENCE
			p_width, e_width : FO_MEASUREMENT
		do
			create p_width.points (0)
			from
				index := 1
			until
				index > prefix_end
			loop
				character := item_character (index)
				p_width := p_width + character.inline.character_width (character.inline.item (character.position))
				index := index + 1
			end
			if character /= Void and then extra /= '%U' then
				e_width := character.inline.character_width (extra)
			else
				create e_width.points (0)
			end
			create Result.make (p_width, e_width)
		end

end
