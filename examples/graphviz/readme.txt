Reads graphviz -plain format files.
'graphviz_pdf' outputs corresponding PDF, with some limitations (mainly arrow drawing).

Usage:

dot -Tplain | graphviz_pdf -output <pdffilename>.pdf -scale <scalefactor> -margin <margin_in_points>


