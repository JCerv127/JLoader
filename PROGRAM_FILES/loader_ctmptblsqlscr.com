##*===========================================================================*
## Source Name  :       loader_ctmptblsqlscr.com
## Author       :       JAGCERVANTES
## Date         :       04-SEP-2018
## Description  :       Custom script to create sql text commands for tmptbl
##*===========================================================================*

COLNUM="$1"

echo "Column Number: "$COLNUM
cd PROGRAM_FILES
if [ -f loader_ctmptbl.sql ]
then
    rm loader_ctmptbl.sql
fi
#echo "drop public synonym C_JSYNTBL;" > loader_ctmptbl.sql
#echo "drop table C_JTBLLOADER;" >> loader_ctmptbl.sql
echo "create table C_JTBLLOADER" > loader_ctmptbl.sql
echo "(" >> loader_ctmptbl.sql

i=1
while [[ $i -le $COLNUM ]]
do
    if [[ $i -eq $COLNUM ]]; then
        echo "jvar"$i" varchar2(255)" >> loader_ctmptbl.sql
    else
        echo "jvar"$i" varchar2(255)," >> loader_ctmptbl.sql
    fi
    (( i = i + 1 ))
done

echo ")" >> loader_ctmptbl.sql
echo "TABLESPACE CUST_UBP_TBLS" >> loader_ctmptbl.sql
echo "/" >> loader_ctmptbl.sql
echo "create public synonym C_JSYNTBL" >> loader_ctmptbl.sql
echo "for C_JTBLLOADER" >> loader_ctmptbl.sql
echo "/" >> loader_ctmptbl.sql
echo "commit;" >> loader_ctmptbl.sql
echo "exit" >> loader_ctmptbl.sql
cd -

