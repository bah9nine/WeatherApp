//
//  WeatherService.swift
//  weather
//
//  Created by Иван Миронов on 12.03.2021.
//

import Foundation
import CoreLocation

protocol WeatherService {
    func getCurrentWeather(by coordinate: CLLocationCoordinate2D, _ completionHandler: @escaping (Weather?, Error?) -> Void)
    func getWeatherForecast(by coordinate: CLLocationCoordinate2D, _ completionHandler: @escaping ([WeatherForForecast]?, Error?) -> Void) 
}
