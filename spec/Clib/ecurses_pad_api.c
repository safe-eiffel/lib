/*************************************************************
	ECURSES_PAD_API.C
	
	wrapper functions for curses pad api

**************************************************************/

#include "ecurses.h"

EIF_POINTER	c_ecurses_newpad (EIF_INTEGER lines, EIF_INTEGER columns)
	{
		return (EIF_POINTER) newpad((int)lines, (int)columns) ;
	};


EIF_INTEGER	c_ecurses_prefresh (EIF_POINTER w, EIF_INTEGER pmr, EIF_INTEGER pmc, EIF_INTEGER smir, EIF_INTEGER smic, EIF_INTEGER smar, EIF_INTEGER smac)
	{
		return (EIF_INTEGER) prefresh((WINDOW *)w, (int)pmr, (int)pmc, (int)smir, (int)smic, (int)smar, (int)smac) ;
	};


EIF_INTEGER	c_ecurses_pnoutrefresh (EIF_POINTER w, EIF_INTEGER pmr, EIF_INTEGER pmc, EIF_INTEGER smir, EIF_INTEGER smic, EIF_INTEGER smar, EIF_INTEGER smac)
	{
		return (EIF_INTEGER) pnoutrefresh ((WINDOW *)w, (int)pmr, (int)pmc, (int)smir, (int)smic, (int)smar, (int)smac) ;
	};

EIF_POINTER	c_ecurses_subpad (EIF_POINTER w, EIF_INTEGER lines, EIF_INTEGER columns, EIF_INTEGER begin_y, EIF_INTEGER begin_x) 
	{ 
		return (EIF_POINTER) subpad((WINDOW*)w, (int)lines, (int)columns, (int)begin_y, (int)begin_x) ; 
	};

EIF_INTEGER	c_ecurses_pechochar (EIF_POINTER w, EIF_INTEGER ch) 
	{
       		return (EIF_INTEGER) (pechochar((WINDOW *)w, (chtype) ch));
	};

