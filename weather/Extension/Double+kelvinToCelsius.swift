//
//  KelvinToCelsius.swift
//  weather
//
//  Created by Иван Миронов on 30.03.2021.
//

import Foundation

extension Double {
    func kelvinToCelsius() -> Int {
        let celsious = self - 273.15
        return Int(celsious)
    }
}
