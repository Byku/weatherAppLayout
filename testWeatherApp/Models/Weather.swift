import Foundation


protocol Weather {
    
    var date: Date { get }
    var weatherIconType: WeatherIconType { get }
    var precipProbability: Int { get }
    var temperature: Int { get }
}
