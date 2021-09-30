//
//  ForecastViewController.swift
//  weather
//
//  Created by Иван Миронов on 30.03.2021.
//

import UIKit
import NVActivityIndicatorView

class ForecastViewController: UIViewController, ForecastViewInput {
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var reconnectButton: RoundedButton!
    @IBOutlet weak var tabelView: UITableView!
    var output: ForecastViewOutput!
    var displayManager: ForecastDisplayManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = ForecastPresenter(view: self)
        displayManager = ForecastDisplayManager(tableView: tabelView)
        displayManager.delegate = self
        output.viewIsReady()
    }
    
    func setupInitailState() {
        setupActivityIndicator()
    }
    
    func setupActivityIndicator() {
        activityIndicatorView.type = .ballRotateChase
        activityIndicatorView.color = .red
    }
    
    func startLoading() {
        tabelView.isHidden = true
        reconnectButton.isHidden = true
        activityIndicatorView.startAnimating()
    }
    
    func reload(with data: [[WeatherForForecast]]) {
        displayManager.reload(with: data)
        tabelView.isHidden = false
        activityIndicatorView.stopAnimating()
        reconnectButton.isHidden = true
    }
    
    func showReconnectButton() {
        activityIndicatorView.stopAnimating()
        tabelView.isHidden = true
        reconnectButton.isHidden = false
    }
    
    @IBAction func reconnect(_ sender: Any) {
        output.registrationInLocationService()
        reconnectButton.isHidden = true
    }
}

extension ForecastViewController: ForecastDisplayManagerDelegate {
    func forecastDisplayManager(_ forecastDisplayManager: ForecastDisplayManager, didSelectRowAt row: Int) {
    }
}
