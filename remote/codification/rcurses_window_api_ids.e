indexing
	description: "Identifiers of curses window api features"
    cluster: 	"ecurses, spec, remote_access"
    interface: 	"mixin"
    status: 	"See notice at do end of class"
    date: 	"$Date$"
    revision: 	"$Revision$"
    author: 	"Paul G. Crismer, Eric Fafchamps"

class
	RCURSES_WINDOW_API_IDS

feature -- Feature identifiers

    Id_endwin: INTEGER is 1
    Id_initscr: INTEGER is 2
    Id_cbreak: INTEGER is 3
    Id_echo: INTEGER is 4
    Id_halfdelay: INTEGER is 5
    Id_nocbreak : INTEGER is 6
    Id_noecho : INTEGER is 7
    Id_noraw : INTEGER is 8
    Id_raw : INTEGER is 9
    Id_nl: INTEGER is 10
    Id_nonl: INTEGER is 11
    Id_erasechar: INTEGER is 12
    Id_killchar: INTEGER is 13
    Id_typeahead: INTEGER is 14
    Id_flushinp: INTEGER is 15
    Id_intrflush: INTEGER is 16
    Id_keypad: INTEGER is 17
    Id_meta: INTEGER is 18
    Id_nodelay: INTEGER is 19
    Id_notimeout: INTEGER is 20
    Id_wtimeout: INTEGER is 21
    Id_api_beep: INTEGER is 22
    Id_api_flash: INTEGER is 23
    Id_clearok: INTEGER is 24
    Id_idlok: INTEGER is 25
    Id_idcok: INTEGER is 26
    Id_leaveok: INTEGER is 27
	Id_immedok: INTEGER is 28
    Id_wsetscrreg: INTEGER is 29
    Id_api_lines: INTEGER is 30
    Id_api_columns: INTEGER is 31
    Id_api_tab_size: INTEGER is 32
    Id_api_colors: INTEGER is 33
    Id_api_color_pairs: INTEGER is 34
    Id_api_stdscr: INTEGER is 35
    Id_api_has_colors: INTEGER is 36
    Id_start_color: INTEGER is 37
    Id_color_pair: INTEGER is 38
    Id_init_pair: INTEGER is 39
    Id_pair_number: INTEGER is 40
    Id_pair_content: INTEGER is 41
    Id_newwin: INTEGER is 42
    Id_delwin: INTEGER is 43
    Id_mvwin: INTEGER is 44
    Id_subwin: INTEGER is 45
    Id_derwin: INTEGER is 46
    Id_mvderwin: INTEGER is 47
    Id_dupwin: INTEGER is 48
    Id_wsyncup:INTEGER is 49
    Id_wcursyncup: INTEGER is 50
    Id_wsyncdown: INTEGER is 51
    Id_syncok: INTEGER is 52
    Id_waddch: INTEGER is 53
    Id_wechochar: INTEGER is 54
    Id_mvwaddch: INTEGER is 55
    Id_winsch: INTEGER is 56
    Id_wdelch: INTEGER is 57
    Id_mvwdelch: INTEGER is 58
    Id_wgetch: INTEGER is 59
    Id_mvwgetch: INTEGER is 60
    Id_winch: INTEGER is 61
    Id_wgetstr: INTEGER is 62
    Id_wgetnstr: INTEGER is 63
    Id_winchstr: INTEGER is 64
    Id_winchnstr: INTEGER is 65
    Id_winstr: INTEGER is 66
    Id_winnstr: INTEGER is 67
    Id_waddstr: INTEGER is 68
    Id_waddnstr: INTEGER is 69
    Id_waddchstr: INTEGER is 70
    Id_waddchnstr: INTEGER is 71
    Id_winsstr: INTEGER is 72
    Id_winsnstr: INTEGER is 73
    Id_wattroff: INTEGER is 74
    Id_wattron: INTEGER is 75
    Id_wattrset: INTEGER is 76
    Id_wbkgdset: INTEGER is 77
    Id_wbkgd: INTEGER is 78
    Id_wchgat: INTEGER is 79
    Id_getattrs: INTEGER is 80
    Id_getbkgd: INTEGER is 81
    Id_wborder: INTEGER is 82
    Id_whline: INTEGER is 83
    Id_wvline: INTEGER is 84
    Id_box: INTEGER is 85
    Id_wrefresh: INTEGER is 86
    Id_wnoutrefresh: INTEGER is 87
    Id_doupdate: INTEGER is 88
    Id_redrawwin: INTEGER is 89
    Id_wredrawln: INTEGER is 90
    Id_wtouchln: INTEGER is 91
    Id_touchwin: INTEGER is 92
    Id_is_wintouched: INTEGER is 93
    Id_is_linetouched: INTEGER is 94
    Id_werase: INTEGER is 95
    Id_wclear: INTEGER is 96
    Id_wclrtobot: INTEGER is 97
    Id_wclrtoeol: INTEGER is 98
    Id_wdeleteln: INTEGER is 99
    Id_winsdelln: INTEGER is 100
    Id_winsertln: INTEGER is 101
    Id_wmove: INTEGER is 102
    Id_scrollok: INTEGER is 103
    Id_wscrl: INTEGER is 104
    Id_overlay: INTEGER is 105
    Id_overwrite: INTEGER is 106
    Id_copywin: INTEGER is 107 
    Id_getmaxx: INTEGER is 108
    Id_getmaxy: INTEGER is 109
    Id_getbegx: INTEGER is 110
    Id_getbegy: INTEGER is 111
    Id_c_cursor_x: INTEGER is 112
    Id_c_cursor_y: INTEGER is 113

end -- class RCURSES_WINDOW_API_IDS

-----------------------------------------------------------
-- Copyright (C) 2001 Paul G. Crismer, Eric Fafchamps
-- Licensed under Eiffel Forum Freeware License, version 1
-- (see forum.txt)
-----------------------------------------------------------
