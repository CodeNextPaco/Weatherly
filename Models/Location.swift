//
//  Location.swift
//  Weatherly
//
//  Created by admin on 6/20/22.
//

import Foundation


struct Location: Decodable{
    
    
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
    
    
}
