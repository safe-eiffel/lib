SHELL = /bin/sh
CC = cc
AR = ar
RANLIB = ranlib
CFLAGS =  -O -I$(VE_Bin) -I. -I/usr/local/include -I$(ZLIB) -I$(PNGLIB)
RM = /bin/rm -f
SRC = $(EPDF)/src/spec/C
OBJ = epdf_c.o

.c.o:
	$(CC) $(CFLAGS) -c $(SRC)/$<

libepdf_c.a: epdf_cvar $(OBJ)
	$(AR) -ru $@ $(OBJ)
	$(RANLIB) $@

epdf_c.o:  $(SRC)/epdf_c.c
	$(CC) $(CFLAGS) -c $<

.PHONY: all clean epdf_cvar

clean:
	$(RM) libepdf_c.a $(OBJ)

all: epdf_cvar libepdf_c.a 

epdf_cvar:
	@if test -z "$(EPDF)" ; then \
		 echo "* ERROR * -- EPDF variable not set "; \
		 echo "*         -- Please set it first, then make the build !" ;  \
	fi
