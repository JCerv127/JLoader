### JLOADER - A Custom SQL-Loader Program


##### WHAT IS JLOADER
This **JLoader** program is created to reuse templates of Oracle's SQL Loader utility. A tree/directory structure is also enforced in order to properly compile all files, including all program files, input as well as the ouput.


##### GETTING STARTED
Initially, you just need to deploy the whole **JLOADER** directory in a _UNIX-Linux_ Environment. To run, execute the **jloader_start.com** file.


##### PREREQUISITES
1. Input file(s) to load. 
    - Accepted file formats/extensions are as follows:
        - .txt files
        - .lst files
    - The files need to be placed in the following directory/path:
        > ./INPUT

2. Custom SQL script for processing. 
    - Accepted file formats/extensions are as follows:
        > .sql files    
    - The files need to be placed in the following directory/path:
        > ./CUSTOM


##### RUNNING THE PROGRAM 
1. To run the program, locate **jloader_start.com** in the root directory and execute it.
    - Sample simulated output after execution:
        ```
            *********************************
            ************ JLOADER ************
            ** A CUSTOM SQL-LOADER PROGRAM **
            *********************************
            ***PROCESS MENU***
            [1] - START
            [0] - EXIT Program

            Enter Process Number:
        ```

2. Enter either _1_ or _0_ accordingly then press **ENTER** key.

3. Simulated output differs according to inputted process number.
    - If _0_ then program automatically exits. 
        ```   
            Enter Process Number: 0
            EXITING PROGRAM...
        ```
    - Else if _1_, then a list of files will be displayed. As shown in the following.
        ``` 
            Enter Process Number: 1

            ***LIST OF FILES TO PROCESS***
            loader_input.txt
            test_input.lst

            Enter a file to process:
        ```

4. Choose one _(1)_ file from the list, input it's filename then press **ENTER**. 
    - Simulated output is as follows:
        ``` 
            Enter a file to process: loader_input.txt
            File exists!

            ***LIST OF CUSTOM SQL PROCESSES***
            loader_custom_process.sql

            Enter custom sql for processing:
        ```

5. Choose one _(1)_ custom sql file from the list, input it's filename then press **ENTER**. 
    - Simulated output is as follows:
        ``` 
            Enter custom sql for processing: loader_custom_process.sql
            File exists!

            ***LOADER COLUMN NUMBER***

            Enter number of columns to load:
        ```

6. Next, we will need to input the number of fields/columns according to the input file entered previously. Loader will read the file and will use the **|** character as delimiter.
    - Simulated output is as follows:
        ``` 
            Enter number of columns to load: 1
            Numeric!

            ***INPUT OVERVIEW***
            Input Filename: loader_input.txt
            SQL Filename: loader_custom_process.sql
            Number of Cols: 1
        ```

7. Processing of the file will ensue, which will make use of the input file and extract data according to the custom sql entered. This program uses a general temp table for the loader.
    - Simulated output is as follows:
        ``` 
            START EXEC TIME: Tue Sep 18 11:10:40 2018

            Input File: loader_input.txt
            SQL File: loader_custom_process.sql
            COLNUM: 1

            STARTED MOVING INPUT FILE FOR PROCESSING

            STARTED CREATING SQL SCRIPT TO CREATE TEMP TABLE
            Column Number: 1
            /users/jagcervantes/RSS-00000/2018/023/JLOADER

            STARTED CREATING NEW TEMP TABLE

            ...


            Table created.


            Synonym created.


            Commit complete.

            ...

            STARTED CREATING CTL SCRIPT TO LOAD RECORDS
            Input Filename: loader_input.txt
            Column Number: 1
            /users/jagcervantes/RSS-00000/2018/023/JLOADER

            STARTED UPLOADING INPUT IN TEMP TABLE

            ...

            Commit point reached - logical record count 64
            Commit point reached - logical record count 128
            Commit point reached - logical record count 192
            Commit point reached - logical record count n

            STARTED MOVING INPUT FILE TO PROCESSED DIR

            STARTED EXTRACTING AND NECESSARY FIELD OUTPUT(S) USING CUSTOM SQL

            ...

            STARTED DELETING TABLE RECORD(S)

            ...


            Synonym dropped.


            Table dropped.


            Commit complete.

            ...

            STARTED REMOVING UNNECESSARY FILES AND MOVING OF LOGS AND OUTPUT TO SPECIFIC FOLDERS

            FIN

            Process another? (Input [X]/[x] to EXIT; Else, proceed with another processing):
        ```

8. Once processing is successful, the following files will be on specific directories: 
    - Output of the extraction
        > ./OUTPUT
    - Logs
        > ./LOGS
    - Input files that have been processed 
        > ./PROCESSED

9. A *Process another?* message will prompt. Simulated output differs according to input.
    - If _[X]_ / _[x]_ then program automatically exits. 
        ```   
            Process another? (Input [X]/[x] to EXIT; Else, proceed with another processing): x
            EXITING PROGRAM...
        ```
    - Else, the program will proceed again to the welcome screen.
        ``` 
            Process another? (Input [X]/[x] to EXIT; Else, proceed with another processing):

            *********************************
            ************ JLOADER ************
            ** A CUSTOM SQL-LOADER PROGRAM **
            *********************************
            ***PROCESS MENU***
            [1] - START
            [0] - EXIT Program

            Enter Process Number:
        ```


##### VERSIONING
1. Initial DEV


##### AUTHOR
- **JAGCERVANTES** _Associate Programmer_


##### ACKNOWLEDGMENTS
- For Team BK! We are hardworking people and we don't apply for work leaves. But if we are to, it will be **FOREVER LEAVE**!


#### **_FIN_**
