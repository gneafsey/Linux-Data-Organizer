# Gabrielle Neafsey Wroten
# 08/05/2021
# Final Semester Project
#!/usr/bin/gawk -f

BEGIN {
	FS=","
	OFS=","
}

{
	if ($5 ~ /1/ || $5 ~ /female/ || $5 ~ /f/)
	{
		$5 = "f"
		print
	}
	else if ($5 ~ /0/ || $5 ~ /male/ || $5 ~ /m/)
	{
		$5 = "m"
		print
	}
	else
	{
		$5 = "u"
		print
	}
}

