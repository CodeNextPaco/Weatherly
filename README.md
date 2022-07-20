# Weatherly

## Description

An iOS app written in Swift that displays real-time weather from the [Open Weather API](https://openweathermap.org/) of a city inputted by a user. This is a single page application that scrolls vertically, containing 3 major UI segments: current weather, 5-day forecast, and current weather specific metrics.

## Prerequisites

- [Nuke](https://github.com/kean/Nuke) (Image Loading System)
- [Lottie](https://github.com/airbnb/lottie-ios) (Animation Renderer)

The prerequisite(s) are installed using Swift Package Manager instead of Cocoapods. Upon the first build, SPM should download the dependencies automatically.

## Installation

- Clone/Download the app to your Mac
- Check that you have the latest build of [XCode](https://developer.apple.com/support/xcode/) installed.

## Notes for Technical Writers

### Strech goals for students

- Store searched results in user defaults
- Search Bar provides suggested locations as user types

### CallOuts

- We are using @IBDesignable `RoundedCornerView` class which extends `UIView` to set rounded corners in storyboard rather than programatically. Sometimes, after setting the corner radius in the attributes inspector, the views' corner radius will not update visually on the storyboard. Toggle Editor->Refresh All Views.

### Resources

- [Raywenderlich intro article on NUKE](https://www.raywenderlich.com/11070743-nuke-tutorial-for-ios-getting-started)
- Horizontal Scroll View
  - <https://riptutorial.com/ios/example/12812/scrolling-content-with-auto-layout-enabled>
  - <https://iosexample.com/uiscrollview-vertical-horizontal-scrolling/>

## Contributing

- Use the Issue Tracker: <https://github.com/derekc00/Tunely/issues>

## License

- MIT LICENSE

## Contact

- Derek Chang (contract dev - July 2022, former iOS Guru): derekchangc00@gmail.com
- Paco (contract dev - 2022)


