indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FO_CHARACTER_REFERENCE

create
	make

feature -- Initialization

	make (an_inline : FO_INLINE; a_position : INTEGER) is
		require
			an_inline_not_void: an_inline /= Void
			a_position_within_inline: a_position >= 1 and a_position <= an_inline.text.count
		do
			inline := an_inline
			position := a_position
		end

feature -- Access

	inline : FO_INLINE

	position : INTEGER

feature -- Status report

	off : BOOLEAN is do Result := before or after end

	before : BOOLEAN is do Result := position = 0 end

	after : BOOLEAN is do Result := position > inline.text.count end

feature -- Basic operations

	back is
			-- back one character if possible
		require
			back_possible: position >= 1
		do
			position := position - 1
		ensure
			one_character_back: position = old position - 1
		end

	forth is
			-- forth one character
		require
			forth_possible: position <= inline.text.count
		do
			position := position + 1
		ensure
			one_character_forth: position = old position + 1
		end

invariant

	inline_not_void: inline /= Void
	position_within_inline: not off implies (position >= 1 and position <= inline.text.count)

end
