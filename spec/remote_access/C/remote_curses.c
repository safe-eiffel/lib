/*************************************************************
	REMOTE_CURSES.C
	
	helper functions to convert EIF_POINTER from/to EIF_INTEGER
**************************************************************/

#include <stdlib.h>
#include <string.h>
#include <eif_cecil.h>



EIF_POINTER rcurses_integer_to_pointer (EIF_INTEGER i)
{
	return ((EIF_POINTER) i);
}

EIF_INTEGER rcurses_pointer_to_integer (EIF_POINTER p)
{
	return ((EIF_INTEGER) p);
}
