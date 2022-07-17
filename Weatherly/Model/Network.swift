//
//  Network.swift
//  Weatherly
//
//  Created by Derek Chang on 7/5/22.
//

import Foundation

//
// MARK: - Network
//
class Network {
  //
  // MARK: - Class Methods
  //
  static func loadJSONFile<T: Decodable>(from url: String,
                                         type: T.Type,
                                         completionHandler: @escaping (T?, NetworkError?) -> Void) {

    guard let url = URL(string: url) else {
      completionHandler(nil, .invalidUrl)
      return
    }
    let request = URLRequest(url: url)
    
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
      let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 200
      
      if statusCode != 200 {
        completionHandler(nil, .requestError)
        return
      }
      
      do {
        if let jsonData = data {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let typedObject: T? = try decoder.decode(T.self, from: jsonData)
          completionHandler(typedObject, nil)
        }
      } catch {
        print(error)
        completionHandler(nil, .parseError)
      }
    }
    
    dataTask.resume()
  }
}

