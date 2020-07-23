#!/bin/bash

mkdir extracted
find . -type f -print0 | while read -r -d $'\0' file; 
do
	echo $(basename $file)
	if [[ $(basename $file) == ._* ]]; then
		echo "skipping $file"
	else
		cp $file ./extracted/ 
	fi
done

