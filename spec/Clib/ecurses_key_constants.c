/*************************************************************
	ECURSES_KEY_CONSTANTS.C
	
	wrapper functions for key constant values

**************************************************************/

#include "ecurses.h"



EIF_INTEGER c_curses_key_min  () 
	{
		return KEY_MIN;
	};


EIF_INTEGER c_curses_key_max   () 
	{
		return KEY_MAX;
	};


EIF_INTEGER c_curses_key_break  () 
	{
		return KEY_BREAK;
	};


EIF_INTEGER c_curses_key_down  () 
	{
		return KEY_DOWN;
	};


EIF_INTEGER c_curses_key_up  () 
	{
		return KEY_UP;
	};


EIF_INTEGER c_curses_key_left  () 
	{
		return KEY_LEFT;
	};


EIF_INTEGER c_curses_key_right  () 
	{
		return KEY_RIGHT;
	};


EIF_INTEGER c_curses_key_home  () 
	{
		return KEY_HOME;
	};


EIF_INTEGER c_curses_key_backspace  () 
	{
		return KEY_BACKSPACE;
	};


EIF_INTEGER c_curses_key_f0  () 
	{
		return KEY_F0;
	};


EIF_INTEGER c_curses_key_fn (EIF_INTEGER n) 
	{
		return KEY_F (n);
	};



EIF_INTEGER c_curses_key_dl   () 
	{
		return KEY_DL;
	};


EIF_INTEGER c_curses_key_il   () 
	{
		return KEY_IL;
	};


EIF_INTEGER c_curses_key_dc   () 
	{
		return KEY_DC;
	};


EIF_INTEGER c_curses_key_ic   () 
	{
		return KEY_IC;
	};


EIF_INTEGER c_curses_key_eic  () 
	{
		return KEY_EIC ;
	};


EIF_INTEGER c_curses_key_clear   () 
	{
		return KEY_CLEAR;
	};


EIF_INTEGER c_curses_key_eos   () 
	{
		return KEY_EOS ;
	};


EIF_INTEGER c_curses_key_eol   () 
	{
		return KEY_EOL;
	};


EIF_INTEGER c_curses_key_sf   () 
	{
		return KEY_SF;
	};


EIF_INTEGER c_curses_key_sr   () 
	{
		return KEY_SR;
	};

 
EIF_INTEGER c_curses_key_npage   () 
	{
		return KEY_NPAGE;
	};


EIF_INTEGER c_curses_key_ppage   () 
	{
		return KEY_PPAGE;
	};


EIF_INTEGER c_curses_key_stab   () 
	{
		return KEY_STAB;
	};


EIF_INTEGER c_curses_key_ctab   () 
	{
		return KEY_CTAB;
	};


EIF_INTEGER c_curses_key_catab   () 
	{
		return KEY_CATAB;
	};


EIF_INTEGER c_curses_key_print   () 
	{
		return KEY_PRINT;
	};


EIF_INTEGER c_curses_key_ll   () 
	{
		return KEY_LL;
	};



/*
-- The keypad is arranged like this: 
-- a1    up    a3   
-- left   b2  right  
-- c1   down   c3   
*/

EIF_INTEGER c_curses_key_a1   () 
	{
		return KEY_A1;
	};


EIF_INTEGER c_curses_key_a3   () 
	{
		return KEY_A3;
	};


EIF_INTEGER c_curses_key_b2   () 
	{
		return KEY_B2;
	};


EIF_INTEGER c_curses_key_c1   () 
	{
		return KEY_C1;
	};


EIF_INTEGER c_curses_key_c3   () 
	{
		return KEY_C3;
	};


EIF_INTEGER c_curses_key_btab   () 
	{
		return KEY_BTAB;
	};


EIF_INTEGER c_curses_key_beg   () 
	{
		return KEY_BEG;
	};


EIF_INTEGER c_curses_key_cancel   () 
	{
		return KEY_CANCEL;
	};


EIF_INTEGER c_curses_key_close   () 
	{
		return KEY_CLOSE;
	};


EIF_INTEGER c_curses_key_command   () 
	{
		return KEY_COMMAND;
	};


EIF_INTEGER c_curses_key_copy   () 
	{
		return KEY_COPY;
	};


EIF_INTEGER c_curses_key_create   () 
	{
		return KEY_CREATE;
	};


EIF_INTEGER c_curses_key_end   () 
	{
		return KEY_END;
	};


EIF_INTEGER c_curses_key_exit   () 
	{
		return KEY_EXIT;
	};


EIF_INTEGER c_curses_key_find   () 
	{
		return KEY_FIND;
	};


EIF_INTEGER c_curses_key_help   () 
	{
		return KEY_HELP;
	};


EIF_INTEGER c_curses_key_mark   () 
	{
		return KEY_MARK;
	};


EIF_INTEGER c_curses_key_message   () 
	{
		return KEY_MESSAGE;
	};


EIF_INTEGER c_curses_key_move   () 
	{
		return KEY_MOVE;
	};


EIF_INTEGER c_curses_key_next   () 
	{
		return KEY_NEXT;
	};


EIF_INTEGER c_curses_key_open   () 
	{
		return KEY_OPEN;
	};


EIF_INTEGER c_curses_key_options   () 
	{
		return KEY_OPTIONS;
	};


EIF_INTEGER c_curses_key_previous   () 
	{
		return KEY_PREVIOUS;
	};


EIF_INTEGER c_curses_key_redo   () 
	{
		return KEY_REDO;
	};


EIF_INTEGER c_curses_key_reference   () 
	{
		return KEY_REFERENCE;
	};


EIF_INTEGER c_curses_key_refresh   () 
	{
		return KEY_REFRESH;
	};


EIF_INTEGER c_curses_key_replace   () 
	{
		return KEY_REPLACE;
	};


EIF_INTEGER c_curses_key_restart   () 
	{
		return KEY_RESTART;
	};


EIF_INTEGER c_curses_key_resume   () 
	{
		return KEY_RESUME;
	};


EIF_INTEGER c_curses_key_save   () 
	{
		return KEY_SAVE;
	};


EIF_INTEGER c_curses_key_sbeg   () 
	{
		return KEY_SBEG;
	};


EIF_INTEGER c_curses_key_scancel   () 
	{
		return KEY_SCANCEL;
	};


EIF_INTEGER c_curses_key_scommand   () 
	{
		return KEY_SCOMMAND;
	};


EIF_INTEGER c_curses_key_scopy   () 
	{
		return KEY_SCOPY;
	};


EIF_INTEGER c_curses_key_screate   () 
	{
		return KEY_SCREATE;
	};


EIF_INTEGER c_curses_key_sdc   () 
	{
		return KEY_SDC;
	};


EIF_INTEGER c_curses_key_sdl   () 
	{
		return KEY_SDL;
	};


EIF_INTEGER c_curses_key_select   () 
	{
		return KEY_SELECT;
	};


EIF_INTEGER c_curses_key_send   () 
	{
		return KEY_SEND;
	};


EIF_INTEGER c_curses_key_seol   () 
	{
		return KEY_SEOL;
	};


EIF_INTEGER c_curses_key_sexit   () 
	{
		return KEY_SEXIT;
	};


EIF_INTEGER c_curses_key_sfind   () 
	{
		return KEY_SFIND;
	};


EIF_INTEGER c_curses_key_shelp   () 
	{
		return KEY_SHELP;
	};


EIF_INTEGER c_curses_key_shome   () 
	{
		return KEY_SHOME;
	};


EIF_INTEGER c_curses_key_sic   () 
	{
		return KEY_SIC;
	};


EIF_INTEGER c_curses_key_sleft   () 
	{
		return KEY_SLEFT;
	};


EIF_INTEGER c_curses_key_smessage   () 
	{
		return KEY_SMESSAGE;
	};


EIF_INTEGER c_curses_key_smove   () 
	{
		return KEY_SMOVE;
	};


EIF_INTEGER c_curses_key_snext   () 
	{
		return KEY_SNEXT;
	};


EIF_INTEGER c_curses_key_soptions   () 
	{
		return KEY_SOPTIONS;
	};


EIF_INTEGER c_curses_key_sprevious  () 
	{
		return KEY_SPREVIOUS;
	};


EIF_INTEGER c_curses_key_sprint   () 
	{
		return KEY_SPRINT;
	};


EIF_INTEGER c_curses_key_sredo   () 
	{
		return KEY_SREDO;
	};


EIF_INTEGER c_curses_key_sreplace   () 
	{
		return KEY_SREPLACE;
	};


EIF_INTEGER c_curses_key_sright   () 
	{
		return KEY_SRIGHT;
	};


EIF_INTEGER c_curses_key_srsume   () 
	{
		return KEY_SRSUME;
	};


EIF_INTEGER c_curses_key_ssave   () 
	{
		return KEY_SSAVE;
	};


EIF_INTEGER c_curses_key_ssuspend   () 
	{
		return KEY_SSUSPEND;
	};


EIF_INTEGER c_curses_key_sundo   () 
	{
		return KEY_SUNDO;
	};


EIF_INTEGER c_curses_key_suspend   () 
	{
		return KEY_SUSPEND;
	};


EIF_INTEGER c_curses_key_undo   () 
	{
		return KEY_UNDO;
	};


