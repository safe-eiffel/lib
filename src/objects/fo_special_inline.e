indexing

	description: 
	
		"Inline whose text is computed."

	library: "FO - Formatting Objects in Eiffel. Project SAFE."
	copyright: "Copyright (c) 2006 - , Paul G. Crismer and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"

deferred class FO_SPECIAL_INLINE

inherit
	FO_INLINE
		
feature {FO_DOCUMENT, FO_RENDERABLE}-- Basic operations

	update_text (document : FO_DOCUMENT; region: FO_RECTANGLE) is
			-- Update text for `document' in `region'.
		require
			document_not_void: document /= Void
			document_is_open: document.is_open
			region_not_void: region /= Void
		deferred
		end
		
end

