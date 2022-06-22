//
//  APIManager.swift
//  Weatherly
//
//  Created by admin on 6/20/22.
//

import Foundation

class APIManager: ObservableObject{
    
    static private let apiKey = "1495b6e70be9d92ba6cafc1c60e83bd6"
    
   // var weatherResponse = WeatherResponse()
    
    var forecastDict : [String: Any] = [:] //a dictonary for the forecast
    var location = Location()

    func getLatLongFromTerm(term: String) async-> Location {
        
//        var locationDict : [String: Any] =  [:] //a dictionary will hold the location data
        
        do{
            
            let auth = APIManager.apiKey
            let baseUrl = "https://api.openweathermap.org/geo/1.0/direct?q="
            
            //limit to one result, set metric units (change to imperial if needed)
            let fetchString = baseUrl+term+"&units=metric&limit=1&appid=\(auth)"
            
            guard let fetchUrl = URL(string: fetchString) else { fatalError("Missing url")}
            
            let urlRequest = URLRequest(url: fetchUrl)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Could not fetch data")}
            
            let decoder = JSONDecoder()
           
            let decoderData = try decoder.decode([Location].self, from: data)
            
//            locationDict = ["name" :decoderData[0].name ,
//                                "lat": decoderData[0].lat,
//                                "lon" : decoderData[0].lon,
//                                "country": decoderData[0].country,
//                                ]
//
            self.location = decoderData[0]
            
            print("Location ******>")
            print(self.location)
            
        } catch  let err {
            
            print("Location fetch failed: \(err)")
            
        }
        
        return  self.location
        
    }
    
    func getForecastFromLocation(location: Location)  async -> Dictionary<String,Any>{
        
        do{
            
            let auth = APIManager.apiKey
            
            let fetchString
            = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.lat)&lon=\(location.lon)&units=metric&appid=\(auth)"
            
            print("URL String for fetching weather.....")
            print(fetchString)
            
            guard let fetchUrl = URL(string: fetchString) else { fatalError("Missing url")}
            
            let urlRequest = URLRequest(url: fetchUrl)
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            
           let forecasts = dataDictionary["list"] as! [[String: Any]]
            
           // print(dataDictionary["list"] )
            
            for forecast in forecasts{
                print("Forecast datetime: ")
                print(forecast["dt_txt"] as Any)

            }
            
            
        } catch let err{
            
            print("Forecast fetch failed: \(err)")
            
        }
        
        return self.forecastDict
        
    }
    
    func fetchCurrentWeather(location: Location) async -> WeatherDaily {
        
        var currentWeather = WeatherDaily()
        
        
        do{
            
            let auth = APIManager.apiKey
            
            let fetchString
            = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.lat)&lon=\(location.lon)&units=imperial&appid=\(auth)"
            
            print("URL String for fetching weather.....")
            print(fetchString)
            
            guard let fetchUrl = URL(string: fetchString) else { fatalError("Missing url")}
            
            let urlRequest = URLRequest(url: fetchUrl)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Could not fetch data")}
        
            let decoder = JSONDecoder()
           
            let decoderData = try decoder.decode(WeatherDaily.self, from: data)
            
            currentWeather = decoderData
            
            
            
            
        } catch let err{
            
            print("API: Get Current Weather failed - \(err)")
            
        }
        return currentWeather
    }
    
    
}


 
