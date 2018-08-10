import Foundation


class WeatherGenerator : WeatherForecastGenerator  {
    
    static func weatherForecast() -> WeatherForecast {
        
        let additionalInfo = AdditionalWeatherInfo(summary: "WeatherSummary".local(),
                                                   sunriseTime: .date(with: (2017, 7, 27, 5, 30)),
                                                   sunsetTime: .date(with: (2017, 7, 27, 23, 25)),
                                                   humidity: 53,
                                                   windBearing: .southern,
                                                   windSpeed: 4,
                                                   apparentTemperature: 25,
                                                   precipIntensity: 0,
                                                   pressure: 759.46,
                                                   visibility: 970,
                                                   uvIndex: 6)

        let currentForecast = CurrentWeather(location: "Novosibirsk".local(),
                                             date: .date(with: (2017, 7, 27, 11, 0)),
                                             temperature: 25,
                                             temperatureMax: 27,
                                             temperatureMin: 17,
                                             precipProbability: 0,
                                             cloudCover: .partlyCloudy,
                                             weatherIconType: .partlyCloudyDay,
                                             additionalInfo: additionalInfo)
        
        let hourlyForecast = [(Date.date(with: (2017, 7, 27, 12, 0)), 25, 0, WeatherIconType.partlyCloudyDay),
                              (Date.date(with: (2017, 7, 27, 13, 0)), 25, 0, WeatherIconType.partlyCloudyDay),
                              (Date.date(with: (2017, 7, 27, 14, 0)), 26, 0, WeatherIconType.partlyCloudyDay),
                              (Date.date(with: (2017, 7, 27, 15, 0)), 26, 0, WeatherIconType.partlyCloudyDay),
                              (Date.date(with: (2017, 7, 27, 16, 0)), 26, 0, WeatherIconType.partlyCloudyDay),
                              (Date.date(with: (2017, 7, 27, 17, 0)), 27, 0, WeatherIconType.clearDay),
                              (Date.date(with: (2017, 7, 27, 18, 0)), 27, 0, WeatherIconType.clearDay),
                              (Date.date(with: (2017, 7, 27, 19, 0)), 27, 0, WeatherIconType.clearDay),
                              (Date.date(with: (2017, 7, 27, 20, 0)), 26, 0, WeatherIconType.clearDay),
                              (Date.date(with: (2017, 7, 27, 21, 0)), 25, 0, WeatherIconType.clearDay),
                              (Date.date(with: (2017, 7, 27, 22, 0)), 24, 0, WeatherIconType.clearDay),
                              (Date.date(with: (2017, 7, 27, 23, 0)), 23, 0, WeatherIconType.clearDay),
                              (Date.date(with: (2017, 7, 27, 0, 0)), 23, 0, WeatherIconType.clearNight),
                              (Date.date(with: (2017, 7, 27, 01, 0)), 20, 0, WeatherIconType.partlyCloudyNight),
                              (Date.date(with: (2017, 7, 27, 02, 0)), 19, 0, WeatherIconType.partlyCloudyNight),
                              (Date.date(with: (2017, 7, 27, 03, 0)), 17, 0, WeatherIconType.fog),]
            .map {
                return HourlyWeather(date: $0.0,
                                     temperature: $0.1,
                                     precipProbability: $0.2,
                                     weatherIconType: $0.3)
            }
        
        let dailyForecast =  [(Date.date(with: (2017, 7, 28, 0, 0)), 28, 16, 20, WeatherIconType.partlyCloudyDay),
                              (Date.date(with: (2017, 7, 29, 0, 0)), 26, 14, 80, WeatherIconType.rain),
                              (Date.date(with: (2017, 7, 30, 0, 0)), 20, 12, 60, WeatherIconType.rain),
                              (Date.date(with: (2017, 7, 31, 0, 0)), 21, 13, 50, WeatherIconType.rain),
                              (Date.date(with: (2017, 8, 1, 0, 0)), 17, 9, 40, WeatherIconType.rain),
                              (Date.date(with: (2017, 8, 2, 0, 0)), 17, 7, 30, WeatherIconType.partlyCloudyDay),
                              (Date.date(with: (2017, 8, 3, 0, 0)), 17, 8, 30, WeatherIconType.partlyCloudyDay),
                              (Date.date(with: (2017, 8, 4, 0, 0)), 21, 11, 30, WeatherIconType.partlyCloudyDay),
                              (Date.date(with: (2017, 8, 5, 0, 0)), 23, 12, 10, WeatherIconType.clearDay),]
            .map {
                return DailyWeather(date: $0.0,
                                    temperatureMax: $0.1,
                                    temperatureMin: $0.2,
                                    precipProbability: $0.3,
                                    weatherIconType: $0.4)
        }
        
        return WeatherForecast(currentWeather: currentForecast,
                               hourlyWeather: hourlyForecast,
                               dailyWeather: dailyForecast)
    }
}


private typealias SeparatedDateComponents = (
    year: Int, month: Int, day: Int, hour: Int, minute: Int
)

private extension Date {

    static let dateFormatter: DateFormatter = {
        let dateFormat = "dd/MM/yyyy HH:mm"
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter
    }()
    
    static func date(with components: SeparatedDateComponents) -> Date {
        
        return self.dateFormatter
            .date(from: "\(components.day)/\(components.month)/\(components.year) \(components.hour):\(components.minute)")!
    
    }
}
