//
//  Location.swift
//  Weatherly
//
//  Created by admin on 6/20/22.
//

import Foundation


struct Location: Decodable{
    
    var name: String
    var lat: Double
    var lon: Double
    var country: String
    var state: String?
    
    init(){
        
        name = ""
        lat = 0.0
        lon = 0.0
        country = ""
        state = ""
    }
    
    static func getLocation() -> Location{
        
        return Location()
    }
    
}
