indexing

	description: "Adobe standard (one of the...) 14 PDF font."
	author: "Paul G. Crismer"
	licence: "Release under the Eiffel Forum licence.  See file 'forum.txt'."

deferred class

	PDF_ADOBE14_FONT

inherit

	PDF_FONT
		rename
			make as make_object
		end


feature -- Initialization

	make (a_number : INTEGER; an_encoding : PDF_CHARACTER_ENCODING) is
			-- make as PDF object number `a_number', for encoding `an_encoding'
		require
			a_number_positive: number >= 0
			an_encoding_exists: an_encoding /= Void
		do
			make_object (a_number)
			encoding := an_encoding
			build_widths
		ensure
			number_set: number = a_number
			encoding_set: encoding = an_encoding
		end
		
feature -- Access
	
	subtype : PDF_NAME is
			-- Subtype
		once
			!!Result.make ("Type1")
		end
			
	firstchar : INTEGER is
		do
			Result := widths.lower
		end
		
	lastchar : INTEGER is
		do
			Result := widths.upper
		end
		
	widths : PDF_ARRAY [INTEGER] is
		do
			Result := widths_impl
		end
		
	encoding : PDF_CHARACTER_ENCODING
	
feature -- Conversion

	to_pdf : STRING is
		local
			ntype, nsubtype, nbasefont,nencoding,nname: PDF_NAME
		do
			!!Result.make (0)
			!!ntype.make ("Type")
			!!nsubtype.make ("Subtype")
			!!nbasefont.make ("BaseFont")
			!!nencoding.make ("Encoding")
			!!nname.make ("Name")
			Result.append_string (object_header)
			Result.append_string (begin_dictionary)
			-- Type
			Result.append_string (dictionary_entry (ntype, type.to_pdf))
			-- SubType
			Result.append_string (dictionary_entry (nsubtype, subtype.to_pdf))			
			-- BaseFont 
			Result.append_string (dictionary_entry (nbasefont, basefont.to_pdf))
			-- Encoding
			Result.append_string (dictionary_entry (nencoding, encoding.name.to_pdf))
			Result.append_string (end_dictionary)
			Result.append_string (object_footer)
		end
		
feature {NONE} -- Implementation

	widths_impl : PDF_ARRAY[INTEGER]

	name_to_width : DS_HASH_TABLE [INTEGER,STRING] is
		deferred
		end
		
	build_widths is
			-- build widths array depending on the character encoding and on
			-- the font metrics
			-- unsupported characters have a width of 255
		local
			code : INTEGER
			character_name : STRING
		do
			!!widths_impl.make (0, 255)
			-- initialize with a "dummy" width
			from
				code := 0
			until
				code > 255
			loop
				widths_impl.put (255, code)
				code := code + 1
			end
			-- create array from encoding and name_to_width
			from
				name_to_width.start
			until
				name_to_width.off
			loop
				character_name := name_to_width.key_for_iteration
				if encoding.has_name (character_name) then
					code := encoding.code_of_name (character_name)
					if code >= 0 then
						widths_impl.put (name_to_width.item_for_iteration, code)
					end
				end
				name_to_width.forth
			end
		end
		
invariant

	invariant_clause: -- Your invariant here

end -- class PDF_ADOBE14_FONT
