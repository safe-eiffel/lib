/*************************************************************
	ECUSES_WINDOW_API.C
	
	wrapper functions for curses window api functions.

**************************************************************/

#include "ecurses.h"

EIF_INTEGER c_ecurses_endwin ()
	{
		return endwin();
	};

EIF_POINTER c_ecurses_initscr () 
	{
		return (EIF_POINTER) initscr ();
	};

EIF_INTEGER c_ecurses_cbreak ()
	{
		return cbreak ();
	};

EIF_INTEGER c_ecurses_echo ()
	{
		return  echo ();
	};

EIF_INTEGER c_ecurses_halfdelay(EIF_INTEGER tenths)
	{
		return halfdelay (tenths);
	};

EIF_INTEGER c_ecurses_nocbreak ()
	{
		return nocbreak ();
	};

EIF_INTEGER c_ecurses_noecho ()
	{
		return noecho ();
	};

EIF_INTEGER c_ecurses_noraw ()
	{
		return noraw ();
	};

EIF_INTEGER c_ecurses_raw ()
	{
		return raw ();
	};

EIF_INTEGER c_ecurses_nl ()
	{
		return nl ();
	};

EIF_INTEGER c_ecurses_nonl ()
	{
		return nonl ();
	};

EIF_CHARACTER c_ecurses_erasechar ()
	{
		return erasechar ();
	};

EIF_CHARACTER c_ecurses_killchar () 
	{
		return killchar ();
	};

EIF_INTEGER c_ecurses_typeahead(EIF_INTEGER fd)
	{
		return typeahead ((int)  fd);
	};


/*
EIF_INTEGER c_ecurses_qiflush ()
	{
		return qiflush ();
	};

EIF_INTEGER c_ecurses_noqiflush ()
	{
		return noqiflush ();
	};
*/

EIF_INTEGER c_ecurses_intrflush (EIF_POINTER w, EIF_BOOLEAN b)
	{
		return intrflush (((WINDOW *) w), (bool)  b);
	};

EIF_INTEGER c_ecurses_keypad (EIF_POINTER w, EIF_BOOLEAN b)
	{
		return keypad( ((WINDOW *) w) , (bool)b) ;
	};

EIF_INTEGER c_ecurses_meta (EIF_POINTER w, EIF_BOOLEAN b)
	{
		return meta( ((WINDOW *) w) , (bool)b) ;
	};

EIF_INTEGER c_ecurses_nodelay (EIF_POINTER w, EIF_BOOLEAN b)
	{
		return nodelay( (((WINDOW *) w)), (bool)b) ;
	};

EIF_INTEGER c_ecurses_notimeout (EIF_POINTER w, EIF_BOOLEAN b)
	{
		return notimeout( ((WINDOW *) w), (bool)b) ;
	};

c_ecurses_wtimeout (EIF_POINTER w, EIF_INTEGER delay)
	{
		wtimeout( ((WINDOW *) w), (int) delay) ;
	};

EIF_INTEGER c_ecurses_api_beep ()
	{
		return beep ();
	};

EIF_INTEGER c_ecurses_api_flash ()
	{
		return  flash ();
	};

EIF_INTEGER c_ecurses_clearok (EIF_POINTER p, EIF_BOOLEAN b)
	{
		return clearok( (WINDOW *) p , (bool)b) ;
	};

EIF_INTEGER c_ecurses_idlok (EIF_POINTER p, EIF_BOOLEAN b)
	{
		return idlok( (WINDOW *) p  , (bool)b) ;
	};

c_ecurses_idcok (EIF_POINTER p, EIF_BOOLEAN b)
	{
		idcok( (WINDOW *) p , (bool)b) ;
	};

EIF_INTEGER c_ecurses_leaveok (EIF_POINTER p, EIF_BOOLEAN b) 
	{
		return leaveok( ((WINDOW *)  p), (bool)b);
	};
 

c_ecurses_immedok (EIF_POINTER p, EIF_BOOLEAN b)
	{
		immedok( (WINDOW *) p , (bool)b) ;
	};

EIF_INTEGER c_ecurses_wsetscrreg (EIF_POINTER p, EIF_INTEGER top, EIF_INTEGER bottom)
	{
		return wsetscrreg( (WINDOW *) p , (int)  top, (int)  bottom) ;
	};

EIF_INTEGER c_ecurses_api_lines ()
	{
		return  LINES;
	};

EIF_INTEGER c_ecurses_api_columns ()
	{
		return  COLS;
	};

EIF_INTEGER c_ecurses_api_tab_size ()
	{
		return  TABSIZE;
	};

EIF_INTEGER c_ecurses_api_colors ()
	{
		return  COLORS;
	};

EIF_INTEGER c_ecurses_api_color_pairs ()
	{
		return  COLOR_PAIRS;
	};

EIF_POINTER c_ecurses_api_stdscr ()
	{
		return  (EIF_POINTER) stdscr;
	};

EIF_BOOLEAN c_ecurses_api_has_colors ()
	{
		return   has_colors ();
	};

EIF_INTEGER c_ecurses_start_color ()
	{
		return  start_color();
	};

EIF_INTEGER c_ecurses_color_pair (EIF_INTEGER n) 
	{
		return  COLOR_PAIR (n);
	};

EIF_INTEGER c_ecurses_init_pair (EIF_INTEGER pair_nr, EIF_INTEGER fore_col, EIF_INTEGER back_col) 
	{
		return  init_pair((short)pair_nr, (short)fore_col, (short)back_col);
	};

EIF_INTEGER c_ecurses_pair_number (EIF_INTEGER n) 
	{
		return  PAIR_NUMBER ((int) n);
	};

EIF_INTEGER c_ecurses_pair_content (EIF_INTEGER n, EIF_POINTER f, EIF_POINTER g)
	{
		EIF_INTEGER _result;
		short f1, g1;
		f1 = (short) *f; g1 = (short) *g;
		_result = pair_content (n, &f1, &g1);
		*f = (EIF_INTEGER) f1; *g = (EIF_INTEGER) g1;
		return  _result;
	};
 

EIF_POINTER c_ecurses_newwin (EIF_INTEGER nlines, EIF_INTEGER ncols, EIF_INTEGER begin_y, EIF_INTEGER begin_x)
	{
		return  (EIF_POINTER) newwin ((int)nlines ,(int) ncols,(int) begin_y, (int) begin_x );
	};

EIF_INTEGER c_ecurses_delwin (EIF_POINTER w)
	{
		return delwin((WINDOW*)w)  ;
	};

EIF_INTEGER c_ecurses_mvwin (EIF_POINTER w, EIF_INTEGER y, EIF_INTEGER x)
	{
		return mvwin ( ((WINDOW *) w) , (int) y, (int) x);
	};

EIF_POINTER c_ecurses_subwin (EIF_POINTER orig, EIF_INTEGER lns, EIF_INTEGER cols,
							  EIF_INTEGER begin_y, EIF_INTEGER begin_x)
	{
		return (EIF_POINTER) subwin( (WINDOW *) orig , (int) lns,(int) cols,(int) begin_y,(int) begin_x);
	};

	
EIF_POINTER c_ecurses_derwin (EIF_POINTER orig, EIF_INTEGER lns, EIF_INTEGER cols,
							  EIF_INTEGER begin_y, EIF_INTEGER begin_x)
	{
		return (EIF_POINTER) derwin( (WINDOW *) orig , (int) lns,(int) cols,(int) begin_y,(int) begin_x);
	};

EIF_INTEGER c_ecurses_mvderwin (EIF_POINTER w, EIF_INTEGER par_y, EIF_INTEGER par_x)
	{
		return mvderwin( ((WINDOW *) w) , (int) par_y,(int) par_x) ;
	};

EIF_POINTER c_ecurses_dupwin (EIF_POINTER w)
	{
		return  (EIF_POINTER) dupwin((WINDOW *)w);
	};

void c_ecurses_wsyncup (EIF_POINTER w)
	{
		wsyncup ((WINDOW *) w)  ;
	};

void c_ecurses_wcursyncup (EIF_POINTER w)
	{
		wcursyncup((WINDOW *) w) ;
	};

void c_ecurses_wsyncdown (EIF_POINTER w)
	{
		wsyncdown ((WINDOW *)w)  ;
	};

EIF_INTEGER c_ecurses_syncok (EIF_POINTER w, EIF_BOOLEAN b)
	{
		return  syncok(((WINDOW *) w), (bool)b) ;
	};

EIF_INTEGER c_ecurses_waddch (EIF_POINTER w, EIF_INTEGER ch )
	{
		return  waddch( ((WINDOW *) w) , (chtype)ch);
	};

EIF_INTEGER c_ecurses_wechochar (EIF_POINTER w, EIF_INTEGER ch)
	{
		return wechochar( ((WINDOW *) w) , (chtype)ch) ;
	};

EIF_INTEGER c_ecurses_mvwaddch (EIF_POINTER w, EIF_INTEGER y, EIF_INTEGER x, EIF_INTEGER ch)
	{
		return mvwaddch( ((WINDOW *) w) , (int) y,(int) x, (chtype)ch) ;
	};

EIF_INTEGER c_ecurses_winsch (EIF_POINTER w, EIF_INTEGER ch)
	{
		return winsch( ((WINDOW *) w), (chtype) ch);
	};

EIF_INTEGER c_ecurses_wdelch (EIF_POINTER w)
	{
		return   wdelch((WINDOW *) w);
	};

EIF_INTEGER c_ecurses_mvwdelch (EIF_POINTER w, EIF_INTEGER y, EIF_INTEGER x)
	{
		return mvwdelch( ((WINDOW *) w) , (int) y,(int) x ) ;
	};

EIF_INTEGER c_ecurses_wgetch (EIF_POINTER w)
	{
		return  wgetch((WINDOW *)w) ;
	};

EIF_INTEGER c_ecurses_mvwgetch (EIF_POINTER w, EIF_INTEGER y, EIF_INTEGER x)
	{
		return mvwgetch( ((WINDOW *) w) , (int) y, (int) x) ;
	};

EIF_INTEGER c_ecurses_winch (EIF_POINTER w)
	{
		return  winch((WINDOW *) w);
	};

EIF_INTEGER c_ecurses_wgetstr (EIF_POINTER w, EIF_POINTER str)
	{
		return  wgetstr( ((WINDOW *) w), (char *) str);
	};

EIF_INTEGER c_ecurses_wgetnstr (EIF_POINTER w, EIF_POINTER str, EIF_INTEGER n)
	{
		return  wgetnstr( ((WINDOW *) w), (char *)str, (int) n) ;
	};

EIF_INTEGER c_ecurses_winchstr (EIF_POINTER w, EIF_POINTER chstr )
	{
		return  winchstr( ((WINDOW *) w)  , (chtype*) chstr) ;
	};

EIF_INTEGER c_ecurses_winchnstr (EIF_POINTER w, EIF_POINTER chrstr, EIF_INTEGER n)
	{
		return winchnstr( ((WINDOW *) w), (chtype*) chrstr, (int) n) ;
	};

EIF_INTEGER c_ecurses_winstr (EIF_POINTER w, EIF_POINTER str)
	{
		return winstr ( ((WINDOW *) w), (char*) str) ;
	};

EIF_INTEGER c_ecurses_winnstr (EIF_POINTER w, EIF_POINTER str, EIF_INTEGER n)
	{
		return winnstr( ((WINDOW *) w), (char *)str,(int) n) ;
	};

EIF_INTEGER c_ecurses_waddstr (EIF_POINTER w, EIF_POINTER s)
	{
		return waddstr( ((WINDOW *) w) , (char*) s);
	};

EIF_INTEGER c_ecurses_waddnstr (EIF_POINTER w, EIF_POINTER s, EIF_INTEGER n )
	{
		return waddnstr( ((WINDOW *) w) , (char*)s,(int) n) ;
	};

EIF_INTEGER c_ecurses_waddchstr (EIF_POINTER w, EIF_POINTER chs)
	{
		return waddchstr( ((WINDOW *) w) , (chtype *) chs) ;
	};

EIF_INTEGER c_ecurses_waddchnstr (EIF_POINTER w, EIF_POINTER chs, EIF_INTEGER n)
	{
		return waddchnstr( ((WINDOW *) w) , (chtype *)chs, (int) n) ;
	};

EIF_INTEGER c_ecurses_winsstr (EIF_POINTER w, EIF_POINTER s)
	{
		return  winsstr( ((WINDOW *) w) , (char *)s);
	};

EIF_INTEGER c_ecurses_winsnstr (EIF_POINTER w, EIF_POINTER s, EIF_INTEGER n)
	{
		return winsnstr( ((WINDOW *) w)  , (char *)s, (int) n) ;
	};

EIF_INTEGER c_ecurses_wattroff (EIF_POINTER w, EIF_INTEGER attrs)
	{
		return wattroff( ((WINDOW *) w)  , (int) attrs);
	};

EIF_INTEGER c_ecurses_wattron (EIF_POINTER w, EIF_INTEGER attrs)
	{
		return wattron( ((WINDOW *) w) , (int) attrs);
	};

EIF_INTEGER c_ecurses_wattrset (EIF_POINTER w, EIF_INTEGER attrs)
	{
		return wattrset ( ((WINDOW *) w), (int) attrs);
	};

void c_ecurses_wbkgdset (EIF_POINTER p, EIF_INTEGER ch)
	{
		wbkgdset( (WINDOW *) p , (chtype)ch) ;
	};

EIF_INTEGER c_ecurses_wbkgd (EIF_POINTER p, EIF_INTEGER ch)
	{
		return wbkgd( (WINDOW *) p , (chtype)ch) ;
	}; 

EIF_INTEGER c_ecurses_wchgat (EIF_POINTER w, EIF_INTEGER n, EIF_INTEGER attr, EIF_INTEGER color, EIF_POINTER opt) 
	{
		return  wchgat(((WINDOW*)w), ((int) n), ((attr_t)attr), ((short)color), ((char*)opt) ) ;
	}; 

EIF_INTEGER c_ecurses_getattrs (EIF_POINTER w) 
	{
		return  getattrs((WINDOW*)w);
	};

EIF_INTEGER c_ecurses_getbkgd (EIF_POINTER w) 
	{
		return getbkgd ((WINDOW*)w) ;
	};

EIF_INTEGER c_ecurses_wborder (EIF_POINTER w, EIF_INTEGER ls, EIF_INTEGER rs, EIF_INTEGER ts, 
							   EIF_INTEGER bs, EIF_INTEGER tl, EIF_INTEGER tr, EIF_INTEGER bl, EIF_INTEGER br)
	{
		return wborder( ((WINDOW *) w) ,  (chtype)ls, (chtype)rs, (chtype)ts, (chtype)bs, (chtype)tl, (chtype)tr, (chtype)bl, (chtype)br) ;
	};

EIF_INTEGER c_ecurses_whline (EIF_POINTER w, EIF_INTEGER ch, EIF_INTEGER n)
	{
		return whline( ((WINDOW *) w) , (chtype) ch,(int) n) ;
	};

EIF_INTEGER c_ecurses_wvline (EIF_POINTER w, EIF_INTEGER ch, EIF_INTEGER n)
	{
		return wvline( ((WINDOW *) w) , (chtype) ch,(int) n) ;
	};

EIF_INTEGER c_ecurses_box (EIF_POINTER w, EIF_INTEGER vert_ch, EIF_INTEGER horz_ch) 
	{
		return box( (WINDOW *)w  ,  (chtype)vert_ch,  (chtype)horz_ch) ;
	}; 

EIF_INTEGER c_ecurses_wrefresh (EIF_POINTER w)
	{
		return  wrefresh((WINDOW *)w) ;
	};

EIF_INTEGER c_ecurses_wnoutrefresh (EIF_POINTER w)
	{
		return  wnoutrefresh ((WINDOW *) w);
	};

EIF_INTEGER c_ecurses_doupdate ()
	{
		return doupdate() ;
	};

EIF_INTEGER c_ecurses_redrawwin (EIF_POINTER w)
	{
		return  redrawwin (((WINDOW *) w)) ;
	};

EIF_INTEGER c_ecurses_wredrawln (EIF_POINTER w, EIF_INTEGER x, EIF_INTEGER y)
	{
		return wredrawln ( ((WINDOW *) w), (int) x, (int) y) ;
	};

EIF_INTEGER c_ecurses_wtouchln (EIF_POINTER w, EIF_INTEGER  y, EIF_INTEGER x, EIF_BOOLEAN changed)
	{
		return wtouchln( ((WINDOW *) w) , (int) y,(int) x,(int) changed) ;
	};

EIF_INTEGER c_ecurses_touchwin (EIF_POINTER w)
	{
		return  touchwin ((WINDOW *) w);
	};

EIF_INTEGER c_ecurses_is_wintouched (EIF_POINTER w)
	{
		return  is_wintouched ((WINDOW *)w) ;
	};

EIF_INTEGER c_ecurses_is_linetouched (EIF_POINTER w, EIF_INTEGER line)
	{
		return is_linetouched ( ((WINDOW *) w) , (int) line) ;
	};

EIF_INTEGER c_ecurses_werase (EIF_POINTER w)
	{
		return werase  ((WINDOW *)w) ;
	};

EIF_INTEGER c_ecurses_wclear (EIF_POINTER w)
	{
		return    wclear((WINDOW *)w) ;
	};

EIF_INTEGER c_ecurses_wclrtobot (EIF_POINTER w)
	{
		return    wclrtobot((WINDOW *)w) ;
	};

EIF_INTEGER c_ecurses_wclrtoeol (EIF_POINTER w)
	{
		return  wclrtoeol  ((WINDOW *)w) ;
	};

EIF_INTEGER c_ecurses_wdeleteln (EIF_POINTER w )
	{
		return  wdeleteln  ((WINDOW *)w) ;
	};
	
EIF_INTEGER c_ecurses_winsdelln(EIF_POINTER w, EIF_INTEGER n)
	{
		return winsdelln ( ((WINDOW *) w), (int) n) ;
	};
	
EIF_INTEGER c_ecurses_winsertln (EIF_POINTER w)
	{
		return  winsertln  ((WINDOW *)w) ;
	};

EIF_INTEGER c_ecurses_wmove (EIF_POINTER w, EIF_INTEGER y, EIF_INTEGER x)
	{
		return wmove ( ((WINDOW *) w) ,(int) y,(int) x) ;
	};

EIF_INTEGER c_ecurses_scrollok (EIF_POINTER w, EIF_BOOLEAN b)
	{
		return scrollok ( ((WINDOW *) w), (bool)b) ;
	};

EIF_INTEGER c_ecurses_wscrl (EIF_POINTER w, EIF_INTEGER n)
	{
		return wscrl( ((WINDOW *) w), (int) n) ;
	};  

EIF_INTEGER c_ecurses_overlay (EIF_POINTER win1, EIF_POINTER win2)
	{
		return overlay ( (WINDOW *) win1 , (WINDOW*)win2) ;
	};

EIF_INTEGER c_ecurses_overwrite (EIF_POINTER win1, EIF_POINTER win2)
	{
		return overwrite( (WINDOW *) win1, (WINDOW*) win2) ;
	};

EIF_INTEGER c_ecurses_copywin (EIF_POINTER win1, EIF_POINTER win2,
	 EIF_INTEGER sminrow, EIF_INTEGER smincol, EIF_INTEGER dminrow, EIF_INTEGER dmincol, 
	 EIF_INTEGER dmaxrow, EIF_INTEGER dmaxcol, EIF_INTEGER overlay_num)
	{
		return copywin( (WINDOW *) win1, (WINDOW*)win2, (int) sminrow,(int) smincol,(int) dminrow,(int) dmincol,
						(int) dmaxrow,(int) dmaxcol,(int) overlay_num) ;
	};

EIF_INTEGER c_ecurses_getmaxx (EIF_POINTER w) 
	{
		return  getmaxx(((WINDOW *)w));
	};

EIF_INTEGER c_ecurses_getmaxy (EIF_POINTER w) 
	{
		return  getmaxy(((WINDOW *)w));
	};


/*EIF_INTEGER c_ecurses_getmaxyx (EIF_POINTER w, EIF_POINTER y,  EIF_POINTER x)
	{
		return  getmaxyx (((WINDOW *)w) , ((int *) y)  , ((int*)x) )";
	};
*/

EIF_INTEGER c_ecurses_getbegx(EIF_POINTER w) 
	{
		return  getbegx(((WINDOW *)w));
	};

EIF_INTEGER c_ecurses_getbegy (EIF_POINTER w) 
	{
		return  getbegy(((WINDOW *)w));
	};	

EIF_INTEGER c_ecurses_cursor_x (EIF_POINTER w) 
	{
		return  ecurses_cursor_x (((WINDOW *)w));
	};

EIF_INTEGER c_ecurses_cursor_y (EIF_POINTER w ) 
	{
		return  ecurses_cursor_y (((WINDOW *)w));
	};

