#!/bin/bash

if (($# < 1)); then
	echo "Usage: $0 file" ; exit 1
fi

if [[ ! -f "$1" ]]; then
	echo "Parameter must be a normal file (\$1)($1)"
fi

tr '[:upper:]' '[:lower:]' < "$1"

exit 0
