# Gabrielle Neafsey Wroten
# 08/05/2021
# Final Semester Project
#!/usr/bin/gawk -f

BEGIN {
	FS = ","
	OFS = ","
}

{
	if ($12 != "" && $12 !~ /NA/ && $12 !~ /na/)
	{
		print
	}
	else
	{
		print > "exceptions.csv"
	}
}
