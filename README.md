# Weather (WIP)

Command Line Application that fetches weather station data from NOAA and `weather.gov`

## Installation

Clone this repo and `cd` into it
`$ git clone git@github.com:msimonborg/weather.git && cd weather/`

Run the CLI executable listing the weather observation station code as an argument
`$ ./weather KBOS`

Output should look something like this:
```
Location: Boston, Logan International Airport, MA (KBOS) 42.36056, -71.01056

Last Updated on Feb 17 2019, 8:54 am EST

Weather: Fair
Temperature: 27.0 F (-2.8 C)
Dewpoint: 7.0 F (-13.9 C)
Relative Humidity: 43 %
Wind: Northwest at 11.5 MPH (10 KT)
Wind Chill: 17 F (-8 C)
Visibility: 10.00 miles
MSL Pressure: 1020.5 mb
Altimeter: 30.14 in Hg
```

A directory of station codes can be found at https://www.weather.gov/arh/stationlist

