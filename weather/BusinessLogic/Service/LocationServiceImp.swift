//
//  LocationService.swift
//  weather
//
//  Created by Иван Миронов on 19.04.2021.
//

import Foundation
import CoreLocation

class LocationServiceImp: NSObject, LocationService {
    static var shared = LocationServiceImp()
    var locationManager = CLLocationManager()
    private var observerArray: [WeakBox] = []
    var locationServiceError: Error?
    
    private override init() {
        super.init()
        setup()
    }
    
    func setup() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
        } else {
            locationServiceError = SystemError.locationServices
        }
    }
    
    func register(_ delegate: LocationServiceObserver) {
        let isContains = observerArray.contains(where: { (obj) -> Bool in
            return obj === delegate
        })
        
        if !isContains {
            let weakObserver = WeakBox(object: delegate)
            observerArray.append(weakObserver)

            if let coordinate = locationManager.location?.coordinate {
                delegate.locationService(self, takeCoorditanes: coordinate)
            }
        }
    }
    
    func giveLocation() {
        guard let location = locationManager.location?.coordinate else { return }
        observerArray.forEach({ (box) in
            let obj = box.object as? LocationServiceObserver
            obj?.locationService(self, takeCoorditanes: location)
        })
    }
    
    func remove(observer: LocationServiceObserver) {
        let index = observerArray.firstIndex { (obj) -> Bool in
            return obj === observer
        }
        if let indexForDelete = index {
            observerArray.remove(at: indexForDelete)
        }
    }
}

extension LocationServiceImp: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            manager.distanceFilter = 3000
            manager.startUpdatingLocation()
        case .denied, .restricted:
            observerArray.forEach({ (box) in
                let obj = box.object as? LocationServiceObserver
                obj?.locationService(self, call: SystemError.permissonProblem)
            })
                
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        observerArray.forEach({ (box) in
            let obj = box.object as? LocationServiceObserver
            obj?.locationService(self, call: error)
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        giveLocation()
    }
}
