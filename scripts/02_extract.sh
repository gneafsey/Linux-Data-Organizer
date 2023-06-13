#!/bin/bash

if (($# < 1)); then
	echo "Usage: $0 file" ; exit 1
fi

if [[ ! -f "$1" ]]; then
	echo "Parameter must be a normal file (\$1)($1)"; exit 1
fi

import_file="$1"
file_ext="${import_file##*.}"

echo $import_file
echo $file_ext

if [[ "$file_ext" = "bz2" ]] ; then
	bunzip2 $import_file
	echo "The file extension is bz2"
elif [[ "$file_ext" = "gz" ]] ; then
	gunzip $import_file
	echo "The file extension is gz"
fi

exit 0
