@echo off
rem -- ECURSES build procedure
rem -- (c) 2000 - Paul G. Crismer, Fafchamps Eric
rem -- Released under the Eiffel-Forum Licence : see forum.txt

echo ** ECURSES build procedure **

rem -- path of ECURSES
if "%ECURSES%"=="" goto varecurseserr

rem -- compilation variables
set LIBS=%ECURSES%\spec\se\windows\ecurses_c.lib %PDCURSES%\win32\pdcurses.lib %PDCURSES%\win32\panel.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib
set SEFLAGS=-case_insensitive -no_style_warning
set BUILDFLAGS=-I%ECURSES%\spec\se\windows

rem
rem -- Test for target and creation feature
rem
if "%1%"=="" goto targeterr
set TARGET=%1%
if "%2%"=="" goto creationerr
set CREATION=%2%

echo *  Building %TARGET% creation %CREATION%

rem -- Compile
 
compile %SEFLAGS% %BUILDFLAGS% %LIBS% %TARGET% %CREATION%
goto done

:targeterr
echo    Missing argument "target-class"

:creationerr
echo    Missing argument "creation-feature"

:usage
echo Usage : "ECURSESBUILD <target-class> <creation-feature>"
goto done

:varecurseserr
echo Error : ECURSES variable not set !

:done
 
