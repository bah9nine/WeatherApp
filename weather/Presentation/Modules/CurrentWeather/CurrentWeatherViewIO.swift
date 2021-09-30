//
//  CurrentWeatherIO.swift
//  weather
//
//  Created by Иван Миронов on 12.03.2021.
//

import Foundation
import CoreLocation


protocol CurrentWeatherViewInput: class, BaseViewInput {
    func show(_ weather: Weather)
    func setupInitialState()
    func showReconnectButton()
    func showUI()
    func startLoading()
    func alert(error: Error)
}

protocol CurrentWeatherViewOutput {
    func takeWeather(by coordinate: CLLocationCoordinate2D)
    func viewIsReady()
    func registrationInLocationService()
}
