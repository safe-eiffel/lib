deferred class
	GRAPHVIZ_FIGURE
	
feature
	draw_pdf (a_page : PDF_PAGE) is
		require
			a_page /= Void
		deferred
		end
		
end -- class GRAPHVIZ_FIGURE