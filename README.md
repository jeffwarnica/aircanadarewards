# aircanadarewards
Draws useful graphs of Air Canada Altitude rewards data

Requirements
* make
* perl
* gnuplot

Instructions
* Get recentActivities.csv from your Altitude dashboard: https://altitude.aircanada.com/mystatus/dashboard
* $ make
* open output.html in a browser

Note: Altitude does not note in any direct way what line items are Altitude Qualifying Segments or Miles. If Dollars in their CSV is occupied, it is unquestionably (sample size: 1 users history) qualifying dollars, segments, and miles. Thus, we ignore all entries without AQD values filled in. Personally my history has the 

As the AQD field takes a few days 
