//
//  Errors.swift
//  weather
//
//  Created by Иван Миронов on 28.03.2021.
//

import Foundation

enum SystemError: LocalizedError {
    case mapping
    case requestProblem
    case locationServices
    case permissonProblem
    
    var errorDescription: String? {
        switch self {
        case .mapping:
            return "Mapping error"
        case .requestProblem:
            return "Request problem"
        case .locationServices:
            return "Turn On all location services"
        case .permissonProblem:
            return "Need permission to use location"
        }
    }
}
