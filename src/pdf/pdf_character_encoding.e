indexing

	description: "Character Encodings.  Map glyph names to character codes. Use Adobe character names."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."
	
deferred class

	PDF_CHARACTER_ENCODING
		
feature -- Access

	code_of_name (glyph_name : STRING) : INTEGER is
			-- integer code for `glyph_name'
		require
			glyph_name_not_void: glyph_name /= Void
			exists_in_encoding: has_name (glyph_name)
		do
			Result := name_to_code.item (glyph_name)
		end
		
	name : PDF_NAME is
			-- encoding name
		deferred
		end

feature -- Status Report

	has_name (glyph_name : STRING) : BOOLEAN is
			-- does this encoding contain a glyph whose name is `glyph_name'
		require
			glyph_name_not_void: glyph_name /= Void
		do
			Result := name_to_code.has (glyph_name)
		end
		
feature {NONE} -- Implementation

	name_to_code : DS_HASH_TABLE [INTEGER, STRING] is
			-- table of codes for glyph name
		deferred
		end
				
end -- class PDF_CHARACTER_ENCODING
