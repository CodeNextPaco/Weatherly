//
//  APIManager.swift
//  Weatherly
//
//  Created by admin on 6/20/22.
//

import Foundation

class APIManager: ObservableObject {
    
  static private let apiKey = "<insert API Key>"

  func getLocationFrom(query: String, completionHandler: @escaping (Location?, Error?) -> Void) {
        
    //remove space from term for URL
    let clearnTerm = query.replacingOccurrences(of: " ", with: "+")
    let auth = APIManager.apiKey
    let baseUrl = "https://api.openweathermap.org/geo/1.0/direct?q="
    
    //limit to one result, set metric units (change to imperial if needed)
    let fetchString = baseUrl+clearnTerm+"&units=metric&limit=1&appid=\(auth)"
    Network.loadJSONFile(from: fetchString, type: [Location].self) { locationSearchResult, error in
      guard error == nil, locationSearchResult != nil else {
        completionHandler(nil, error)
        return
      }
      completionHandler(locationSearchResult?.first, nil)
    }
  }
    
  func getForecast(from location: Location, completionHandler: @escaping (WeatherForecast?, Error?) -> Void) {
        //see docs: https://openweathermap.org/forecast5
        
    let auth = APIManager.apiKey
    
    let fetchString
    = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.lat)&lon=\( location.lon)&units=imperial&appid=\(auth)"
    
    print("URL String for fetching weather.....")
    print(fetchString)
              
    Network.loadJSONFile(from: fetchString, type: WeatherForecast.self) { weatherForecast, error in
      guard error == nil else {
        completionHandler(nil, error)
        return
      }
      completionHandler(weatherForecast, nil)
    }
  }
    
  func fetchCurrentWeather(location: Location, completionHandler: @escaping (CurrentWeather?, Error?) -> Void) {
        
    // see docs : https://openweathermap.org/current
            
    let auth = APIManager.apiKey
    
    let fetchString
    = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.lat)&lon=\(location.lon)&units=imperial&appid=\(auth)"
    
    print("URL String for fetching weather.....")
    print(fetchString)
          
    Network.loadJSONFile(from: fetchString, type: CurrentWeather.self) { currentWeather, error in
      guard error == nil, currentWeather != nil else {
        completionHandler(nil, error)
        return
      }
      completionHandler(currentWeather, nil)
    }
  }
    
}


 
