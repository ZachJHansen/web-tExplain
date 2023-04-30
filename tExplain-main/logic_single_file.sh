#!/bin/bash
. config.txt

echo "Text2ALM..."
python3 CommandCenter.py text2alm --input $1
echo "${1##*/}"
fbname=$(basename "$1" .txt)
echo "$fbname"
echo "Sparc..."
rm $logicFileLocation/$fbname$".tp.lp"
java -jar sparc.jar Output/Text2ALM_Outputs/$fbname/CALM/$fbname$".tp.sparc" -A --disable-empty-sort-check -o $logicFileLocation/$fbname$".tp.lp" >& MessagesFromSPARC

