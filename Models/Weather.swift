//
//  Weather.swift
//  Weatherly
//
//  Created by admin on 6/20/22.
//

import Foundation



struct WeatherForecast: Codable {
    
    var list: [WeatherCurrent]
    
    enum CodingKey: String {
        
        case list
    }
    
    init(){
        
        list = []
    }
}

struct  WeatherCurrent: Codable {
    
    var main: WeatherMain
    var weather: [WeatherDetail]
    var name: String?
    var pop: Double?
    var dt_txt: String?
    
    enum CodingKey: String {
        case main
        case weather
        case name
        case pop
        case dt_txt
    }
    
    init() {
    
        name = ""
        main = WeatherMain(temp: 0.0, temp_min: 0.0, temp_max: 0.0, humidity:0.0, feels_like: 0.0)
        weather = [WeatherDetail(main: "", description: "", icon: "")]
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
