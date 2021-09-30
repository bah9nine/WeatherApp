//
//  LocationServiceDelegate.swift
//  weather
//
//  Created by Иван Миронов on 19.04.2021.
//

import Foundation
import CoreLocation

protocol LocationServiceObserver: class {
    func locationService(_ locationService: LocationServiceImp, call: Error)
    func locationService(_ locationService: LocationServiceImp, takeCoorditanes: CLLocationCoordinate2D)
}
