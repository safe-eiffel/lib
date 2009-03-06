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

#include <ncurses.h>
#include <ge_eiffel.h>
#define EIF_INTEGER EIF_INTEGER_32
#define EIF_CHARACTER EIF_CHARACTER_8
#define EIF_REAL	EIF_REAL_32
#define EIF_DOUBLE	EIF_REAL_64

#define ecurses_cursor_x(w) ((w)->_curx)
#define ecurses_cursor_y(w) ((w)->_cury)

