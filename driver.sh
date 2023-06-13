#!/bin/bash

# Check for correct number of arguments
if (($# != 3)); then
	echo "Usage: $0 rserver ruserid rfile" ; exit 1
fi

if [[ ! -f "$3" ]]; then
	echo "Third parameter must be a normal file (\$1)($1)"; exit 1
fi

# Declare variables
remote_server="$1"
remote_userid="$2"
remote_file="$3"
src_file="$(basename $remote_file)"

function rm_temps() {
	read -p "Delete Temporary Files? (Y/N): "
	if [[ $REPLY = [Yy] ]]; then
		rm *.tmp
		echo "Temporary Files Deleted"
	fi
}

# 1) Import file
./scripts/01_transfer.sh $remote_file
printf "1) Importing testfile: $src_file -- complete\n"

# 2) Unzip file
./scripts/02_extract.sh $src_file
main_file="${src_file%.*}"
printf "2) Unzip file $main_file -- complete\n"

# 3) Remove header from file
./scripts/03_rmheader.sh $main_file > "01_rm_header.tmp" # Results will output to 01_rm_header.tmp
printf "3) Removed header from file -- complete\n"

# 4) Convert all text to lower case
./scripts/04_tolower.sh 01_rm_header.tmp > "02_conv_lower.tmp" # Results will output to 02_conv_lower.tmp
printf "4) Converted all text to lowercase -- complete\n"

# 5) Convert gender values to f, m, or u
gawk -f "scripts/05_gender.awk" "02_conv_lower.tmp" > "03_conv_gen_gawk.tmp"
printf "5) Converted gender column to f/m/u standard -- complete\n"

# 6) Filter out records that do not have a valid state
gawk -f "scripts/06_filtstates.awk" "03_conv_gen_gawk.tmp" > "04_recordsfiltered_gawk.tmp"
printf "6) Filtered records without valid state into exceptions.csv -- complete\n"

# 7) Remove dollar sign from records
./scripts/07_rmdollar.sh < "04_recordsfiltered_gawk.tmp" > "05_dollarsremoved.tmp"
printf "7) Dollar signs removed -- complete\n"

# 8) Sort records by customerID
./scripts/08_sortid.sh < "05_dollarsremoved.tmp" > "transaction.csv"
printf "8) Records sorted by ID -- complete\n"

# 9) Accumulate total purchase amount for each custID, remove duplicate IDs, and print summary record
gawk -f "scripts/09_totpurchase.awk" < "transaction.csv" > "06_sum.tmp"
printf "9) Purchase amounts accumulated and duplicates removed -- complete\n"

# 10) Sort and print summary file based on state, zipcode descending, last name, and first name
./scripts/10_sortsum.sh < "06_sum.tmp" > "summary.csv"
printf "10) Summary file sorted and printed -- complete\n"

# 11) Remove all temp files
rm_temps

exit 0
