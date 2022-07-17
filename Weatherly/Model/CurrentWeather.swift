//
//  Weather.swift
//  Weatherly
//
//  Created by admin on 6/20/22.
//

import Foundation

struct CurrentWeather {
    var main: Main
    var weather: [Weather]
    var sys: Sys
    var name: String
    var dt: Double
    var timezone: Double
    
    func formattedDate() -> String {
        return Constants.DateFormatters.simpleDateFormatter
                .string(from: Date(timeIntervalSince1970: dt))
    }
    
    func formattedSunsetSunrise() -> String {
        let formattedSunrise = Constants.DateFormatters.timeFormatter
            .string(from: Date(timeIntervalSince1970: sys.sunrise! + timezone))
        let formattedSunset = Constants.DateFormatters.timeFormatter
            .string(from: Date(timeIntervalSince1970: sys.sunset! + timezone))
        return formattedSunrise + formattedSunset
    }
}

extension CurrentWeather: Decodable {
    
    /// Put initializer in an extension to preserve the struct's free memberwise initializer.
    /// We want both, but don't want to write the memberwise initializer if we don't need to.
    init() {
        name = ""
        dt = 0.0
        sys = Sys(sunrise: 0, sunset: 0)
        main = Main(temp: 0.0, tempMin: 0.0, tempMax: 0.0, humidity:0.0, feelsLike: 0.0)
        weather = []
        timezone = 0
    }
}
struct Main: Decodable {
    var temp: Double
    var tempMin: Double
    var tempMax: Double
    var humidity: Double
    var feelsLike: Double
}

struct Weather: Decodable {
    var description: String
    var icon: String
}

struct Sys: Decodable {
    var sunrise: Double?
    var sunset: Double?
}

