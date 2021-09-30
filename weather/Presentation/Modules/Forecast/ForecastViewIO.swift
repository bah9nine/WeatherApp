//
//  ForecastViewIO.swift
//  weather
//
//  Created by Иван Миронов on 30.03.2021.
//

import Foundation
import CoreLocation

protocol ForecastViewInput: class, BaseViewInput {
    func setupInitailState()
    func reload(with data: [[WeatherForForecast]])
    func startLoading()
    func showReconnectButton()
    func alert(error: Error)
}

protocol ForecastViewOutput {
    var twoDementionArray: [[WeatherForForecast]] { get }
    func viewIsReady()
    func takeWeather(by coordinate: CLLocationCoordinate2D)
    func registrationInLocationService()
}
