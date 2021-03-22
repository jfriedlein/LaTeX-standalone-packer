# LaTeX-standalone-packer
Scripts to pack all external file dependencies of a LaTeX file into a local folder

## When to use this
When you write a LaTeX document and load files from other directories all over your hard drive, it gets difficult to backup and exchange the LaTeX project with others. This repository proposes one option to handle this problem. The scripts extracts all external file dependencies from the LaTeX document and copies these files into a local folder.
In contrast to bundledoc, we only copy external files (.tex, .png, .pdf, .pdf_tex, ...) but not internal LaTeX packages etc.

## Setup
Currently, there is only a batch file, so it's available and tested only for the Windows-Miktech-TexStudio combination. I'll need a Linux version soon anyway, so this might join the batch file in the future.

# ToDo
Here we need an MWE and some pictures of the directories so it becomes clear what needs to be saved where

## How to
1. Download the "LaTeX-standalone-packer"
2. Save the folder somewhere on your drive
3. Copy the file "LaTeX-Packer_X_to_Y.bat" to your LaTeX working directory (where your LaTeX master file is located)
4. Edit the content of this batch file by entering
  a) the path from the current LaTeX working directory to the LaTeX-standalone-packer folder,
  b) the name of your master file without the ending .tex,
  c) the subdirectory that will be created or appended to store the local copies of the external files
6. Add the "headerLocal.tex" file to your LaTeX working directory
5. Open your LaTeX master file, create an input for the 'headerLocal.tex' file such as "\input{headerLocal}".
7. Now for the tricky part. Open this headerLocal.tex file and take a close look. Modify it to meet your needs as outlined above in Setup.
5. Execute your local batch script, e.g. by double-clicking it
6. Now a file with ending .dep should have been created in your LaTeX working directory, that contains lines like "..\..\..\..\GRAPHICS\Fundamentals\processWindows.pdf" (without the quotes!) and you should have the chosen subfolder with again subfolders containing in this case the PDF.

## Bugs, todos
- Only start looking for "../" to detect external files after the catch phrase "file list" to avoid unwanted behaviour.
- todo: Don't copy files that are listed multiple times, copy them only once
- If your filenames and paths get too long, they will be split into two lines in the log file. Because I don't see an easy way to detect that. Go to "C:\Program Files\MiKTeX 2.9\miktex\config\texmfapp.ini" (for Windows and MikTech, else: [https://tex.stackexchange.com/questions/52988/avoid-linebreaks-in-latex-console-log-output-or-increase-columns-in-terminal] or check LaTeX max_print_line) and increase the max_print_line e.g. to 150
- Check use of "JREPL.bat" instead of BatchSubstitute.bat
- The Batch files are dirty, really dirty. They just get the job done without any sense of efficiency or robustness.
- Check how this handles pdf_tex files, maybe use [https://tex.stackexchange.com/questions/337110/how-to-convert-inkscape-pdf-tex-to-pdf/337112] to convert them to pure pdf

# Acknowledgements
- The "BatchSubstitute.bat" stems form dostips.com. Very good place to find proper scripts. Thanks a lot!
