#!/bin/bash

logicFileLocation=$(awk -F "=" '/LogicProgram_directory/ {print $2}' config.ini)

echo "Text2ALM..."
echo $2
mkdir $logicFileLocation/$2
python3 CommandCenter.py text2alm --input $1
echo "${1##*/}"
fbname=$(basename "$1" .txt)
echo "$fbname"
echo "Sparc..."
rm $logicFileLocation/$2/$fbname$".tp.lp"
java -jar sparc.jar Output/Text2ALM_Outputs/$fbname/CALM/$fbname$".tp.sparc" -A --disable-empty-sort-check -o $logicFileLocation/$2/$fbname$".tp.lp" >& MessagesFromSPARC

