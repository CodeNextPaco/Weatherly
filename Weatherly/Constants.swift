//
//  Constants.swift
//  Weatherly
//
//  Created by Derek Chang on 7/5/22.
//

import Foundation

struct Constants {
    
    struct DateFormatters {
        static let utcDateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormatter
        }()
        static let simpleDateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .short
            return dateFormatter
        }()
    }
}
