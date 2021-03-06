//
//  Constants.swift
//  Weatherly
//
//  Created by Derek Chang on 7/5/22.
//

import Foundation

struct Constants {
    
    /// GMT is used because Weather API returns time in UTC (aka GMT)
    struct DateFormatters {
        static let simpleDateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current
            dateFormatter.timeZone = TimeZone(identifier: "GMT")
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .short
            return dateFormatter
        }()
        
        static let timeFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current
            dateFormatter.timeZone = TimeZone(identifier: "GMT")
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .none
            return dateFormatter
        }()
    }
    
    /// Given seconds since 1970, return the day of the week
    /// Calendar API weekday: 1 = Sun, 7 = Sat
    static func dayOfWeek(from dt: Double) -> Constants.days {
        let date = Date(timeIntervalSince1970: dt)
        let calendar = Calendar(identifier: .gregorian)
        let dayIndex = calendar.component(.weekday, from: date)
        return Constants.days.allCases[dayIndex - 1]
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
//            case "02n": return "nFewClouds"
//            case "03n": return "nScatteredClouds"
            case "04n": return "nBrokenClouds"
            case "09n": return "nShowerRain"
//            case "10n": return "nRain"
            case "11n": return "nThunderstorm"
            case "13n": return "nSnow"
            case "15n": return "nMist"
        default:
            return icon.contains("d") ? "dClearSky" : "nClearSky"
        }
    }
    
    enum days: String, CaseIterable, Comparable {
        case Sun
        case Mon
        case Tue
        case Wed
        case Thur
        case Fri
        case Sat
        /// this is needed to sort days
        private var sortOrder: Int {
            switch self {
                case .Sun: return 0
                case .Mon: return 1
                case .Tue: return 2
                case .Wed: return 3
                case .Thur: return 4
                case .Fri: return 5
                case .Sat: return 6
            }
        }
        
        static func < (lhs: Constants.days, rhs: Constants.days) -> Bool {
            return lhs.sortOrder < rhs.sortOrder
        }
    }
    /// Returns the current day of the week
    /// 1=sun 7=sat
    static var currentWeekday: days = {
        let calendar = Calendar(identifier: .gregorian)
        let dayIndex = calendar.component(.weekday, from: Date())
        return Constants.days.allCases[dayIndex - 1]
    }()
}
