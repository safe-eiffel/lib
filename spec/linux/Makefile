SHELL = /bin/sh
CC = cc
CFLAGS = -O  -I$(EIFFEL4)/bench/spec/$(PLATFORM)/include -I.
LDFLAGS = 
LIBS = -lnsl -lm
MAKE = make
MV = /bin/mv
RANLIB = :
RM = /bin/rm -f

SRC= ../Clib
OBJS=ecurses_acs_characters.o ecurses_color_constants.o ecurses_pad_api.o ecurses_slk_api.o ecurses_window_api.o ecurses_attributes.o ecurses_key_constants.o ecurses_panel_api.o ecurses_system_api.o

.c.o:
	$(CC) $(CFLAGS) -c $<

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
 
libecurses_c.a : $(OBJS)
	ar -ru libecurses_c.a $(OBJS)
	ranlib libecurses_c.a

all : libecurses_c.a
 

