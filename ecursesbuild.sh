#!/bin/bash
# -- ECURSES build procedure
# -- (c) 2000 - Paul G. Crismer, Eric Fafchamps
# -- Released under the Eiffel-Forum Licence : see forum.txt


echo "** ECURSES build procedure **"

function targeterr () {
	echo    Missing argument "target-class";
	usage;
}

function creationerr () {
	echo    Missing argument "creation-feature";
	usage ;
}

function usage () {
	echo Usage : "ecursesbuild <target-class> <creation-feature>";
	exit 1
}

function varecurseserr () {
	echo Error : ECURSES variable not set !;
	usage;
}

# -- path of ECURSES
if test -z "$ECURSES" ; then 
  varecurseserr 
fi

# -- compilation variables
export LIBS='-lpanel -lncurses $ECURSES/spec/se/linux/libecurses_c.a'
export SEFLAGS='-case_insensitive -no_style_warning'
export BUILDFLAGS='-I$ECURSES/spec/se/linux'

#
# -- Test for target and creation feature
#
echo $1 $2

if test -z "$1" ; then
	targeterr 
fi

TARGET=$1

if test -z "$2" ; then
	creationerr 
fi

CREATION=$2

echo "*  Building $TARGET creation $CREATION"

# -- Compile
set -v 
compile $SEFLAGS $BUILDFLAGS $LIBS $TARGET $CREATION
mv a.out $1
echo all done !

 
