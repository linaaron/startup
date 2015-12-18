#!/bin/bash
while read LINE2
do
	echo $LINE2
done    < test.txt

cat test.txt | while read LIN
do
   echo $LIN
done
