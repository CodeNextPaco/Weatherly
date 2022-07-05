//
//  WeatherForecast.swift
//  Weatherly
//
//  Created by Derek Chang on 7/5/22.
//

import Foundation

struct WeatherForecast: Codable {
    var list: [WeatherCurrent]
    
    init() {
        list = []
    }
}

extension WeatherForecast {
    enum CodingKey: String {
        case list
    }
}
