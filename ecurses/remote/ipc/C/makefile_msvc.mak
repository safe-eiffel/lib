CC = cl
PLATFORM=windows
CFLAGS = -c -Ox -W3 -I$(ISE_EIFFEL)\studio\spec\$(PLATFORM)\include -I.
OBJ = ipc_c.obj

all:: clean ipc_c.lib

.c.obj:
	$(CC) $(CFLAGS) .\$< 

ipc_c.lib: $(OBJ) .\ipc_c.h
		del $@
		lib /OUT:$@ $(OBJ)

ipc_c.obj: .\ipc_c.c .\ipc_c.h
	$(CC) $(CFLAGS) .\ipc_c.c

clean:
	del *.obj
	del *.lib
