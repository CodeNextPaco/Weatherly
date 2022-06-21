//
//  Weather.swift
//  Weatherly
//
//  Created by admin on 6/20/22.
//

import Foundation

struct WeatherResponse: Codable {
    var current: Weather
    var hourly: [Weather]
    var daily: [WeatherDaily]
    
    static func empty() -> WeatherResponse {
        return WeatherResponse(
            current: Weather(),
            hourly: [Weather](repeating: Weather(), count: 24),
            daily: [WeatherDaily](repeating: WeatherDaily(), count: 8)
        )
    }
}


struct Weather: Codable, Identifiable  {
    
    var temp: Double
    var feels_like: Double
    var pressure: Int
    var weather: [WeatherDetail]
    
    init() {
        
        temp = 0.0
        feels_like = 0.0
        pressure = 0
        weather = []
    }
    
}

//makes warning go away. Needs to conform to protocol with Unique ID
extension Weather {
    var id: UUID {
        return UUID()
    }
}

struct  WeatherDaily: Codable, Identifiable {
    var dt: Int
    var temp_min: Double
    var temp_max: Double
    var weather: [WeatherDetail]
    
    enum CodingKey: String {
        case dt
    case temp
    case weather
    }
    
    init() {
        dt = 0
        temp_min =  0.0
        temp_max = 0.0
        weather = [WeatherDetail(main: "", description: "", icon: "")]
    }
}

extension WeatherDaily {
    var id: UUID {
        return UUID()
    }
}

struct WeatherDetail: Codable {
    var main: String
    var description: String
    var icon: String
}
