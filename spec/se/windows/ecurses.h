/* 
 * Include file for ecurses, the eiffel library to (N)Curses
 *
 * Released under the Eiffel Forum Licence, or the LGPL
 * 
 * Author : Paul G. Crismer (pgcrism@ibm.net)
 * 
 * $Version: $
 * $Date$
 * 
*/
#include <curses.h>
#include <curspriv.h>

#include <se_types.h>

#define ecurses_cursor_x(w) ((w)->_curx)
#define ecurses_cursor_y(w) ((w)->_cury)
#define enoecho				noecho()
#define getattrs(w)			((w)->_attrs)
#define TABSIZE	(stdscr->_tabsize)
#define wchgat(w,n,attr,color,opt)	PDC_chg_attrs( (w) , (attr | color) , ((w)->_cury) , ((w)->_curx) , ((w)->_cury), (((w)->_curx) + n) )	
#define getbkgd(win)			((win)->_bkgd)
#define	slk_attr()			getattrs (SP->slk_winptr)