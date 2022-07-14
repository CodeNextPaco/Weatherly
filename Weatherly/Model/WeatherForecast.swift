//
//  WeatherForecast.swift
//  Weatherly
//
//  Created by Derek Chang on 7/5/22.
//

import Foundation

struct WeatherForecast: Decodable {
    var list: [CurrentWeather]
    
    init() {
        list = []
    }
}
