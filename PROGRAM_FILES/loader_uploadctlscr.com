##*===========================================================================*
## Source Name  :       loader_uploadctlscr.com
## Author       :       JAGCERVANTES
## Date         :       04-SEP-2018
## Description  :       Custom script to create ctl text commands for tmptbl
##*===========================================================================*

INPUTFILENAME="$1"
COLNUM="$2"

echo "Input Filename: "$INPUTFILENAME
echo "Column Number: "$COLNUM
cd PROGRAM_FILES

if [ -f loader_upload.ctl ]
then
    rm loader_upload.ctl
fi
echo "LOAD DATA" > loader_upload.ctl
echo "INFILE 'PROGRAM_FILES/$INPUTFILENAME'" >> loader_upload.ctl
echo "INTO TABLE C_JSYNTBL" >> loader_upload.ctl
echo "FIELDS TERMINATED BY '|'" >> loader_upload.ctl
echo "TRAILING NULLCOLS" >> loader_upload.ctl
echo "(" >> loader_upload.ctl

i=1
while [[ $i -le $COLNUM ]]
do
    if [[ $i -eq $COLNUM ]]; then
        echo "jvar"$i >> loader_upload.ctl
    else
        echo "jvar"$i"," >> loader_upload.ctl
    fi
    (( i = i + 1 ))
done

echo ")" >> loader_upload.ctl
cd -

