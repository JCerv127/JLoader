##*===========================================================================*
## Source Name  :       loader_execute.com
## Author       :       JAGCERVANTES
## Date         :       04-SEP-2018
## Description  :       CustomLoader
##*===========================================================================* 

DATEDISP=`date +%Y%m%d`
SQLID="custom$HOST_CONNECT_STR/custom"
INPUTFILENAME="$1"
SQLFILENAME="$2"
COLNUM="$3"

echo "\nInput File: "$INPUTFILENAME
echo "SQL File: "$SQLFILENAME
echo "COLNUM: "$COLNUM

#echo $SHELL
#echo $PWD

echo  "\nSTARTED MOVING INPUT FILE FOR PROCESSING"
mv INPUT/$INPUTFILENAME PROGRAM_FILES/$INPUTFILENAME

echo  "\nSTARTED CREATING SQL SCRIPT TO CREATE TEMP TABLE"
PROGRAM_FILES/loader_ctmptblsqlscr.com $COLNUM

echo  "\nSTARTED CREATING NEW TEMP TABLE"
sqlplus $SQLID @PROGRAM_FILES/loader_ctmptbl.sql

echo  "\nSTARTED CREATING CTL SCRIPT TO LOAD RECORDS"
PROGRAM_FILES/loader_uploadctlscr.com $INPUTFILENAME $COLNUM

echo  "\nSTARTED UPLOADING INPUT IN TEMP TABLE"
$ORACLE_HOME/bin/sqlldr $SQLID PROGRAM_FILES/loader_upload.ctl

echo  "\nSTARTED MOVING INPUT FILE TO PROCESSED DIR"
mv PROGRAM_FILES/$INPUTFILENAME PROCESSED/$INPUTFILENAME.done

echo  "\nSTARTED EXTRACTING AND NECESSARY FIELD OUTPUT(S) USING CUSTOM SQL"
sqlplus $SQLID @CUSTOM/$SQLFILENAME

echo  "\nSTARTED DELETING TABLE RECORD(S)"
sqlplus $SQLID @PROGRAM_FILES/loader_dtmptbl.sql

echo  "\nSTARTED REMOVING UNNECESSARY FILES AND MOVING OF LOGS AND OUTPUT TO SPECIFIC FOLDERS"
if [ -f *.txt ]
then
    mv *.txt OUTPUT
fi
if [ -f *.lst ]
then
    mv *.lst OUTPUT
fi
if [ -f *.log ]
then
    mv *.log LOGS
fi
if [ -f *.bad ]
then
    mv *.bad LOGS
fi
if [ -f *.dsc ]
then
    mv *.dsc LOGS
fi
if [ -f PROGRAM_FILES/loader_ctmptbl.sql ]
then
    rm PROGRAM_FILES/loader_ctmptbl.sql
fi
if [ -f PROGRAM_FILES/loader_upload.ctl ]
then
    rm PROGRAM_FILES/loader_upload.ctl
fi

echo  "\nFIN"

