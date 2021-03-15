REM setlocal EnableDelayedExpansion

:$.core

@REM rem util: ""language features""
@REM set "return=set returned=val&& goto :eof"
@REM set "returnTo=set returned=val&& goto "
@REM set "returned="
@REM set "throw=set __thrown=err&& if ^"^^^!__isTryBlock^^^!^" == ^"true^" ^(goto :eof ^) else ^(call :__exception err^)"
@REM set "throwing=set __thrown=err"
@REM set "try=set __thrown=null&&set __isTryBlock=true&&if a==a "
@REM set "catch=&&set __isTryBlock=false&&if not ^".^^^!__thrown^^^!^" == ^".^^^!__thrown:err=^^^!^""
@REM set "public=if ^^^!__intent^^^! == query set query.result=granted&& (goto :eof)"
@REM set "private=if ^^^!__intent^^^! == query if ^^^!su.isEnabled^^^! == true (set query.result=granted) else (set query.result=denied)&& (goto :eof)"

@REM rem util: APIs
@REM set "echo.log=set __echoPrefix=Log: code,& set __rawC=code& set __cSubstr=^^^!__rawC:cod=^^^!&& (if .^^^!__cSubstr^^^! == .e set __echoPrefix=Log:) && echo ^^^!__echoPrefix^^^!"
@REM set "echo.warn=!echo.log:Log=Warn!"
@REM set "echo.error=!echo.log:Log=Error!"
@REM set "query.result="
@REM set "query.ifAccessible=set query.result=& set __intent=query& call :function >nul 2>&1 & set __intent=& if ^^^!query.result^^^!==granted "
@REM set "query.ifExists=set query.result=null& set __intent=query& call :function >nul 2>&1 & set __intent=& if not ^^^!query.result^^^!==null "
@REM set "su.isEnabled=false"

:: ----------- GLOBALS -----------
set "DOLLAR_CHAR=$"

:: ----------- class -----------
:: @type	keyword
:: @example	`%class% ()`
REM call set "[[class]].name=%%0"
REM set "![[class]].name!=call :![[class]].name!"
set "class=set "[[class]].name=%%0"&&set "![[class]].name!=call :![[class]].name!""
set "private=![[class]].name!.private"
set "public=![[class]].name!"

:: ----------- $ -----------
:: @type	keyword
:: @param	<string>, functionKey
:: @example	`!$!.func param1 param2`
set "$=call :$"

:: ----------- > -----------
:: @type	keyword
:: @$param	<string>, variableKey
:: @example	`
::				!$!.func param1 param2 ^
::					%>:$=returnedValue%
::			`
set "^>=& set "$=^^^!returned^^^!""

:: ----------- function -----------
:: @type	keyword
:: @$param	<ArrayString>, function parameters
:: @example	`
::				:func
:: 				%function:$=param1, param2%
::				(
::					rem ...
::				)
::			`
:: @source
REM set [[arguments]].keysString=$
REM if "![[arguments]].keysString!" == "!DOLLAR_SIGN!" (
REM 	set [[arguments]].keysString=
REM		set [[arguments]].keys.length=0
REM		set [[arguments]].values.length=0
REM ) else (
REM 	set /a [[i]]=0
REM 	(
REM			for %%a in ("%[[arguments]].keysString:, =" "%") do (
REM 			rem echo ![[i]]!, %%~a, %![[i]]!%
REM 			set [[arguments]].keys[![[i]]!]=%%~a
REM 			set /a [[i]]+=1
REM 		)
REM		)
REM 	set /a [[arguments]].keys.length=![[i]]! + 1
REM 	set /a [[i]]=0
REM 	call set [[arguments]].valuesString=%%*
REM 	(
REM			for %%a in (![[arguments]].valuesString!) do (
REM 			for %%b in (![[i]]!) do (
REM 				rem echo ![[arguments]].keys[%%b]!
REM					set "[[arguments]].values[%%b]=%%~a" 2>nul
REM 				set "![[arguments]].keys[%%b]!=%%~a" 2>nul
REM 			)
REM 			set /a [[i]]+=1
REM 		)
REM		)
REM 	set /a [[arguments]].values.length=![[i]]! + 1
REM 	set [[i]]=
REM )
REM set /a "[[gc]].currentScope+=1"
REM set /a "[[gc]].previousScope=![[gc]].currentScope! - 1"
REM	set /a "[[i]]=0"
REM if not "![[arguments]].valuesString:#=!" == "![[arguments]].valuesString!"
REM	(
REM		for /f "tokens=* usebackq" %%a in (`set # 2>nul`) do (
REM			for /f "tokens=1-2 delims==" %%c in ("%%a") do (
REM				(
REM					set "[[gc]].scopes[![[gc]].currentScope!].trackedVariables[![[i]]!]=%%c"
REM					(
REM						for /f "tokens=1 usebackq" %%d in (`set [[gc]].scopes[![[gc]].previousScope!].trackedVariables[ 2>nul`) do (
REM							if "!%%d!" == "%%c" (
REM								set "[[gc]].scopes[![[gc]].currentScope!].trackedVariables[![[i]]!]="
REM							)
REM						)
REM					)
REM					set /a "[[i]]+=1"
REM				)
REM			)
REM		)
REM	)
set "[[i]]="
set "[[arguments]].index.currentStackIndex=0"
set "[[arguments]].index.previousStackIndex=0"
set "[[arguments]].index.stack[0]=0"
set "[[gc]].currentScope=0"
set "[[gc]].previousScope=-1"
set "[[gc]].scopes[0].trackedVariables="
set "[[arguments]].keyString="
set "[[arguments]].keys="
set "[[arguments]].keys.length="
set "[[arguments]].valuesString="
set "[[arguments]].values="
set "[[arguments]].values.length="
@REM set "function=set [[arguments]].keysString=$&&if "^^^![[arguments]].keysString^^^!" == "^^^!DOLLAR_SIGN^^^!" (set [[arguments]].keysString=&&set [[arguments]].keys.length=0&&for %%a in ("^^^![[arguments]].index.currentStackIndex^^^!") do (for %%b in ("^^^![[arguments]].index.previousStackIndex^^^!") do (set "[[arguments]].index.stack[%%~a]=^^^![[arguments]].index.stack[%%~b]^^^!"&&set /a "[[arguments]].index.previousStackIndex=%%a"&&set /a "[[arguments]].index.currentStackIndex=%%a + 1"))) else ((set /a [[i]]=0&&for %%a in ("^^^![[arguments]].keysString:, =" "^^^!") do (set [[arguments]].keys[^^^![[i]]^^^!]=%%~a&&set /a [[i]]+=1 ))&&set /a [[arguments]].keys.length=^^^![[i]]^^^! + 1&&set /a [[i]]=0&&call set [[arguments]].valuesString=%%*&&(for %%a in (^^^![[arguments]].valuesString^^^!) do ((for %%b in (^^^![[i]]^^^!) do (set "[[arguments]].values[%%b]=%%~a" 2>nul&&set "^^^![[arguments]].keys[%%b]^^^!=%%~a"2>nul))&&set /a [[i]]+=1))&&set /a [[arguments]].values.length=^^^![[i]]^^^! + 1&&set [[i]]=&&for %%a in ("^^^![[arguments]].index.currentStackIndex^^^!") do (set "[[arguments]].index.stack[%%~a]=^^^![[arguments]].values.length^^^!"&&set /a "[[arguments]].index.previousStackIndex=%%a"&&set /a "[[arguments]].index.currentStackIndex=%%a + 1"))"
@REM set "function=set [[arguments]].keysString=$&&if "^^^![[arguments]].keysString^^^!" == "^^^!DOLLAR_SIGN^^^!" (set [[arguments]].keysString=&&set [[arguments]].keys.length=0&&set [[arguments]].values.length=0) else ((set /a [[i]]=0&&for %%a in ("^^^![[arguments]].keysString:, =" "^^^!") do (set [[arguments]].keys[^^^![[i]]^^^!]=%%~a&&set /a [[i]]+=1 ))&&set /a [[arguments]].keys.length=^^^![[i]]^^^! + 1&&set /a [[i]]=0&&call set [[arguments]].valuesString=%%*&&(for %%a in (^^^![[arguments]].valuesString^^^!) do ((for %%b in (^^^![[i]]^^^!) do (set "[[arguments]].values[%%b]=%%~a" 2>nul&&set "^^^![[arguments]].keys[%%b]^^^!=%%~a"2>nul))&&set /a [[i]]+=1))&&set /a [[arguments]].values.length=^^^![[i]]^^^! + 1&&set [[i]]=)"
@REM set "function=set [[arguments]].keysString=$&&if "^^^![[arguments]].keysString^^^!" == "^^^!DOLLAR_SIGN^^^!" (set [[arguments]].keysString=&&set [[arguments]].keys.length=0&&set [[arguments]].values.length=0) else ((set /a [[i]]=0&&for %%a in ("^^^![[arguments]].keysString:, =" "^^^!") do (set [[arguments]].keys[^^^![[i]]^^^!]=%%~a&&set /a [[i]]+=1 ))&&set /a [[arguments]].keys.length=^^^![[i]]^^^! + 1&&set /a [[i]]=0&&call set [[arguments]].valuesString=%%*&&(for %%a in (^^^![[arguments]].valuesString^^^!) do ((for %%b in (^^^![[i]]^^^!) do (set "[[arguments]].values[%%b]=%%~a" 2>nul&&set "^^^![[arguments]].keys[%%b]^^^!=%%~a"2>nul))&&set /a [[i]]+=1))&&set /a [[arguments]].values.length=^^^![[i]]^^^! + 1&&set [[i]]=)&&set /a "[[gc]].currentScope+=1"&set /a "[[gc]].previousScope=^^^![[gc]].currentScope^^^! - 1"&set /a "[[i]]=0"&(for /f "tokens=* usebackq" %%a in (`set # 2^^^>nul`) do (for /f "tokens=1-2 delims==" %%c in ("%%a") do ((set "[[gc]].scopes[^^^![[gc]].currentScope^^^!].trackedVariables[^^^![[i]]^^^!]=%%c"&(for /f "tokens=1 usebackq delims==" %%d in (`set [[gc]].scopes[^^^![[gc]].previousScope^^^!].trackedVariables[ 2^^^>nul`) do (if "^^^!%%d^^^!" == "%%c" (set "[[gc]].scopes[^^^![[gc]].currentScope^^^!].trackedVariables[^^^![[i]]^^^!]=")))&set /a "[[i]]+=1"))))"
set "function=set [[arguments]].keysString=$&&if "^^^![[arguments]].keysString^^^!" == "^^^!DOLLAR_SIGN^^^!" (set [[arguments]].keysString=&&set [[arguments]].keys.length=0&&set [[arguments]].values.length=0) else ((set /a [[i]]=0&&for %%a in ("^^^![[arguments]].keysString:, =" "^^^!") do (set [[arguments]].keys[^^^![[i]]^^^!]=%%~a&&set /a [[i]]+=1 ))&&set /a [[arguments]].keys.length=^^^![[i]]^^^! + 1&&set /a [[i]]=0&&call set [[arguments]].valuesString=%%*&&(for %%a in (^^^![[arguments]].valuesString^^^!) do ((for %%b in (^^^![[i]]^^^!) do (set "[[arguments]].values[%%b]=%%~a" 2>nul&&set "^^^![[arguments]].keys[%%b]^^^!=%%~a"2>nul))&&set /a [[i]]+=1))&&set /a [[arguments]].values.length=^^^![[i]]^^^! + 1&&set [[i]]=)&&set /a "[[gc]].currentScope+=1"&set /a "[[gc]].previousScope=^^^![[gc]].currentScope^^^! - 1"&set /a "[[i]]=0"&if not "^^^![[arguments]].valuesString:#=^^^!" == "^^^![[arguments]].valuesString^^^!" (for /f "tokens=* usebackq" %%a in (`set # 2^^^>nul`) do (for /f "tokens=1-2 delims==" %%c in ("%%a") do ((set "[[gc]].scopes[^^^![[gc]].currentScope^^^!].trackedVariables[^^^![[i]]^^^!]=%%c"&(for /f "tokens=1 usebackq delims==" %%d in (`set [[gc]].scopes[^^^![[gc]].previousScope^^^!].trackedVariables[ 2^^^>nul`) do (if "^^^!%%d^^^!" == "%%c" (set "[[gc]].scopes[^^^![[gc]].currentScope^^^!].trackedVariables[^^^![[i]]^^^!]=")))&set /a "[[i]]+=1"))))"


:: ----------- return -----------
:: @type	keyword
:: @$param	<any>, value to return
:: @example	`
::				:func
:: 				%function:$=param1, param2%
::				(
::					if "!param1!" == false %return:$=1%
::
::					rem ...
::					%return:$=0%
::				)
::			`
:: @source
REM set [[return]].value=$
REM if "$" == "!DOLLAR_CHAR!" (
REM 	set [[return]].value=
REM		set returned=![[return]].value!
REM )
REM	
REM	set /a "[[i]]=0"
REM					
REM	(
REM		for /f "tokens=1 usebackq delims==" %%b in (`set [[gc]].scopes[![[gc]].currentScope!].trackedVariables[ 2>nul`) do (
REM			set "!%%b!="
REM			set "[[gc]].scopes[![[gc]].currentScope!].trackedVariables[![[i]]!]="
REM			
REM			set /a "[[i]]+=1"
REM		)
REM	)
REM	
REM	set /a "[[gc]].currentScope-=1"
REM set /a "[[gc]].previousScope=![[gc]].currentScope! - 1"
REM goto :eof
set "[[return]].value="
set "returned="
@REM set "return=set [[return]].value=$&(if "$" == "^^^!DOLLAR_CHAR^^^!" (set [[return]].value=))&set returned=^^^![[return]].value^^^!&((for %%a in ("^^^![[arguments]].index.currentStackIndex^^^!") do ((for %%b in ("^^^![[arguments]].index.previousStackIndex^^^!") do (if not "%%a" == "%%b" (for /l %%i in ("^^^![[arguments]].index.stack[%%~b]^^^!", 1, "^^^![[arguments]].index[%%~a]^^^!") do (set ^^^![[arguments]].keys[%%~i]^^^!=2>nul))))&set "[[arguments]].index.stack[%%~a]="))&set /a "[[arguments]].index.currentStackIndex-=1"&set /a "[[arguments]].index.previousStackIndex-=1")&goto :eof"
@REM set "return=set [[return]].value=$&(if "$" == "^^^!DOLLAR_CHAR^^^!" (set [[return]].value=))&set returned=^^^![[return]].value^^^!&(for /l %%i in (0, 1, ^^^![[arguments]].keys.length^^^!) do (set ^^^![[arguments]].keys[%%i]^^^!=2>nul))&goto :eof"
@REM set "return=echo ret&set [[return]].value=$&(if "$" == "^^^!DOLLAR_CHAR^^^!" (set [[return]].value=))&set returned=^^^![[return]].value^^^!&set /a "[[i]]=0"&(for /f "tokens=1 usebackq delims==" %%b in (`set [[gc]].scopes[^^^![[gc]].currentScope^^^!].trackedVariables[`) do (set [[gc]].scopes[^^^![[gc]].currentScope^^^!].trackedVariables[&echo gcing ^^^!%%b^^^! at ^^^![[gc]].currentScope^^^!&set ^^^!%%b^^^!=&set "[[gc]].scopes["&set "[[gc]].scopes[^^^![[gc]].currentScope^^^!].trackedVariables[^^^![[i]]^^^!]="&set /a "[[i]]+=1"))&set /a "[[gc]].currentScope-=1"&set /a "[[gc]].previousScope=^^^![[gc]].currentScope^^^! - 1"&goto :eof"
set "return=set [[return]].value=$&(if "$" == "^^^!DOLLAR_CHAR^^^!" (set [[return]].value=))&set returned=^^^![[return]].value^^^!&set /a "[[i]]=0"&(for /f "tokens=1 usebackq delims==" %%b in (`set [[gc]].scopes[^^^![[gc]].currentScope^^^!].trackedVariables[ 2^^^>nul`) do (set ^^^!%%b^^^!=&set "[[gc]].scopes[^^^![[gc]].currentScope^^^!].trackedVariables[^^^![[i]]^^^!]="&set /a "[[i]]+=1"))&set /a "[[gc]].currentScope-=1"&set /a "[[gc]].previousScope=^^^![[gc]].currentScope^^^! - 1"&goto :eof"

:: ----------- forin -----------
:: @type	keyword
:: @$param	<string>, variableKey
:: @example	`
::				%forin:$=items% (
::					echo key=%%a
::					echo value=%%b
::				)
set "forin=for /f "tokens=2 delims==" %%a in ('set $[') do "

:: ----------- core -----------
:: @type	function<meta>
:: @example	`call ::core`
if not "%*" == "" (
	call :%*
)
rem else, just load side effects
goto :eof

:: ----------- noop -----------
:: @type	function
:: @example	`!$!.noop`
:$.noop
(
	goto :eof
)

:: ----------- su -----------
:: @type	function
:: @param	<boolean>, newState
:: @example	`!$!.su true`
set "su.isEnabled="
:$.su
%function:$=_newState%
(
	if "!_newState!" == "" (
		if "!su.isEnabled!" == "true" (
			set _newState=false
		) else (
			set _newState=true
		)
	)

	set "su.isEnabled=!_newState!"

	%return:$=!su.isEnabled!%
)

:: ----------- echo -----------
:: @type	function
:: @param	<string>, level
:: @param	<string>, tag
:: @param	<string>, message
:: @example	`!$!.echo Log, Foo, BarMessage`
:$.echo 
(
	set "tagDelimiter="

	rem if no tag provided, tag becomes the message
	if not "%3" == "" (
		set "tagDelimiter=, "
	)

	echo %1: %2!tagDelimiter!%3

	goto :eof
)
:: @type	function
:: @param	<string>, tag
:: @param	<string>, message
:: @example	`!$!.echo.log Foo, BarMessage`
:$.echo.log
(
	set "tagDelimiter="

	rem if no tag provided, tag becomes the message
	if not "%2" == "" (
		set "tagDelimiter=, "
	)

	echo Log: %1!tagDelimiter!%2

	goto :eof
)
:: @type	function
:: @param	<string>, tag
:: @param	<string>, message
:: @example	`!$!.echo.warn Foo, BarMessage`
:$.echo.warn
(
	set "tagDelimiter="

	rem if no tag provided, tag becomes the message
	if not "%2" == "" (
		set "tagDelimiter=, "
	)

	echo Warn: %1!tagDelimiter!%2

	goto :eof
)
:: @type	function
:: @param	<string>, tag
:: @param	<string>, message
:: @example	`!$!.echo.error Foo, BarMessage`
:$.echo.error
(
		set "tagDelimiter="

	rem if no tag provided, tag becomes the message
	if not "%2" == "" (
		set "tagDelimiter=, "
	)

	echo Error: %1!tagDelimiter!%2

	goto :eof
)

:: ----------- performance -----------
:: @type	function
:: @return	<number>
:: @example	`!$!.performance.now`
:$.performance.now
%function:$=%
(
	for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
		set /a "now=(((%%a*60)+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100"
	)

	%return:$=!now!%
)
:: @type	function
:: @return	<number>
:: @example	`
::				!$!.performance.measure
::				rem ...
::				!$!.performance.measure ^
::					%>:$=performanceMeasureResult%
::			`
set "performance.measure.lastTime="
:$.performance.measure
%function:$=%
(
	if "!performance.measure.lastTime!" == "" (
		!$!.performance.now ^
			%>:$=performanceNowResult%

		set /a "performance.measure.lastTime=!performanceNowResult!"

		%return:$=0%
	)

	!$!.performance.now ^
		%>:$=performanceNowResult%

	set /a "difference=!performanceNowResult! - !performance.measure.lastTime!"
	set /a "performance.measure.lastTime=!performanceNowResult!"

	%return:$=!difference!%
)

:: ----------- time -----------
:: @type	function
:: @param	<number>, ms
:: @return	<number>
:: @example	`
::				!$!.time.msToHuman !fooMilliseconds! ^
::					%>:$=humanTime%
::			`
:$.time.msToHuman
%function:$=_ms%
(
	set /a "hh=_ms / (60 * 60 * 100)"
	set /a "rest=_ms %% (60 * 60 * 100)"
	set /a "mm=rest / (60 * 100)"
	set /a "rest%%=60 * 100"
	set /a "ss=rest / 100"
	set /a "cc=rest %% 100"

	set hh=0!hh!
	set mm=0!mm!
	set ss=0!ss!
	set cc=0!cc!

	set "humanTime=!hh:~-2!:!mm:~-2!:!ss:~-2!:!cc:~-2!"

	%return:$=!humanTime!%
)
:$.time.humanToMS
%function:$=_humanTime%
(
	set /a "ms=0"
	for /f "tokens=1-3 delims=:" %%a in ("!_humanTime!") do (
		set /a "hh=%%a"
		set /a "mm=%%b"
		for /f "tokens=1-2 delims=." %%d in ("%%c") do (
			set /a "ss=%%d"
			set /a "cc=%%e"
		)

		set /a "ms+=!hh! * 60 * 60 *100"
		set /a "ms+=!mm! * 60 * 100"
		set /a "ms+=!ss! * 100"
		set /a "ms+=!cc!"
	)

	%return:$=!ms!%
)

:: ----------- array -----------
:: @type	function
:: @param	<number>, ms
:: @return	<number>
:: @example	`
::				!$!.time.msToHuman !fooMilliseconds! ^
::					%>:$=humanTime%
::			`
:$.array.length
%function:$=_arrayVariableKey%
(
	set /a "i=0"
	%forin:$=!_arrayVariableKey!% (
		set /a "i+=1"
	)

	%return:$=!i!%
)
:$.array.push
%function:$=_arrayVariableKey, _newItem%
(
	for %%a in (!_arrayVariableKey!) do (
		if "!%%a[0]!" == "" (
			set "%%a[0]=!_newItem!"

			%return:$=!length!%
		)

		!$!.array.length !_arrayVariableKey! ^
			%>:$=length%

		set "%%a[!length!]=!_newItem!"
	)

	%return:$=!length!%
)
:$.array.pop
%function:$=_arrayVariableKey%
(
	!$!.array.length !_arrayVariableKey! ^
		%>:$=length%
	
	set /a "arrayLastElementIndex=!length! - 1"

	for %%a in (!_arrayVariableKey!) do (
		set "popped=%%a[!arrayLastElementIndex!]"
		set "%%a[!arrayLastElementIndex!]="
	)

	%return:$=!popped!%
)
:$.array.join
%function:$=_arrayVariableKey, _delimiter%
(
	if "!_delimiter!" == "" (
		set "_delimiter=, "
	)

	set "string="
	%forin:$=!_arrayVariableKey!% (
		if "!string!" == "" (
			set "string=%%a"
		) else (
			set "string=!string!!_delimiter!%%a"
		)
	)

	%return:$=!string!%
)
rem todo: rewrite to not depend on `.length` prop, which was removed in favour of `array.length()`
@REM :$.array.forEach
@REM %function:$=_arrayVariableKey, callbackLabel%
@REM (
@REM 	for %%a in (!_arrayVariableKey!) do (
@REM 		for /l %%i in (0, 1, !%%a.length!) do (
@REM 			set "!arrayPartVariableKey!=!%%a[%%i]!"
@REM 			call :callbackLabel
@REM 		)
@REM 	)
@REM 	%return%
@REM )

:$.environment.keys
%function:$=%
(
	for /f "tokens=* usebackq" %%a in (`set`) do (
		set /a "i=0"
		!$!.array.new "result"
		
		for /f "tokens=1,2 delims==" %%b in ("%%a") do (
			set "result[!i!]=%%b"
		)
	)

	%return:$=!result!%
)


:: ----------- [[onUncaughtException]] -----------
:$.[[onUncaughtException]]
%function:$=_id%
(
    for /f "tokens=1 delims=: usebackq" %%l in (`findstr /N "!_id!" "%~f0"`) do (
        set /a "lineNumber=%%l"
    )

    !$!.echo.error UncaughtException ^(!_id! at line !lineNumber!^)
    !$!.echo.error UncaughtException Press any key to terminate...

    pause >nul

	!$!.exit 1
)