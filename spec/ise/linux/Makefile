SHELL = /bin/sh
CC = cc
AR = ar
RANLIB = ranlib
CFLAGS =  -O -I$(EIFFEL4)/bench/spec/$(PLATFORM)/include -I. -I/usr/local/include
LIBS = -lnsl -lm
RM = /bin/rm -f
SRC= $(ECURSES)/spec/Clib
OBJ=ecurses_acs_characters.o ecurses_color_constants.o ecurses_pad_api.o ecurses_slk_api.o ecurses_window_api.o ecurses_attributes.o ecurses_key_constants.o ecurses_panel_api.o ecurses_system_api.o

.c.o:
	$(CC) $(CFLAGS) -c $<

libecurses_c.a : ecursesvar $(OBJ)
	$(AR) -ru $@ $(OBJ)
	$(RANLIB) $@

ecurses_acs_characters.o : $(SRC)/ecurses_acs_characters.c
	$(CC) $(CFLAGS) -c $<

ecurses_color_constants.o : $(SRC)/ecurses_color_constants.c
	$(CC) $(CFLAGS) -c $<

ecurses_pad_api.o : $(SRC)/ecurses_pad_api.c
	$(CC) $(CFLAGS) -c $<

ecurses_slk_api.o : $(SRC)/ecurses_slk_api.c
	$(CC) $(CFLAGS) -c $<

ecurses_window_api.o : $(SRC)/ecurses_window_api.c
	$(CC) $(CFLAGS) -c $<

ecurses_attributes.o : $(SRC)/ecurses_attributes.c
	$(CC) $(CFLAGS) -c $<

ecurses_key_constants.o : $(SRC)/ecurses_key_constants.c
	$(CC) $(CFLAGS) -c $<

ecurses_panel_api.o : $(SRC)/ecurses_panel_api.c
	$(CC) $(CFLAGS) -c $<

ecurses_system_api.o : $(SRC)/ecurses_system_api.c
	$(CC) $(CFLAGS) -c $<
 

.PHONY: all clean ecursesvar

clean:
	$(RM) libecurses_c.a $(OBJ)

all:eclivar libecurses_c.a
 
ecursesvar:
	@if test -z "$(ECURSES)" ; then \
		 echo "* ERROR * -- ECURSES variable not set "; \
		 echo "*         -- Please set it first, then make the build !" ;  \
	fi
