CC = bcc32
PLATFORM=windows
CFLAGS = -c -g0 -w- -DNONAMELESSUNION -I$(ISE_EIFFEL)\Bcc55\include -I$(IS_EIFFEL)\bench\spec\$(PLATFORM)\include -I. -I$(PDCURSES)
OBJ = ecurses_acs_characters.obj ecurses_attributes.obj ecurses_color_constants.obj ecurses_key_constants.obj ecurses_window_api.obj ecurses_panel_api.obj ecurses_slk_api.obj ecurses_system_api.obj ecurses_pad_api.obj


ecurses_c.lib: $(OBJ)
                tlib ecurses_c.lib + ecurses_acs_characters.obj
				tlib ecurses_c.lib + ecurses_attributes.obj
				tlib ecurses_c.lib + ecurses_color_constants.obj
				tlib ecurses_c.lib + ecurses_key_constants.obj
				tlib ecurses_c.lib + ecurses_window_api.obj
				tlib ecurses_c.lib + ecurses_panel_api.obj
				tlib ecurses_c.lib + ecurses_slk_api.obj
				tlib ecurses_c.lib + ecurses_system_api.obj
				tlib ecurses_c.lib + ecurses_pad_api.obj
				
ecurses_acs_characters.obj: ..\..\clib\ecurses_acs_characters.c .\ecurses.h
        $(CC) $(CFLAGS) ..\..\clib\ecurses_acs_characters.c

ecurses_attributes.obj: ..\..\clib\ecurses_attributes.c .\ecurses.h
        $(CC) $(CFLAGS) ..\..\clib\ecurses_attributes.c

ecurses_color_constants.obj: ..\..\clib\ecurses_color_constants.c .\ecurses.h
        $(CC) $(CFLAGS) ..\..\clib\ecurses_color_constants.c

ecurses_key_constants.obj: ..\..\clib\ecurses_key_constants.c .\ecurses.h
        $(CC) $(CFLAGS) ..\..\clib\ecurses_key_constants.c

ecurses_window_api.obj: ..\..\clib\ecurses_window_api.c .\ecurses.h
        $(CC) $(CFLAGS) ..\..\clib\ecurses_window_api.c
		
ecurses_panel_api.obj: ..\..\clib\ecurses_panel_api.c .\ecurses.h
        $(CC) $(CFLAGS) ..\..\clib\ecurses_panel_api.c

ecurses_slk_api.obj: ..\..\clib\ecurses_slk_api.c .\ecurses.h
        $(CC) $(CFLAGS) ..\..\clib\ecurses_slk_api.c

ecurses_system_api.obj: ..\..\clib\ecurses_system_api.c .\ecurses.h
        $(CC) $(CFLAGS) ..\..\clib\ecurses_system_api.c

ecurses_pad_api.obj: ..\..\clib\ecurses_pad_api.c .\ecurses.h
        $(CC) $(CFLAGS) ..\..\clib\ecurses_pad_api.c

clean:
	del *.obj
	del *.lib
