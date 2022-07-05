//
//  WeatherForecast.swift
//  Weatherly
//
//  Created by Derek Chang on 7/5/22.
//

import Foundation

struct WeatherForecast {
    var list: [CurrentWeather]
    
    init() {
        list = []
    }
}

extension WeatherForecast: Codable {
    enum CodingKey: String {
        case list
    }
}
