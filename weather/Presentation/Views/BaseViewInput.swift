//
//  BaseViewInput.swift
//  weather
//
//  Created by Иван Миронов on 30.03.2021.
//

import UIKit

protocol BaseViewInput {
    func show(_ error: Error)
    func showAlert(titel: String?, massage: String?)
    func alert(error: Error)
}

extension BaseViewInput {
    func showAlert(titel: String?, massage: String?) {
        guard let vc = self as? UIViewController else { return }
        let alert = UIAlertController(title: titel, message: massage, preferredStyle: .alert)
        let action = UIAlertAction(title: titel, style: .default)
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func show(_ error: Error) {
        showAlert(titel: "Error", massage: error.localizedDescription)
    }
    
    func alert(error: Error) {
        let massage = error.localizedDescription
        guard let vc = self as? UIViewController else { return }
        let alert = UIAlertController(title: "Error", message: massage, preferredStyle: .alert)
        let openSettingsAction = UIAlertAction(title: "Settings", style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }
        alert.addAction(openSettingsAction)
        vc.present(alert, animated: true, completion: nil)
    }
}
