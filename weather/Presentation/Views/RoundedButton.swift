//
//  RoundedButton.swift
//  weather
//
//  Created by Иван Миронов on 01.04.2021.
//

import UIKit

class RoundedButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let height = frame.height
        let width = frame.width
        
        layer.cornerRadius = 10
        let shadowSize: CGFloat = 20
        let shadowDistance: CGFloat = 20
        let contactRect = CGRect(x: -shadowSize, y: height - (shadowSize * 0.4) + shadowDistance, width: width + shadowSize * 2, height: shadowSize)
        layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.4
    }
}
