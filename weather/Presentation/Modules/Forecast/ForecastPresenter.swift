//
//  ForecastPresenter.swift
//  weather
//
//  Created by Иван Миронов on 30.03.2021.
//

import Foundation
import CoreLocation

class ForecastPresenter: ForecastViewOutput {
    weak var view: ForecastViewInput!
    let service = WeatherServiceImp.shared
    var twoDementionArray: [[WeatherForForecast]] = []
    var locationService: LocationServiceImp = .shared
    
    init(view: ForecastViewInput) {
        self.view = view
    }
    
    deinit {
        locationService.remove(observer: self)
    }
        
    func viewIsReady() {
        view.setupInitailState()
        view.startLoading()
        registrationInLocationService()
    }
    
    func takeWeather(by coordinate: CLLocationCoordinate2D) {
        service.getWeatherForecast(by: coordinate) { (weatherArray, error) in
            if let array = weatherArray {
                self.twoDementionArray = self.makeTwoDementionArray(from: array)
                self.view.reload(with: self.twoDementionArray)
            }
            
            if let error = error {
                self.view.show(error)
                self.view.showReconnectButton()
            }
        }
    }
    
    func makeTwoDementionArray(from array: [WeatherForForecast]) -> [[WeatherForForecast]] {
        var twoDementionArray: [[WeatherForForecast]] = []
        let calendar = Calendar(identifier: .gregorian)
        
        for i in 0..<array.count {
            let firstIndex = twoDementionArray.firstIndex { (obj) -> Bool in
                let date = array[i].dateTwo
                let day = calendar.component(.day, from: date)
                                                            
                let objDate = obj.first?.dateTwo
                guard let unwrapData = objDate else {
                    return false
                }
                let objDay = calendar.component(.day, from: unwrapData)
                return day == objDay
            }
            
            if let index = firstIndex {
                twoDementionArray[index].append(array[i])
            } else {
                let temp = [array[i]]
                twoDementionArray.append(temp)
            }
        }
        return twoDementionArray
    }
    
    func registrationInLocationService() {
        if let error = locationService.locationServiceError {
            view.alert(error: error)
            view.showReconnectButton()
        } else {
            locationService.register(self)
        }
    }
    
}

extension ForecastPresenter: LocationServiceObserver {
    func locationService(_ locationService: LocationServiceImp, takeCoorditanes: CLLocationCoordinate2D) {
        takeWeather(by: takeCoorditanes)
    }
    
    func locationService(_ locationService: LocationServiceImp, call: Error) {
        view.alert(error: call)
    }
}
