#!/bin/bash

if (($# < 1)); then
	echo "Usage: $0 file"; exit 1
fi

if [[ ! -f "$1" ]]; then
	echo "Parameter must be a normal file (\$1)($1)"; exit 1
fi

# Transfer the file
cp $1 .

exit 0
