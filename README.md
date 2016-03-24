# ios-simulator-scenarios-to-gpx
iOS simulator routes converted to GPX (converter included)

# Why?
If you're an iOS developer and you've to work with CoreLocation than you should know that iOS simulator allows you to set the GPX-based location to be used by your app. You can read more here - [Testing and Debugging in Simulator](https://developer.apple.com/library/ios/documentation/IDEs/Conceptual/iOS_Simulator_Guide/TestingontheiOSSimulator/TestingontheiOSSimulator.html).

Debugging tools allow you to choose different scenarios (with routing):
- **City Bicycle Ride**. Simulates a bike ride in Cupertino, CA. This item simulates the device moving on a predefined route.
- **City Run**. Simulates a run in Cupertino, CA. This item simulates the device moving on a predefined route.
- **Freeway Drive**. Simulates a drive through Cupertino, CA. This item simulates the device moving on a predefined route.

And one day there was a need to repsenent the scenarios in a different format (I choose GPX). That's why this repository exist.

What do we have? 
- generated GPX files in `gpx` folder (just pure GPX only with waypoints);
- Objective C implementation file (very simple).

# GPX
Feel free to fork this repo if you want to generate more complex GPX files or change something. You can find additional documentation about GPX here - [GPX 1.1 Schema Documentation](http://www.topografix.com/gpx/1/1/).

# Look & Feel
I used [GPS Visualizer](http://www.gpsvisualizer.com) to take screenshots.

![City Bicycle Ride](https://github.com/dive/ios-simulator-scenarios-to-gpx/blob/master/images/City%20Bicycle%20Ride.png "City Bicycle Ride")
![City Run](https://github.com/dive/ios-simulator-scenarios-to-gpx/blob/master/images/City%20Run.png "City Run")
![Freeway Drive](https://github.com/dive/ios-simulator-scenarios-to-gpx/blob/master/images/Freeway%20Drive.png "Freeway Drive")
