# Weatherly
An OpenWeather API example app using Swift and UIKit

This app uses the [Open Weather API](https://openweathermap.org/)

It is a work in progress. See numbered branches for steps used to build the app. 

TODOs: 
1. ~~Format the Table view content further so it renders the correct time in local format (not UTC)~~
2. Add a detail screen for extended forecast (currently table view has all 5 day, forecast objects every 3 hours)
3. Calculate the real Daily High and Low (currently showing the temp_max and temp_min for a current location, not daily)
4. Validate location: fix app crash when mispelled or non-existent locatioin is entered in search bar.
5. Hide Table View until data is present (or load on startup)
6. Store searched results in user defaults
7. Make Search Bar provide suggested locations as user types (expected behavior)
8. Maybe add Pexel images instead of Lotties for a prettier view
9 . OR add more Lotties to the app that reflect more conditions. (update setLottie())
10. Build a Networking class to handle all the Network requests - move out of APIManager
11. Add more icons for max, min temps, humidity, wind, etc.

