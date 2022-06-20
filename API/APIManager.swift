//
//  APIManager.swift
//  Weatherly
//
//  Created by admin on 6/20/22.
//

import Foundation

class APIManager: ObservableObject{
    
    static private let apiKey = "1495b6e70be9d92ba6cafc1c60e83bd6"
    
    var locationDict : [String: Any] =  [:] //a dictionary will hold the location data
    
    
    func getLatLongFromTerm(term: String) async-> Dictionary<String, Any> {
        
        do{
            
            let auth = APIManager.apiKey
            
            let baseUrl = "https://api.openweathermap.org/geo/1.0/direct?q="
            
            
            let searchString = baseUrl+term+"&limit=1&appid=\(auth)"
            
            guard let fetchUrl = URL(string: searchString) else { fatalError("Missing url")}
            
            let urlRequest = URLRequest(url: fetchUrl)
            
            print(searchString)
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
          
           print(response)
            
//            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//                print("Didn't get a 200")
//                print((response as? HTTPURLResponse)?.statusCode)
//
//                fatalError("Could not fetch data")
//
//            }
            
             
            
            let decoder = JSONDecoder()
           
            let decoderData = try decoder.decode([Location].self, from: data)
             
            print(decoderData[0].name)
            print(decoderData[0].lat)
            print(decoderData[0].lon)
            
            self.locationDict = ["name" :decoderData[0].name ,
                                "lat": decoderData[0].lat,
                                "lon" : decoderData[0].lon,
                                "country": decoderData[0].country,
                                ]
            
            
            
//            Location(name: decoderData[0].name,
//                                            lat: decoderData[0].lat,
//                                            lon: decoderData[0].lon,
//                                            country: decoderData[0].country,
//                                            state: decoderData[0].state)
            
            
            //print(searchedLocation)
            
        } catch  let err {
            
            print("API failed: \(err)")
            
        }
        
        return  self.locationDict
        
    }
    
    
}


 
