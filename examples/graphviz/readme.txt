Graphviz_pdf

-- ePDF example application
-- Released under the Eiffel Forum license version 1
-- (c) Copyright 2002-2003 Paul G. Crismer

Reads graphviz -plain format files.
Generates a PDF file with some limitations (mainly arrow drawing).

Example : graphviz_pdf -input fsm.pln -output fsm.pdf
	Generates a finite state automaton graph.
	
Usage :
	graphviz_pdf -output outfilename [-input infilename] [-margin m] [-scaling s|-scale s
	
-output <of>	'of' is output file name
-input <if>	'if' is input file name
-margin <m>	'm' is the page margin in points (1/72 inch)
-scaling <s>	's' is the scaling factor (1 is 100%)

If graph is too large for one page (A4 for the moment), graph is split into as many pages as
necessary.  Page marks indicate where the pages must be assembled.

Usage:

dot -Tplain | graphviz_pdf -output <pdffilename>.pdf -scale <scalefactor> -margin <margin_in_points>


