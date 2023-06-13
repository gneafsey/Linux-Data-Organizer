#!/usr/bin/gawk -f

BEGIN {
	FS = ","
	OFS = ","
	i=0
}

{
	customerID=$1
	state=$12
	zip=$13
	lname=$3
	fname=$2
	amt=$6

	arr_ID[i]=customerID
	arr_state[i]=state
	arr_zip[i]=zip
	arr_lname[i]=lname
	arr_fname[i]=fname
	arr_amt[i]=amt

	if (i>=1) {
		if (arr_ID[i] ~ arr_ID[i-1]) {
			arr_amt[i]+=arr_amt[i-1]
		}
	}
	i++
}

END {
	k=0
	# printf "i = %s\n", i > "sum.txt"
	for (j=0; j<i-1; j++) {
		if (arr_ID[j] != arr_ID[j+1]) {
			new_ID[k] = arr_ID[j]
			new_state[k] = arr_state[j]
			new_zip[k] = arr_zip[j]
			new_lname[k] = arr_lname[j]
			new_fname[k] = arr_fname[j]
			new_amt[k++] = arr_amt[j]
		}
	}
	lastnum=i-1
	# printf "lastnum = %s\n", lastnum
	new_ID[k] = arr_ID[lastnum]
	new_state[k] = arr_state[lastnum]
	new_zip[k] = arr_zip[lastnum]
	new_lname[k] = arr_lname[lastnum]
	new_fname[k] = arr_fname[lastnum]
	new_amt[k++] = arr_amt[lastnum]
	
	new_arrnum=k
	# printf "New array num = %s\n", new_arrnum > "sum.txt"

	for (m=0; m<new_arrnum; m++) {
		printf "%s,%s,%d,%s,%s,%.2f\n", new_ID[m],new_state[m],new_zip[m],new_lname[m],new_fname[m],new_amt[m]
	}
}




	
