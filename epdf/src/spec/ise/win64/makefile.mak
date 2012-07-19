CC = cl
ISE_PLATFORM=win64
CFLAGS = -c -Ox -W2 -I"$(ISE_EIFFEL)\studio\spec\$(ISE_PLATFORM)\include" -I. -I$(ZLIB) -I$(LIBPNG)
OBJ = epdf_msc.obj

all:: epdf_var epdf_msc.lib

.c.obj:
	$(CC) $(CFLAGS) ..\..\C\$< 

epdf_msc.lib: $(OBJ) ..\..\C\epdf_c.h
	lib /OUT:$@ $(OBJ)

epdf_msc.obj: epdf_var ..\..\C\epdf_c.c ..\..\C\epdf_c.h
	$(CC) $(CFLAGS) /Foepdf_msc.obj ..\..\C\epdf_c.c

clean:
	-del *.obj
	-del *.lib

epdf_var:
! IFNDEF EPDF
!    ERROR EPDF environment variable not set ! Set it first, then make the build.
! ENDIF
! IFNDEF ISE_EIFFEL
!    ERROR ISE_EIFFEL environment variable not set ! Set it first, then make the build.
! ENDIF
! IFNDEF ISE_PLATFORM
!    ERROR ISE_PLATFORM environment variable not set ! Set it first, then make the build. Valid values are windows, linux.
! ENDIF
! IFNDEF ZLIB
!    ERROR ZLIB environment variable not set ! Set it first, then make the build.
! ENDIF
! IFNDEF LIBPNG
!    ERROR LIBPNG environment variable not set ! Set it first, then make the build.
! ENDIF

