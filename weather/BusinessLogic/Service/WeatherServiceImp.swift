//
//  WeatherImp.swift
//  weather
//
//  Created by Иван Миронов on 12.03.2021.
//

import Foundation
import Alamofire
import CoreLocation

class WeatherServiceImp: WeatherService {
    private lazy var baseUrl = "https://api.openweathermap.org/data/2.5"
    static var shared = WeatherServiceImp()
    private init() {}

    func getCurrentWeather(by coordinate: CLLocationCoordinate2D, _ completionHandler: @escaping (Weather?, Error?) -> Void) {
        let lat = coordinate.latitude
        let lon = coordinate.longitude
        
        let url = "\(baseUrl)/weather"
        let params: [String: Any] = ["appid": "0fe96f06b96bdf2faf4203511dce06af", "lat": lat, "lon": lon]
        
        AF.request(url,parameters: params).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                do {
                    guard let json = value as? [String: Any] else {
                        throw SystemError.requestProblem
                    }
                    let currentWeather = try Weather(json: json)
                    completionHandler(currentWeather,nil)
                } catch {
                    completionHandler(nil, error)
                }
            case .failure(let error):
                completionHandler(nil,error)
            }
        }
    }
    
    func getWeatherForecast(by coordinate: CLLocationCoordinate2D, _ completionHandler: @escaping ([WeatherForForecast]?, Error?) -> Void) {
        let lat = coordinate.latitude
        let lon = coordinate.longitude
        
        let url = "\(baseUrl)/forecast"
        let params: [String: Any] = ["appid": "0fe96f06b96bdf2faf4203511dce06af", "lat": lat, "lon": lon]
        
        AF.request(url,parameters: params).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                do {
                    guard let json = value as? [String: Any],
                          let list = json["list"] as? [[String: Any]] else {
                        throw SystemError.requestProblem
                    }
                    var weatherArray: [WeatherForForecast] = []
                    
                    for weather in list {
                        let data = try WeatherForForecast(weather)
                        weatherArray.append(data)
                    }
                    completionHandler(weatherArray,nil)
                } catch {
                    completionHandler(nil, error)
                }
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
