/*************************************************************
	ECUSES_SLK.C
	
	wrapper functions for soft label key api

**************************************************************/

#include "ecurses.h"

EIF_INTEGER c_ecurses_slk_init(EIF_INTEGER fmt)
	{
		return (EIF_INTEGER) slk_init((int) fmt);
	};

EIF_INTEGER c_ecurses_slk_set(EIF_INTEGER labnum, EIF_POINTER label, EIF_INTEGER fmt)
	{
		return (EIF_INTEGER) slk_set((int) labnum, (char *)label, (int) fmt);
	};

EIF_INTEGER c_ecurses_slk_refresh(void)
	{
		return (EIF_INTEGER) slk_refresh();
	};

EIF_INTEGER c_ecurses_slk_noutrefresh(void)
	{
		return (EIF_INTEGER) slk_noutrefresh();
	};

EIF_POINTER c_ecurses_slk_label(EIF_INTEGER labnum)
	{
		return (EIF_POINTER)slk_label((int) labnum);
	};

EIF_INTEGER c_ecurses_slk_clear(void)
	{
		return (EIF_INTEGER) slk_clear();
	};

EIF_INTEGER c_ecurses_slk_restore(void)
	{
		return (EIF_INTEGER) slk_restore();
	};

EIF_INTEGER c_ecurses_slk_touch(void)
	{
		return (EIF_INTEGER) slk_touch();
	};

EIF_INTEGER c_ecurses_slk_attron(EIF_INTEGER attrs)
	{
		return (EIF_INTEGER) slk_attron((attr_t) attrs);
	};
		
EIF_INTEGER c_ecurses_slk_attrset(EIF_INTEGER attrs)
	{
		return (EIF_INTEGER) slk_attrset((attr_t) attrs);
	};
	   
EIF_INTEGER c_ecurses_slk_attr(void)
	{
		return (EIF_INTEGER) slk_attr();
	};

EIF_INTEGER c_ecurses_slk_attroff(EIF_INTEGER attrs)
	{
		return (EIF_INTEGER) slk_attroff((attr_t) attrs);
	};
	