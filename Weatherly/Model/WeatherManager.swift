//
//  WeatherManager.swift
//  Weatherly
//
//  Created by Derek Chang on 7/5/22.
//

import Foundation

class WeatherManager {
    var currentWeather: CurrentWeather = CurrentWeather()
    var weatherForecast: WeatherForecast = WeatherForecast()
    var currentLocation: Location = Location()
    var apiManager: APIManager = APIManager()
  
    private func fetchCurrentWeather(from location: Location, completionHandler: (() -> Void)? = nil) {
        self.apiManager.fetchCurrentWeather(location: location) { data, error in
            guard error == nil, let currentWeather = data else {
                // TODO: add error handling
                return
            }
            self.currentWeather = currentWeather
            self.currentLocation = location
            completionHandler?()
        }
    }
    // NOTE: Not using this method in VC
    private func fetchForecast(from location: Location, completionHandler: (() -> Void)? = nil){
        self.apiManager.getForecast(from: location) { data, error in
            guard error == nil, let weatherForecast = data else {
                return
            }
            self.weatherForecast = weatherForecast
            completionHandler?()
            return
        }
    }
    func fetchCurrentWeatherAndForecast(from location: String, completionHandler: (()->Void)? = nil) {
        self.apiManager.getLocationFrom(query: location) { data, error in
            guard error == nil, let location = data else {
                // TODO: return an error and inform user of invalid entry.
                return
            }
            self.currentLocation = location
            self.fetchCurrentWeather(from: location) {
                self.fetchForecast(from: location) {
                    completionHandler?()
                    return
                }
            }
        }
    }
}
