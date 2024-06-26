@echo off

REM        -=INIT.CMD Documentation and Installation Instructions=-

REM INIT.CMD is a solution to the lack of a startup script for Command Prompt. 
REM It is intended to function like .profile or .bashrc does on Linux systems, 
REM and provides lots of DOSKEY aliases to make Command Prompt feel like Bash.

REM INIT.CMD can be executed manually, but to configure automatically 
REM running on launch, add a registry key to the following path:
REM HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor
REM Add a new Expandable String Value (REG_EXPAND_SZ) there and call it Autorun
REM Then give this key the following contents, including the quotations:
REM "%userprofile%\INIT.CMD"

REM =============================================

REM ===Environment Setup===
title System Terminal - %COMPUTERNAME%

REM ===Commodore 64 theme===
REM Instructions for setup
REM Colour values:
REM 	Background: 62/49/162
REM 	Text colour: 124/112/218
REM Font:
REM 	16pt Lucidia Sans Typewriter with Bold Fonts enabled
REM The following code prints the startup text.
cls
echo.
REM Check if Python 3 is installed and respond accordingly
where python >NUL 2>NUL
if %ERRORLEVEL% equ 0 (
	REM Uses Python to centre the banner text. Needs Python 3 due to the use of a lambda.
	python -c "centre=lambda s: print(int(max(0,(__import__('shutil').get_terminal_size()[0]-len(s))/2-1))*' '+s);centre('**** COMMODORE 64 BASIC V2 ****');centre('64K RAM SYSTEM  38911 BASIC BYTES FREE')"
) else (
	REM Manual spacing will have to do.
	echo         **** COMMODORE 64 BASIC V2 ***
	echo     64K RAM SYSTEM  38911 BASIC BYTES FREE
)
prompt READY$_

REM ===Unix mimicking===
doskey ls=dir $*
doskey cat=type $*
doskey cp=copy $*
doskey mv=move $*
doskey rm=del $*
doskey touch=copy NUL $1
doskey pwd=cd
doskey clear=cls
doskey ip=ipconfig $*
doskey which=where $*
doskey less=type $1 $b more
doskey unset=set $1=
doskey alias=doskey $*
doskey aliases=doskey/macros:all
doskey history=doskey/history
doskey killall=taskkill /f /im $1
doskey poweroff=shutdown /s /f /t 0
doskey reboot=shutdown /r /f /t 0
set ~=%USERPROFILE%

REM ===Other macros/aliases===
doskey mkcd=@echo off $T mkdir $1 $T cd $1 $T echo on
doskey help=@echo off $T help $1 $T doskey/macros:all $T echo on
doskey q=exit

REM Specifies a default username for ssh sessions.
REM By placing the username after the arguments, the default can be overridden
REM because OpenSSH uses the first username if it is specified multiple times.
doskey ssh=ssh -l kaizen

REM Detect the presence of an editor and set the edit alias accordingly.
goto install_edit_alias
:test_for_editor
where %1 >NUL 2>NUL
if %ERRORLEVEL% equ 0 (
	rem yay
	echo success
	doskey edit=%1 $*
	exit /b 0
)
REM nay
exit /b 1

:install_edit_alias
REM Loop over editor commands is defined here. Notepad is used as a fallback
setlocal EnableDelayedExpansion
for %%i in (vim vi nano notepad) do (
	<NUL set /p=%%i... 
	call :test_for_editor %%i
	if !ERRORLEVEL! equ 0 (goto end_edit_setup)
)
REM This shouldn't happen, but if no editor was found then it's worth mentioning.
echo No editor found!
:end_edit_setup

REM Detect the presence of Firefox, and set the alias to either of the possible
REM executables, or to instead output an error message if neither were found.
set "ff=C:\Program Files\Mozilla Firefox\firefox.exe"
set "ffdev=C:\Program Files\Firefox Developer Edition\firefox.exe"
if exist "%ff%" (
	REM Firefox detected
	doskey firefox="%ff%" $*
) else if exist "%ffdev%" (
	REM Firefox developer detected
	doskey firefox="%ffdev%" $*
) else (
	REM No firefox detected
	doskey firefox=echo No Firefox install was found.
)
set ff=
set ffdev=
