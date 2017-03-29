set xdata time
set timefmt '%Y-%m-%d'
set format x '%Y-%m-%d'
set xrange ["2017-01-01":"2018-01-01"]
#set xtics rotate by -7
set xtics ("Jan" "2017-01-01", "Feb" "2017-02-01", "Mar" "2017-03-01", "Apr" "2017-04-01", "May" "2017-05-01", "June" "2017-06-01", "July" "2017-07-01", "Aug" "2017-08-01", "Sept" "2017-09-01", "Oct" "2017-10-01", "Nov" "2017-11-01", "Dec" "2017-12-011")
set yrange [0:101000] #101%
set y2range [0:20200] #101%
set ytics ("25000mi\n25seg" 25000, "35000mi\n35seg" 35000, "50000mi\n50seg" 50000, "75000mi\n75seg" 75000, "95seg" 95000, "100000mi" 100000)
set ylabel "Required Miles / Segments"
set y2tics ("$3000" 3000, "$4000" 4000, "$6000" 6000, "$9000" 9000, "$20000" 20000)
set y2label "Required Dollars"
#set y2label textcolor rgbcolor "purple"
set key center top title " "
set terminal canvas size 1600,900 enhanced font 'Verdana,10' 
set output 'output.html'
set datafile separator ","
set arrow from "2017-01-01",0 to "2017-12-31",50000 nohead lt -1 lw 0.2 lc rgb "red" #mi/seg
set arrow from "2017-01-01",0 to "2017-12-31",75000 nohead lt -1 lw 0.2 lc rgb "red" #mi/seg 
set arrow from "2017-01-01",0 to "2017-12-31",100000 nohead lt -1 lw 1.2 lc rgb "green" #mi
set arrow from "2017-01-01",0 to "2017-12-31",95000 nohead lt -1 lw 0.2 lc rgb "blue" #seg
set arrow from "2017-01-01",second 0 to "2017-12-31",second 20000 nohead lt -1 lw 0.5 lc rgb "green" #$$


plot 'all.csv' using 1:4 smooth cumulative title "AQM Totals" lw 2 lc rgb "red" with steps, \
     'aqs.csv' using 1:(column(0))*1000 title "Segments" lw 2 lc rgb "blue" with steps, \
     'all.csv' using 1:4 title "Miles" lc rgb "red", \
     'all.csv' using 1:5 title "AQD" axes x1y2 lc rgb "green" ,\
     'all.csv' using 1:5 smooth cumulative title "AQD Totals" axes x1y2 lw 2 lc rgb "green" with steps , \
     25000 title "Miles Req 25k" linetype 0, \
     35000 title "Miles Req 35k" linetype 0, \
     50000 title "Miles Req 50k" linetype 0, \
     75000 title "Miles Req 75k" linetype 0, \
     100000 title "Miles Req 100k" linetype 0, \
     3000 title "AQD Req 25k" linetype 9 axes x1y2, \
     4000 title "AQD Req 35k" linetype 9 axes x1y2, \
     6000 title "AQD Req 50k" linetype 9 axes x1y2, \
     9000 title "AQD Req 75k" linetype 9 axes x1y2, \
     20000 title "AQD Req 100k" linetype 9 axes x1y2 
