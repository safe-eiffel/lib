/*************************************************************
	ECURSES_PANEL.C
	
	wrapper functions for panel api

**************************************************************/

#include "ecurses.h"
#include "epanel.h"

EIF_POINTER	c_ecurses_panel_window (EIF_POINTER p)
	{
		return (EIF_POINTER) panel_window((PANEL *)p);
	};

void	c_ecurses_update_panels ()
	{
		update_panels ();
	};

EIF_INTEGER	c_ecurses_hide_panel (EIF_POINTER p)
	{
		return (EIF_INTEGER) hide_panel((PANEL *) p);
	};

EIF_INTEGER	c_ecurses_show_panel (EIF_POINTER p)
	{
		return (EIF_INTEGER) show_panel((PANEL *) p);
	};

EIF_INTEGER	c_ecurses_del_panel (EIF_POINTER p)
	{
		return (EIF_INTEGER) del_panel((PANEL *) p);
	};

EIF_INTEGER	c_ecurses_top_panel (EIF_POINTER p)
	{
		return (EIF_INTEGER) top_panel((PANEL *) p);
	};

EIF_INTEGER	c_ecurses_bottom_panel (EIF_POINTER p)
	{
		return (EIF_INTEGER) bottom_panel((PANEL *) p);
	};

EIF_POINTER	c_ecurses_new_panel (EIF_POINTER w)
	{
		return (EIF_POINTER) new_panel((WINDOW *)w);
	};

EIF_POINTER	c_ecurses_panel_above (EIF_POINTER p)
	{
		return (EIF_POINTER) panel_above((PANEL *) p);
	};


EIF_POINTER	c_ecurses_panel_below (EIF_POINTER p)
	{
		return (EIF_POINTER) panel_below((PANEL *) p);
	};

EIF_INTEGER	c_ecurses_set_panel_userptr(EIF_POINTER p, EIF_POINTER u)
	{
		return (EIF_INTEGER) set_panel_userptr((PANEL *)p, (void *)u);
	};

EIF_POINTER	c_ecurses_panel_userptr(EIF_POINTER p)
	{
		return (EIF_POINTER) panel_userptr((PANEL *) p);
	};

EIF_INTEGER	c_ecurses_move_panel (EIF_POINTER p, EIF_INTEGER y, EIF_INTEGER x)
	{
		return (EIF_INTEGER) move_panel((PANEL *)p, (int)y, (int)x);
	};

EIF_INTEGER	c_ecurses_replace_panel (EIF_POINTER p, EIF_POINTER w)
	{
		return (EIF_INTEGER) replace_panel((PANEL *) p,(WINDOW *)w);
	};

EIF_INTEGER	c_ecurses_panel_hidden (EIF_POINTER p)
	{
		return (EIF_INTEGER) panel_hidden((PANEL *) p);
	};

