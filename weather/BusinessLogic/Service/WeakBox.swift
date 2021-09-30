//
//  WeakBox.swift
//  weather
//
//  Created by Иван Миронов on 27.04.2021.
//

import Foundation

class WeakBox {
    weak var object: AnyObject?
    
    init(object: AnyObject) {
        self.object = object
    }
}
