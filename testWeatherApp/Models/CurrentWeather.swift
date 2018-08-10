import Foundation


struct CurrentWeather : Weather {
    
    let location: String
    
    let date: Date
    
    /// The air temperature in degrees Celsius.
    let temperature: Int
    
    /// The maximum value of temperature during a given day.
    let temperatureMax: Int
    
    /// The minimum value of temperature during a given day.
    let temperatureMin: Int
    
    /// The probability of precipitation occurring, between 0 and 100, inclusive.
    let precipProbability: Int
    
    /// The percentage of sky occluded by clouds.
    let cloudCover: Cloudness
    
    /// A machine-readable summary of this weather point, suitable for selecting an icon for display.
    let weatherIconType: WeatherIconType
    
    let additionalInfo: AdditionalWeatherInfo
}

struct AdditionalWeatherInfo {
    
    /// A human-readable text summary of this weather point.
    let summary: String
    
    /// The time of when the sun will rise during a given day.
    let sunriseTime: Date
    
    /// The time of when the sun will set during a given day.
    let sunsetTime: Date
    
    /// The relative humidity, between 0 and 100, inclusive.
    let humidity: Int
    
    /// The direction that the wind is coming from.
    let windBearing: WindBearing
    
    /// The wind speed in meters per second.
    let windSpeed: Int
    
    /// The apparent (or “feels like”) temperature in degrees Celsius.
    let apparentTemperature: Int
    
    /// The intensity (in centimetre of liquid water per hour) of precipitation occurring at the given time.
    let precipIntensity: Int
    
    /// The sea-level air pressure in mm hg. art.
    let pressure: Float
    
    /// The average visibility in meters.
    let visibility: Int
    
    /// The UV index.
    let uvIndex: Int
}
