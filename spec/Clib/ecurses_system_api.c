/*************************************************************
	ECUSES_KERNEL.C
	
	wrapper functions for curses kernel and options api
	see curs_kernel(3X) , curs_util(3X)
	
**************************************************************/

#include "ecurses.h"

/****************************************************************

				curs_kernel calls
	
*****************************************************************/

EIF_INTEGER c_ecurses_def_prog_mode(void) 
	{
		return (EIF_INTEGER) def_prog_mode();
	};

EIF_INTEGER c_ecurses_def_shell_mode(void) 
	{
		return (EIF_INTEGER) def_shell_mode();
	};

EIF_INTEGER c_ecurses_reset_prog_mode(void) 
	{
		return (EIF_INTEGER) reset_prog_mode();
	};

EIF_INTEGER c_ecurses_reset_shell_mode(void) 
	{
		return (EIF_INTEGER) reset_shell_mode();
	};

EIF_INTEGER c_ecurses_resetty(void) 
	{
		return (EIF_INTEGER) resetty();
	};

EIF_INTEGER c_ecurses_savetty(void) 
	{
		return (EIF_INTEGER) savetty();
	};

 
void  c_ecurses_getsyx(EIF_POINTER y, EIF_POINTER x)
	{
		int ax, ay;
		getsyx(ay, ax);
		* ((int *)x) = ax;
		* ((int *)y) = ay;		
	};

 
void  c_ecurses_setsyx(EIF_INTEGER y, EIF_INTEGER x)
	{
		setsyx((int) y, (int)x);
	};


/*      int ripoffline(int line, int (*init)(WINDOW *, int)); */

EIF_INTEGER c_ecurses_curs_set(EIF_INTEGER visibility) 
	{
		return (EIF_INTEGER) curs_set((int) visibility);
	};

EIF_INTEGER c_ecurses_napms(EIF_INTEGER ms) 
	{
		return (EIF_INTEGER) napms((int) ms);
	};


/****************************************************************

				curs_util calls
	
*****************************************************************/


EIF_POINTER c_ecurses_unctrl(EIF_INTEGER c) 
	{
		return (EIF_POINTER) unctrl((chtype) c);
	};


EIF_POINTER c_ecurses_keyname(EIF_INTEGER c) 
	{
		return (EIF_POINTER) keyname((int) c);
	};

/*
EIF_INTEGER c_ecurses_filter ()
	{
		return filter ();
	};
*/



EIF_INTEGER c_ecurses_flushinp ()
	{
		return flushinp ();
	};

