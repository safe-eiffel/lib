REM Build procedure for ecurs_server using SmallEiffel and MSVC

SET SEFLAGS=-case_insensitive -no_style_warning -no_warning -no_check
SET ROOTCLASS=ROOT_CLASS
SET TARGET=rcurses
SET CREATION=make
clean %ROOTCLASS%
compile_to_c %SEFLAGS% %ROOTCLASS% %CREATION%
NMAKE -F makefile

PAUSE


REM
REM Copyright: 2001, Eric Fafchamps, <eric.fafchamps@belgacom.net>
REM Released under the Eiffel Forum License <www.eiffel-forum.org>
REM See file <forum.txt>
REM
