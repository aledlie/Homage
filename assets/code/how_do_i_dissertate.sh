#!/bin/bash

# Go to the most recent revision.
hg up -C

# Get the most recent revision #.
MAXREV="$(hg id -n)"

# Loop over REVisions.
for (( REV=0; REV<=$MAXREV; REV++ ))
do
   echo "$REV of $MAXREV"
   hg up -r $REV
   cat *.tex > cat.tex
   wc -w cat.tex >> word_length.txt
   rm cat.tex
done

