This directory contains

* makefile.lcc	
	makefile for making epdf_lcc.lib
	
* zlib_makefile.lcc
	makefile for making zlib_lcc.lib a zlib library for lcc.
	To create it : 
	 1- copy zlib_makefile.lcc in the zlib directory
	 2- cd to zlib directory
	 3- invoke make -f zlib_makefile.lcc clean
	 4- invoke make -f zlib_makefile.lcc zlib_lcc.lib
	
* libpng_makefile.lcc
	makefile for making libpng_lcc.lib : a libpng library for lcc
	To create it :
	 1- copy libpng_makefile.lcc in the libpng directory
	 2- cd to libpng directory
	 3- invoke make -f libpng_makefile.lcc clean
	 4- invoke make -f libpng_makefile.lcc libpng_lcc.lib
	 
