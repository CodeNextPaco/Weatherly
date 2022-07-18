//
//  WeatherForecast.swift
//  Weatherly
//
//  Created by Derek Chang on 7/5/22.
//

import Foundation

struct WeatherForecast: Decodable {
    var list: [HourForecast]
    
    init() {
        list = []
    }
    
    func dailyHighLowForecast() -> [(Constants.days, (Int, Int))] {
        if list.isEmpty {
            print("No data to get daily temp forecast")
            return []
        }
        var forecastDict = [Constants.days: [Double]]()
        for currentWeather in list {
            forecastDict[Constants.dayOfWeek(from: currentWeather.dt), default: [Double]()].append(currentWeather.main.temp)
        }
        let forecastArray = forecastDict.map { dailyTemps in
            return ( dailyTemps.key,
                ( Int(dailyTemps.value.max() ?? 0),
                  Int(dailyTemps.value.min() ?? 0)
                )
            )
        }
        let sortedForecastArray = forecastArray.sorted { $0.0 < $1.0 }
        let indexOfCurrentDay = sortedForecastArray.firstIndex { $0.0 ==  Constants.currentWeekday} ?? 0
        let lhs = Array(sortedForecastArray[0..<indexOfCurrentDay])
        let rhs = Array(sortedForecastArray[indexOfCurrentDay...])
        return rhs + lhs
    }
}
struct HourForecast: Decodable {
    var main: Main
    var weather: [Weather]
    var dt: Double
    var pop: Double
    var wind: Wind
}
