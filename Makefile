output.html: runme.gnuplot recentActivities.csv
	gnuplot runme.gnuplot

all: output.html
