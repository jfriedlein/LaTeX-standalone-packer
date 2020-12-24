@echo off
REM This batch-file calls the copy_listfiles.bat script to store all external dependencies of the given file "name_of_masterFile" and store them into "subfolder_for_extFiles".
REM Arguments:
REM "name_of_masterFile" This is the file which with ending ".tex" contains as first line the command "\listfiles" and thus has all the dependencies in its log-file named "name_of_masterFile".log; You cannot use blanks in this variable (sorry, never got this to work with blanks)
REM "subfolder_for_extFiles" This is where the external dependencies shall be stored. You can use a subfolder of the current directory by a leading ".\". Furthermore, the Prefix for all the subfolders can be set by simply leaving the end open, so ".\files-" will prefix the name of all external resources.
REM "path_to_LaTeX_Packer" This is the path from the current directory to the LaTeX Standalone Packer, so where the "copy_listfiles.bat" and the "BatchSubstitute.bat" are stored with trailing file separator

REM USER Input
set "path_to_LaTeX_Packer=.\"
set name_of_masterFile="X"
set subfolder_for_extFiles=".\Y\"

echo Executing copy_listfiles.bat
CALL "%path_to_LaTeX_Packer%LaTeX-standalone-packer\copy_listfiles.bat" %name_of_masterFile% %subfolder_for_extFiles%
pause