import Foundation


struct DailyWeather {
    
    let date: Date
    
    /// The maximum value of temperature during a given day.
    let temperatureMax: Int
    
    /// The minimum value of temperature during a given day.
    let temperatureMin: Int
    
    /// The probability of precipitation occurring, between 0 and 100, inclusive.
    let precipProbability: Int
    
    /// A machine-readable summary of this weather point, suitable for selecting an icon for display.
    let weatherIconType: WeatherIconType
}
