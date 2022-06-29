//
//  Weather.swift
//  Weatherly
//
//  Created by admin on 6/20/22.
//

import Foundation

//struct WeatherResponse: Codable {
//    var current: Weather
//   // var hourly: [Weather]
//    var daily: [WeatherCurrent]
//
//    static func empty() -> WeatherResponse {
//        return WeatherResponse(
//            current: Weather(),
//           // hourly: [Weather](repeating: Weather(), count: 24),
//            daily: [WeatherCurrent](repeating: WeatherCurrent(), count: 8)
//        )
//    }
//}


//struct Weather: Codable, Identifiable  {
//
//    var temp: Double
//    var feels_like: Double
//    var pressure: Int
//    var main: WeatherMain
//    var weather: [WeatherDetail]
//
//    init() {
//
//        temp = 0.0
//        feels_like = 0.0
//        pressure = 0
//        weather = []
//        main = WeatherMain(temp: 0.0, temp_min: 0.0, temp_max: 0.0, humidity:0.0, feels_like: 0.0)
//    }
//
//}
//
////makes warning go away. Needs to conform to protocol with Unique ID
//extension Weather {
//    var id: UUID {
//        return UUID()
//    }
//}



struct  WeatherCurrent: Codable, Identifiable {
    var dt: Int
    var main: WeatherMain
    var weather: [WeatherDetail]
    var name: String
    
    enum CodingKey: String {
        case dt
        case main
        case weather
        case name
    }
    
    init() {
        dt = 0
        name = ""
        main = WeatherMain(temp: 0.0, temp_min: 0.0, temp_max: 0.0, humidity:0.0, feels_like: 0.0)
        weather = [WeatherDetail(main: "", description: "", icon: "")]
    }
}

extension WeatherCurrent {
    var id: UUID {
        return UUID()
    }
}

struct WeatherMain: Codable{
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
