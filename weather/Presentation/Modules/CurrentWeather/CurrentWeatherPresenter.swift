//
//  CurrentWeatherPresenter.swift
//  weather
//
//  Created by Иван Миронов on 12.03.2021.
//

import Foundation
import CoreLocation

class CurrentWeatherPresenter: CurrentWeatherViewOutput {
    weak var view: CurrentWeatherViewInput!
    var service: WeatherService = WeatherServiceImp.shared
    let locationService: LocationServiceImp = .shared
    
    init(view: CurrentWeatherViewInput) {
        self.view = view
    }
    
    deinit {
        locationService.remove(observer: self)
    }
    
    func viewIsReady() {
        view.setupInitialState()
        view.startLoading()
        registrationInLocationService()

    }
    
    func takeWeather(by coordinate: CLLocationCoordinate2D) {
        service.getCurrentWeather(by: coordinate) { (weather, error) in
            if let weather = weather {
                self.view.show(weather)
            }
            
            if let error = error {
                self.view.show(error)
                self.view.showReconnectButton()
            }
        }
    }
    
    func registrationInLocationService() {
        if let error = locationService.locationServiceError {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.view.alert(error: error)
            }
            
            view.showReconnectButton()
        } else {
            locationService.register(self)
        }
    }
}

extension CurrentWeatherPresenter: LocationServiceObserver {
    func locationService(_ locationService: LocationServiceImp, call: Error) {
        view.alert(error: call)
    }
    
    func locationService(_ locationService: LocationServiceImp, takeCoorditanes: CLLocationCoordinate2D) {
        takeWeather(by: takeCoorditanes)
    }
}
