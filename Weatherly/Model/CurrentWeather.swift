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
    
    init() {
        name = ""
        dt = 0.0
        main = WeatherMain(temp: 0.0, temp_min: 0.0, temp_max: 0.0, humidity:0.0, feels_like: 0.0)
        weather = []
    }
    
    func formattedDate() -> String {
        return Constants.DateFormatters.simpleDateFormatter
                .string(from: Date(timeIntervalSince1970: dt))
    }
}

extension CurrentWeather: Codable {
    struct WeatherMain: Codable {
        var temp: Double
        var temp_min: Double
        var temp_max: Double
        var humidity: Double
        var feels_like: Double
    }
    
    struct WeatherDetail: Codable {
        var main: String
        var description: String
        var icon: String
    }
    
    enum CodingKey: String {
        case main
        case weather
        case name
        case pop
        case dt
    }
}

