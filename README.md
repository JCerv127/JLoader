# JLoader
A Custom SQL-Loader Program

WHAT IS JLOADER
This JLoader program is created to reuse templates of Oracle's SQL Loader utility. 
A tree/directory structure is also enforced inorder to properly compile all files,
including all program files, input as well as the ouput.


GETTING STARTED
Initially, you just need to deploy the whole JLOADER directory in a UNIX-Linux Environment.
To run, execute the "jloader_start.com" file.


PREREQUISITES
1. Input file(s) to load. 
    - Accepted file formats/extensions are as follows:
        >>> .txt files
        >>> .lst files
    - The files need to be placed in the following directory/path:
        >>> ./INPUT

2. Custom SQL script for proccessing. 
    - Accepted file formats/extensions are as follows:
        >>> .sql files    
    - The files need to be placed in the following directory/path:
        >>> ./CUSTOM


RUNNING THE PROGRAM 
1. To run the Program, locate "jloader_start.com" in the root directory and execute it.
    - Sample simulated output after execution:
        >>> *********************************
            ************ JLOADER ************
            ** A CUSTOM SQL-LOADER PROGRAM **
            *********************************
            ***PROCESS MENU***
            [1] - START
            [0] - EXIT Program

            Enter Process Number:

2. Enter either 1 or 0 accordingly then press ENTER key.

3. Simulated output differs according to inputted process number.
    - If 0 then program automatically exits. 
        >>> Enter Process Number: 0
            EXITING PROGRAM...
    - Else if 1, then a list of files will be displayed. As shown in the following.
        >>> Enter Process Number: 1

            ***LIST OF FILES TO PROCESS***
            loader_input.txt
            test_input.lst

            Enter a file to process:

4. Choose one (1) file from the list, input it's filename then press ENTER. 
    - Simulated output is as follows:
        >>> Enter a file to process: loader_input.txt
            File exists!

            ***LIST OF CUSTOM SQL PROCESSES***
            loader_custom_process.sql

            Enter custom sql for processing:

5. Choose one (1) custom sql file from the list, input it's filename then press ENTER. 
    - Simulated output is as follows:
        >>> Enter custom sql for processing: loader_custom_process.sql
            File exists!

            ***LOADER COLUMN NUMBER***

            Enter number of columns to load:
