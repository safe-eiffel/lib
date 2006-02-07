indexing
	description: "PDF Viewer preferences."
	author: "Paul G. Crismer"
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_VIEWER_PREFERENCES

inherit
	PDF_OBJECT
		redefine
			put_pdf
		end

creation
	make
	
feature -- Access

feature -- Measurement

	is_empty : BOOLEAN is
			-- 
		do
			Result := is_hide_tool_bar or else is_hide_menu_bar or else is_hide_window_ui or else is_fit_window or else is_center_window or else is_display_document_title
			Result := not Result	
		end
		
feature -- Status report
	
	is_hide_tool_bar : BOOLEAN
	is_hide_menu_bar : BOOLEAN
	is_hide_window_ui : BOOLEAN
	is_fit_window : BOOLEAN
	is_center_window : BOOLEAN
	is_display_document_title : BOOLEAN

feature -- Status setting

	hide_tool_bar is
			-- hide the viewer application’s tool bars when the document is active.
		do
			is_hide_tool_bar := True
		ensure
			is_hide_tool_bar
		end
		
	hide_menu_bar is
			-- hide the viewer application’s menu bar when the document is active.
		do
			is_hide_menu_bar := True
		ensure
			is_hide_menu_bar
		end
		
	hide_window_ui is
			-- hide user interface elements in the document’s window 
			-- (such as scroll bars and navigation controls), leaving only the document’s contents displayed.
		do
			is_hide_window_ui := True
		ensure
			is_hide_window_ui
		end
		
	fit_window is
			-- resize the document’s window to fit the size of the first displayed page.
		do
			is_fit_window := True
		ensure
			is_fit_window
		end
		
	center_window is
			-- position the document’s window in the center of the screen.
		do
			is_center_window := True
		ensure
			is_center_window
		end
		
	display_document_title is
			-- the window’s title bar should display the document title taken from 
			-- the Title entry of the document information dictionary.
			-- If false, the title bar should instead display the name of the PDF file containing the document.
		do
			is_display_document_title := True
		ensure
			is_display_document_title
		end
		
	show_tool_bar is
		do
			is_hide_tool_bar := False
		ensure
			not is_hide_tool_bar
		end
		
	show_menu_bar is
		do
			is_hide_menu_bar := False
		ensure
			not is_hide_menu_bar
		end
		
	show_window_ui is
		do
			is_fit_window := False
		ensure
			not is_fit_window 
		end
		
	dont_fit_window is
		do
			is_fit_window := False
		ensure
			not is_fit_window
		end
		
	dont_center_window is
		do
			is_center_window := False
		ensure
			not is_center_window
		end
		
	dont_display_document_title is
		do
			is_display_document_title := False
		ensure
			not is_display_document_title
		end

feature -- Conversion

	to_pdf : STRING is
			-- 
		do
			Result := to_pdf_using_put_pdf			
		end
		
	put_pdf (medium: PDF_OUTPUT_MEDIUM) is
			-- put PDF code on `medium'
		local
			pdf_true : STRING
			name : PDF_NAME
		do
			pdf_true := "true"
			medium.put_string (object_header)
			medium.put_string (Begin_dictionary)
			--HideToolbar
			if is_hide_tool_bar then
				create name.make ("HideToolbar")
				medium.put_string (dictionary_entry (name, pdf_true))
			end
			--HideMenubar
			if is_hide_menu_bar then
				create name.make ("HideMenubar")
				medium.put_string (dictionary_entry (name, pdf_true))
			end
			--HideWindowUI
			if is_hide_window_ui then
				create name.make ("HideWindowUI")
				medium.put_string (dictionary_entry (name, pdf_true))
			end
			--FitWindow
			if is_fit_window then
				create name.make ("FitWindow")
				medium.put_string (dictionary_entry (name, pdf_true))
			end
			--CenterWindow
			if is_center_window then
				create name.make ("CenterWindow")
				medium.put_string (dictionary_entry (name, pdf_true))
			end
			--DisplayDocTitle
			if is_display_document_title then
				create name.make ("DisplayDocTitle")
				medium.put_string (dictionary_entry (name, pdf_true))
			end
			medium.put_string (End_dictionary)
			medium.put_string (Object_footer)
		end


end -- class PDF_VIEWER_PREFERENCES
