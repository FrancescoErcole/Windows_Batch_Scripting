@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL EnableDelayedExpansion

:: In this loop we parse each file with extension "*.TXT"
:MAIN
:: Create empty output file
echo. 2>output.txt 
for /r %%i in (input\*.TXT) do (
	echo Processing file %%i
	echo File: %%i >> output.txt

	REM 1) Spit number of rows of the file
	for /f %%c in ('type "%%i"^|find /C /v  "" ') do @echo N rows: %%c >> output.txt

	REM 2) Write keycode distribution
	call :PARSE_FILE %%i

	echo. >> output.txt
)
goto :EOF

:: In this function we parse the first line of the file (%~1) to store in which column the keycode is.
:: Then, we create the keycode distribution.
:: Then, we spit the number of rows
:PARSE_FILE
	set /A keycode_column_idx=0
	for /F "tokens=*" %%A in (%~1) do (
		for %%B in (%%A) do (
			set /A keycode_column_idx=!keycode_column_idx!+1
			set str=%%B
			REM Regex expression for keycode (ACGT sequences)
			Echo.!str! | findstr /irc:"^[ACGT][ACGT][ACGT][ACGT][ACGT] "  >nul
			if !errorlevel!==0 (
				call :GET_KEYCODE_DISTRIBUTION %~1 !keycode_column_idx!
				goto :EOF
			)
		)

		REM It happens if the keycode does not appear in first line (for example there is a header) 
		echo ERROR: keycode column not found in %~1. Please check its first line
		echo.
		goto :EOF
	)

:: This function parse the file to create a dictionary of frequency for the keycodes.
:: Then, it writes the result to the file
:GET_KEYCODE_DISTRIBUTION
	REM Clear keycode dictionary
	for /f "delims== tokens=1,2" %%a in ('set ^| findstr /i /r "^keycode*"') do (
		set %%a=
	)

	REM Populate keycode distribution as a dictionary
	for /f "tokens=%~2" %%a in (%~1) do (
		if not defined keycode[%%a] (
			set /a keycode[%%a] = 1
		) else (
			set /a keycode[%%a] = keycode[%%a] + 1
		)
	)

	REM Output the keycode distribution
	for /f "delims== tokens=1,2" %%a in ('set ^| findstr /i /r "^keycode*"') do (
		REM Replace "keycode[XY12345]" with "XY12345" (in 2 steps)
		set "lineString=%%a"

		REM Step 1
		set "substr_to_delete=keycode["
		for %%b in ("!substr_to_delete!") do set "new_str=!lineString:%%~b=!"

		REM Step 2
		set "substr_to_delete=]"
		for %%b in ("!substr_to_delete!") do set "new_str=!new_str:%%~b=!"
		
		echo !new_str!: %%b >> output.txt
	)

	goto :EOF
