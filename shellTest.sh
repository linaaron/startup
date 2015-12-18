#! /bin/bash

BASEDIR=$( cd "$(dirname $0)" && pwd)/../../
echo "=================================="
echo $BASEDIR

for a in 1 2 3 4 
do
    echo "$a"
done

for file in $(ls script/)
do 
    echo $file
done

aString="abcdefg"
echo ${#aString}
echo ${aString:2:2}
echo `expr index ${aString} de`

array=(1 2 3 4 5 6)
echo ${array[0]}
echo ${array[@]}

read name
echo -e "OK!\n"
echo -e "the \c"
echo "name: $name"
echo "$name" -> test.txt


