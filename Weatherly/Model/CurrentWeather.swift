//
//  Weather.swift
//  Weatherly
//
//  Created by admin on 6/20/22.
//

import Foundation

struct CurrentWeather {
    var main: WeatherMain
    var weather: [WeatherDetail]
    var name: String?
    var pop: Double?
    var dt: Double
    
    func formattedDate() -> String {
        return Constants.DateFormatters.simpleDateFormatter
                .string(from: Date(timeIntervalSince1970: dt))
    }
    func dayOfWeek() -> Constants.days {
        let date = Date(timeIntervalSince1970: dt)
        let calendar = Calendar(identifier: .gregorian)
        /// Calendar API weekday: 1 = Sun, 7 = Sat
        let dayIndex = calendar.component(.weekday, from: date)
        return Constants.days.allCases[dayIndex - 1]
    }
}

extension CurrentWeather: Decodable {
    
    init() {
        name = ""
        dt = 0.0
        main = WeatherMain(temp: 0.0, temp_min: 0.0, temp_max: 0.0, humidity:0.0, feels_like: 0.0)
        weather = []
    }
    struct WeatherMain: Decodable {
        var temp: Double
        var temp_min: Double
        var temp_max: Double
        var humidity: Double
        var feels_like: Double
    }
    
    struct WeatherDetail: Decodable {
        var main: String
        var description: String
        var icon: String
    }
}

