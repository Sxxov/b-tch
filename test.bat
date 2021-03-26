@echo off

setlocal EnableDelayedExpansion

call :$.core

REM !$!.performance.measure

REM for /l %%i in (0, 1, 100) do (
REM 	REM echo %%i >nul
REM 	!$!.echo.log %%i
REM )

REM !$!.performance.measure ^
REM 	%>:$=performanceResult%
REM !$!.time.msToHuman !performanceResult! ^
REM 	%>:$=humanTime%
REM !$!.echo.log PerformanceResult, "!humanTime!"

REM set "arrayVariableKey=arr"
REM set "!arrayVariableKey!="
REM set /a "!arrayVariableKey!.length=0"
REM !$!.echo.log "!arr!"

REM for %%b in (!arrayVariableKey!) do (
REM 	set "!arrayVariableKey!=!%%b!, aaa"
REM 	!$!.echo.log "!%%b!"
REM )

REM for %%b in (!arrayVariableKey!) do (
REM 	set "!arrayVariableKey!=!%%b!^, aaa"
REM 	!$!.echo.log "!%%b!"
REM )

REM set /a "!arrayVariableKey!.length+=1"

@REM !$!.array.new arr
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooooooooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooooooooooooooooooooooooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooooooooooooooooooooooooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooooooooooooooooooooooooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooooooooooooooooooooooooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooooooooooooooooooooooooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooooooooooooooooooooooooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooooooooooooooooooooooooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooooooooooooooooooooooooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooooooooooooooooooooooooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooooooooooooooooooooooooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooooooooooooooooooooooooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooooooooooooooooooooooooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooooooooooooooooooooooooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooooooooooooooooooooooooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
@REM !$!.array.push arr helloooooooooooooooooooooooooooooooooo
@REM !$!.performance.measure %>:$=a% & echo !a!
set arr[0]=0
set arr[1]=1
set arr[2]=2
set arr[3]=3
set arr[4]=4
set arr[5]=5
set arr[6]=6
set arr[7]=7
set arr[8]=8
set arr[9]=9
set arr[10]=10
set arr[11]=11
set arr[12]=12

%forof:$=arr% (
	%$%.echo.log %%a
)

%$%.array.join arr ^
	%>:$=arrString%

%$%.echo.log "[!arrString!]"

%$%.su ^
	%>:$=suResult%

%$%.echo.log "!suResult!"

%$%.time.humanToMS %time% ^
	%>:$=ms%

%$%.time.mstoHuman !ms! ^
	%>:$=human%

%$%.echo.log "!ms! !human!"

@REM call :echoArgs("a", "b", "c")

REM if "%1" equ "Animate" goto %1

REM set "commands=w a s d"

REM for %%a in (%commands%) do set "com[%%a]=1"
REM for /F %%a in ('echo prompt $H ^| cmd') do set "BS=%%a"
REM for /F %%a in ('copy /Z "%~F0" NUL') do set "CR=%%a"

REM start "" /B "%~F0" Animate

REM set "command="
REM :nextKey
REM    set "key="
REM    for /F "delims=" %%K in ('xcopy /W "%~F0" "%~F0" 2^>NUL') do if not defined key set "key=%%K"
REM REM    if "!key:~-1!" equ "!CR!" goto endCommand
REM    if "!key:~-1!" equ "!BS!" (
REM       if defined command (
REM          set "command=%command:~0,-1%"
REM          set /P "=.!BS!!BS!  !BS!!BS!" < NUL
REM       )
REM    ) else if "!key:~-1!" neq " " (
REM       set "command=%command%!key:~-1!"
REM       set /P "=!key:~-1!" < NUL
REM       if defined com[!command!] goto endCommand
REM    )
REM goto nextKey
REM :endCommand
REM set "running=false"
REM REM taskkill /FI "WindowTitle eq GAME_ENGINE_AAA" /T /F
REM echo/
REM echo/
REM echo command read: "%command%"

call :blockedFunction

goto :eof

REM :Animate
REM set "banner=                              Enter your name please                              "
REM set m=0
REM :loop
REM 	echo !running!
REM 	if "!running!" == "false" exit
REM REM    if not exist input.txt exit
REM    set /A m=(m+1)%%51
REM    cls
REM    echo/
REM    echo/     !banner:~%m%,31!
REM    echo/
REM    echo/
REM REM    if exist input.txt (type input.txt) else exit
REM    ping -n 1 -w 300 localhost > NUL
REM    ping -n 1 -w 300 localhost > NUL
REM    ping -n 1 -w 300 localhost > NUL
REM goto loop
REM :notloop

:blockedFunction
%@:$=blocked%
%function%
(
	echo "%0" "%1" "%2"
	%return%
)

:blocked
%function:$=methodName%
(
	echo blocking: !methodName!

	%return:$=goto :eof%
)

:$.core
:$.su
:$.echo.log
:$.echo.error
:$.performance.measure
:$.time.msToHuman
:$.time.humanToMS
:$.try
:$.throwing
:$.array.new
:$.array.push
:$.array.pop
:$.array.set
:$.array.forEach
:$.array.join
b#tch %*

