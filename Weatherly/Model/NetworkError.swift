//
//  NetworkError.swift
//  Weatherly
//
//  Created by Derek Chang on 7/5/22.
//

import Foundation

enum NetworkError: Error {
  case requestError
  case parseError
  case invalidUrl
  case dateParseError
}
