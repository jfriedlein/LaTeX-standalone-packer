@echo off
REM param %1 -> contains the name of the master file
REM The following is needed for something
SetLocal EnableDelayedExpansion
echo Copy all external dependencies of the given file 'masterName' to the folder 'dest'
echo.
echo. 
REM Define the output directory dest, where this string will directly be appended after the last character by the parent folder name
REM The tilde removes the surrounding ""
set masterLog="%~1.log"
set masterDep=%~1.dep
set dest=%2
echo masterLog %masterLog%
echo destination %dest%
echo.

REM Find all lines that start with "../" and write these into the new raw.dep file, because these indicate external files. The findstr function and the options can be found here: [https://www.windows-commandline.com/findstr-command-examples-regular/]. "/B" looks for the given string only at the beginning of each line and "/C" requires an exact match. The latter seems necessary else it might look for individual occurrences of dot and slash in the entire line.
REM We search for the .log-file and extract the data from "File list". This requires the command "\listfiles" to be called in the master tex file ideally right before \documentclass
echo Extracting all relevant external dependencies ...
findstr /B /C:"../" %masterLog% > raw.dep

REM Replace double file separators
CALL "%~dp0BatchSubstitute.bat" "//" "/" raw.dep>raw_single.dep

REM Remove quotation marks [https://www.computing.net/answers/windows-nt/removing-double-quotes-from-a-text-file/23332.html]
for /F "delims=" %%A in ('type "raw_single.dep"') do (
  set row=%%A
  set row=!row:"=!
  echo.!row!>> "raw_clean.dep"
)

REM Replace the file separators
REM todo Check whether we need to do this on Linux
REM Remove the current.dep file in case it already exists so we don't undermine the below check for existence
echo Replacing file separators ...
CALL "%~dp0BatchSubstitute.bat" "/" "\" raw_clean.dep>%masterDep%

REM Wait until the .dep-file actually exists
echo Waiting for the %masterDep% file to be created
:waitloop

IF EXIST %masterDep% GOTO waitloopend
timeout /t 1
goto waitloop
:waitloopend
echo ... file separators successfully replaced
echo.
REM Delete the raw file, because we only need current.dep
del "raw.dep"
del "raw_single.dep"
del "raw_clean.dep"

echo Note: Access Denied errors refer to the previous line
echo.
echo Copying files ...
REM Copy the files from the dep file to dest
for /F "tokens=*" %%A in (%masterDep%) do (
echo "%%A":
REM destination: Remove all the leading "..\" from the paths, add "dest" to the front of the line and use this as the destination
set str=%%A
set str=!str:..\=!
REM the trailing >nul removes all the standard output and only leaves the errors
xcopy "%%A" "%dest%!str!"* /Y >nul
)
echo ... copied files.
echo.
echo ... finished.