//
//  Weather.swift
//  weather
//
//  Created by Иван Миронов on 27.03.2021.
//

import Foundation

struct Weather {
    var temperature: Int
    var imageUrl: URL?
    var pressure: Int
    var windSpeed: Double
    var clouds: Int
    var humidity: Int
    var deg: Int
    var cityName: String
    var description: String
    
    init(json: [String: Any]) throws {
        guard let main = json["main"] as? [String: Any],
              let temperature = main["temp"] as? Double,
              let weatherArray = json["weather"] as? [[String: Any]],
              let weather = weatherArray.first,
              let image = weather["icon"] as? String,
              let pressure = main["pressure"] as? Int,
              let humidity = main["humidity"] as? Int,
              let clouds = json["clouds"] as? [String: Any],
              let allClouds = clouds["all"] as? Int,
              let wind = json["wind"] as? [String: Any],
              let windSpeed = wind["speed"] as? Double,
              let deg = wind["deg"] as? Int,
              let cityName = json["name"] as? String,
              let description = weather["description"] as? String else {
            throw SystemError.mapping
        }
        let celsious = temperature.kelvinToCelsius()
        self.pressure = pressure
        self.windSpeed = windSpeed
        self.clouds = allClouds
        self.humidity = humidity
        self.deg = deg
        self.temperature = celsious
        let urlString = "https://openweathermap.org/img/wn/\(image)@2x.png"
        self.imageUrl = URL(string: urlString)
        self.cityName = cityName
        self.description = description
    }
}

struct WeatherForForecast: Hashable {
    var temperature: Int
    var iconUrl: URL?
    var dateTwo: Date
    
    init(_ weather: [String: Any]) throws {
        guard let main = weather["main"] as? [String: Any],
              let dateTwo = weather["dt"] as? Double,
              let temperature = main["temp"] as? Double,
              let weatherArray = weather["weather"] as? [[String: Any]],
              let weather = weatherArray.first,
              let image = weather["icon"] as? String else {
            throw SystemError.mapping
        }
        let celsious = temperature.kelvinToCelsius()
        self.temperature = celsious
        let urlString = "https://openweathermap.org/img/wn/\(image)@2x.png"
        self.iconUrl = URL(string: urlString)
        let dt = Date(timeIntervalSince1970: dateTwo)
        self.dateTwo = dt
    }
}
