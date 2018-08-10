import UIKit


enum WeatherIconType {
    
    case non
    case clearDay
    case clearNight
    case rain
    case snow
    case sleet
    case wind
    case fog
    case cloudy
    case partlyCloudyDay
    case partlyCloudyNight
    case sunRise
    case sunSet

    func imageName() -> String {
        
        switch self {
            case .non:          return "non"
            case .clearDay:     return "clearDay"
            case .clearNight:   return "clearNight"
            case .rain:         return "rain"
            case .snow:         return "snow"
            case .sleet:        return "sleet"
            case .wind:         return "wind"
            case .fog:          return "fog"
            case .cloudy:       return "cloudy"
            case .partlyCloudyDay:      return "partlyCloudyDay"
            case .partlyCloudyNight:    return "partlyCloudyNight"
            case .sunRise:      return "sunrise_set"
            case .sunSet:       return "sunrise_set"
        }
    }
    
    func image() -> UIImage {
        
        return UIImage(named: self.imageName())!
    }
}

enum WindBearing {
    
    case northwest
    case northern
    case northeast
    case eastern
    case southeast
    case southern
    case southwest
    case western
    
    func readableFormat() -> String {
        
        switch self {
            case .northwest:    return "WindBearing.northwest".local()
            case .northern:     return "WindBearing.northern".local()
            case .northeast:    return "WindBearing.northeast".local()
            case .eastern:      return "WindBearing.eastern".local()
            case .southeast:    return "WindBearing.southeast".local()
            case .southern:     return "WindBearing.southern".local()
            case .southwest:    return "WindBearing.southwest".local()
            case .western:      return "WindBearing.western".local()
        }
    }
}

enum Cloudness {
    
    case clear
    case partlyCloudy
    case mostlyCloudy
    case overcast
    
    func readableFormat() -> String {
        
        switch self {
            case .clear:          return "Cloudness.clear".local()
            case .partlyCloudy:   return "Cloudness.partlyCloudy".local()
            case .mostlyCloudy:   return "Cloudness.mostlyCloudy".local()
            case .overcast:       return "Cloudness.overcast".local()
        }
    }
}
