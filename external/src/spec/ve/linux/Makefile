SHELL = /bin/sh
CC = cc
AR = ar
RANLIB = ranlib
CFLAGS =  -O -I$(VE_Bin) -I. -I/usr/local/include
RM = /bin/rm -f
SRC = $(SAFE_KERNEL)/src/spec/C
OBJ = xs_c.o

.c.o:
	$(CC) $(CFLAGS) -c $(SRC)/$<

libxs_c.a: xs_cvar $(OBJ)
	$(AR) -ru $@ $(OBJ)
	$(RANLIB) $@

xs_c.o:  $(SRC)/xs_c.c
	$(CC) $(CFLAGS) -c $<

.PHONY: all clean xs_cvar

clean:
	$(RM) libxs_c.a $(OBJ)

all: xs_cvar libxs_c.a 

xs_cvar:
	@if test -z "$(SAFE_KERNEL)" ; then \
		 echo "* ERROR * -- SAFE_KERNEL variable not set "; \
		 echo "*         -- Please set it first, then make the build !" ;  \
	fi
