indexing
	description:

		"Blocks that are header or footer of documents."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

class FO_HEADER_FOOTER

inherit
	FO_BLOCK
		rename
			make as make_block
		redefine
			append, render_start
		end

create
	make

feature {NONE} -- Initialization

	make (new_margins: FO_MARGINS; new_separation : FO_MEASUREMENT) is
				-- Make with `new_margins' and `new_separation' from page region.
		require
			new_margins_not_void: new_margins /= Void
			new_separation_not_void: new_separation /= Void
		do
			create special_inlines.make
			separation := new_separation
			make_block (new_margins)
		end

feature -- Access

	separation : FO_MEASUREMENT
			-- Distance between page region and beginning/end of header/footer.

feature -- Measurement

feature -- Comparison

feature -- Status report

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

	append (new_inline: FO_INLINE) is
			-- <Precursor>
		local
			special : FO_SPECIAL_INLINE
		do
			special ?= new_inline
			if special /= Void then
				special_inlines.put_last (special)
			end
			Precursor (new_inline)
		end

feature {FO_DOCUMENT, FO_RENDERABLE} -- Basic operations

	render_start (document: FO_DOCUMENT; region: FO_RECTANGLE) is
		do
			update_specials (document, region)
			Precursor (document, region)
		end

feature -- Obsolete

feature -- Inapplicable

feature -- Constants

feature {NONE} -- Implementation

	update_specials (document : FO_DOCUMENT; region: FO_RECTANGLE) is
			-- Update special inlines within the context of `document' and `region'.
		local
			cursor : DS_LIST_CURSOR[FO_SPECIAL_INLINE]
		do
			from
				cursor := special_inlines.new_cursor
				cursor.start
			until
				cursor.off
			loop
				cursor.item.update_text (document, region)
				cursor.forth
			end
		end

	special_inlines : DS_LINKED_LIST[FO_SPECIAL_INLINE]
			-- Special inlines to take care of.

invariant
	special_inlines_not_void: special_inlines /= Void
	
end


