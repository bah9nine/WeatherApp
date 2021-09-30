//
//  LocationService.swift
//  weather
//
//  Created by Иван Миронов on 27.04.2021.
//

import Foundation

protocol LocationService {
    func register(_ delegate: LocationServiceObserver)
    func remove(observer: LocationServiceObserver)
    var locationServiceError: Error? { get }
}
