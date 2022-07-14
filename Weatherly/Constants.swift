//
//  Constants.swift
//  Weatherly
//
//  Created by Derek Chang on 7/5/22.
//

import Foundation

struct Constants {
    
    struct DateFormatters {
        static let simpleDateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .short
            return dateFormatter
        }()
    }
    
    static func getLottieAnimation(from icon: String) -> String {
        switch icon {
            case "01d": return "dClearSky"
            case "02d": return "dFewClouds"
            case "03d": return "dScatteredClouds"
            case "04d": return "dBrokenClouds"
            case "09d": return "dShowerRain"
            case "10d": return "dRain"
            case "11d": return "dThunderstorm"
            case "13d": return "dSnow"
            case "15d": return "dMist"
            case "01n": return "nClearSky"
            case "02n": return "dFewClouds"
            case "03n": return "nScatteredClouds"
            case "04n": return "nBrokenClouds"
            case "09n": return "nShowerRain"
            case "10n": return "nRain"
            case "11n": return "nThunderstorm"
            case "13n": return "nSnow"
            case "15n": return "nMist"
        default:
            return "dClearSky"
        }
    }
}
