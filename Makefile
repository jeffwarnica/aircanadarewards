all: output.html

all.csv: preProcessor.pl recentActivities.csv
	./preProcessor.pl < recentActivities.csv
aqs.csv: preProcessor.pl recentActivities.csv
	./preProcessor.pl < recentActivities.csv

output.html: runme.gnuplot aqs.csv all.csv 
	gnuplot runme.gnuplot

