#!/bin/bash
. config.txt

fbname=$(basename "$1" .txt)
echo "$fbname"

echo "Xclingo..."

python xclingo/xclingo.py $logicFileLocation/$fbname$".tp.lp" $2 > $xclingoLocation/$fbname$".tp.xlp" 
