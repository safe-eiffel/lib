CC = cl
PLATFORM=windows
CFLAGS = -Ox -nologo -c -I$(EIFFEL4)\bench\spec\$(PLATFORM)\include -I. -I$(PDCURSES)
OBJ = ecurses_acs_characters.obj ecurses_attributes.obj ecurses_color_constants.obj ecurses_key_constants.obj ecurses_window_api.obj ecurses_panel_api.obj ecurses_slk_api.obj ecurses_system_api.obj ecurses_pad_api.obj

all::clean ecurses_c.lib

ecurses_c.lib: $(OBJ)
		del $@
                lib /OUT:$@ $(OBJ)

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
