# Weatherly
An OpenWeather API example app using Swift and UIKit

This app uses the [Open Weather API](https://openweathermap.org/)

It is a work in progress. See numbered branches for steps used to build the app. 

TODOs: 
1. [Strech Goal for students??] Store searched results in user defaults
1. [Stretch Goal for students??] Make Search Bar provide suggested locations as user types (expected behavior)
1. Inform user of invalid search query.
1. Fix search bar bug:
 - on most iphones, after dismissing the search bar on scroll up. The search bar does not re-appear on scroll down. It works properly on iPhone 13 Pro and iPhone 13 Pro Max
 - Weirdly, a similar function to the Navbar's `hidesBarsOnSwipe`, `hidesBarsOnTap`, functions properly on all iphones.
 - Configure day card lottie animation to the weather's 12pm status
1. ~~Validate location: fix app crash when mispelled or non-existent locatioin is entered in search bar.~~
1. ~~Format the Table view content further so it renders the correct time in local format (not UTC)~~
2. [used cards on main VC instead]~~Add a detail screen for extended forecast (currently table view has all 5 day, forecast objects every 3 hours)~~
3. ~~Calculate the real Daily High and Low (currently showing the temp_max and temp_min for a current location, not daily)~~
5. [table view was removed]~~Hide Table View until data is present (or load on startup)~~
8. ~~Maybe add Pexel images instead of Lotties for a prettier view~~
9 . ~~OR add more Lotties to the app that reflect more conditions. (update setLottie())~~
10. ~~Build a Networking class to handle all the Network requests - move out of APIManager~~
11. ~~Add more icons for max, min temps, humidity, wind, etc.~~

### Helpful Articles
- [Raywenderlich intro article on NUKE](https://www.raywenderlich.com/11070743-nuke-tutorial-for-ios-getting-started) 
- Horizontal Scroll View
    - 
    https://riptutorial.com/ios/example/12812/scrolling-content-with-auto-layout-enabled
    - https://iosexample.com/uiscrollview-vertical-horizontal-scrolling/

Potholes
- For an unexplainable reason, the view holding a lottie animation in the daily horizontal card stack displays
a small lottie using a 1 aspect ratio constraint. As a 'bandaid', I a slightly smaller aspect ratio of 0.99 is used.
- The week forecast's high and low temperatures for each day are inaccurate because of the 3hr intervals. They often miss the highest and lowest temperatures. This is a shortcoming of the data in the Weather API endpoint.  
- Edge case: 6 days of forecast are given when time has already passed on the current day, spreading the 40 guarenteed 3hr forecasts to a 6th day. When the 5day/3hr forecast does not provide a 6th day and only gives 5 days, the 6th day card will be displayed and unused. A workaround is to toggle `isHidden` to true on the 6th card using the storyboard's attribute inspector, and when iterating and configuring the cards in the VC, toggle `isHidden` to false.
- We are using @IBDesignable `RoundedCornerView` class which extends `UIView` to set rounded corners in storyboard rather than programatically. Sometimes, after setting the corner radius in the attributes inspector, the views' corner radius will not update visually on the storyboard. Toggle Editor->Refresh All Views.
