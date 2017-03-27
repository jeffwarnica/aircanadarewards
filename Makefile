all: output.html

aqs.csv: makeaqs.pl recentActivities.csv
	./makeaqs.pl < recentActivities.csv > aqs.csv

output.html: runme.gnuplot recentActivities.csv aqs.csv
	gnuplot runme.gnuplot

