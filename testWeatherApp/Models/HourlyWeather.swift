import Foundation


struct HourlyWeather : Weather {
    
    let date: Date
    
    /// The air temperature in degrees Celsius.
    let temperature: Int
    
    /// The probability of precipitation occurring, between 0 and 100, inclusive.
    let precipProbability: Int
    
    /// A machine-readable summary of this weather point, suitable for selecting an icon for display.
    let weatherIconType: WeatherIconType
}
