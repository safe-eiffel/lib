
		EPDF	
an Eiffel library for producing PDF
(c) 2001-2003 Paul-Georges Crismer

Released under the Eiffel forum license
	See file 'forum.txt'

Installation: 
- copy directory structure

Library usage:
- GOBO (3.1 or 3.2)

- Zlib (http://www.zlib.org)
- Libpng (http://www.libpng.org/pub/png/)

Tools usage:
- GOBO gexace for producing multi-platform assembly files
- GOBO geant for automating builds

Variables:
- SAFE_KERNEL		path of SAFE kernel library
- EPDF			Path of the EPDF library
- SMARTEIFFELDIR 	Path of SmartEiffel if you are using it
- GOBO			Path of GOBO
- GOBO_CC		C compiler : msc, lcc, gcc, bcc
- GOBO_EIFFEL		Eiffel compiler
- ZLIB			Path to Zlib library header files
- ZLIB_LIB		full filename including path of ZLIB library
- LIBPNG		Path to LIBPNG library header files
- LIBPNG_LIB		full filename including path of LIBPNG library

Installation
- 1) generate the SAFE_KERNEL runtime library
   * cd to $SAFE_KERNEL directory
   * type 'geant install'
   
- 2) build example 'show_epdf'
   * cd to $EPDF/examples/show_epdf directory
   * type 'geant install'
   * type 'geant compile'
 
- *) If you are using lcc-win32 and do not have a compiled version of
     zlib nor libpng, you should find the following makefiles in
     $EPDF/src/spec/se/windows : libpng_makefile.lcc and zlib_makefile.lcc.
     
Samples:
- See directory 'examples'
- Look at 'show_epdf' application for a start

Documentation:
- Not for the moment.  See 'doc' directory for miscellaneous files.

Tested:
- ISE 5.2, 5.3
- SmartEiffel 1.0, SmartEiffel 1.1
- VisualEiffel 4.1


