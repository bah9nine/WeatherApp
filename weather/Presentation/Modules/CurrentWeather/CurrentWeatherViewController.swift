//
//  CurrentWeatherViewController.swift
//  weather
//
//  Created by Иван Миронов on 12.03.2021.
//

import UIKit
import Kingfisher
import NVActivityIndicatorView

class CurrentWeatherViewController: UIViewController, CurrentWeatherViewInput {
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var reconnectButton: UIButton!
    //stackView
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windyLabel: UILabel!
    @IBOutlet weak var cloudyLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var degLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var output: CurrentWeatherViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = CurrentWeatherPresenter(view: self)
        output.viewIsReady()
    }
    
    func setupInitialState() {
        reconnectButton.isHidden = true
        setupActivityIndicator()
    }
    
    func setupActivityIndicator() {
        activityIndicatorView.type = .ballRotateChase
        activityIndicatorView.color = .red
    }
    
    func startLoading() {
        containerView.isHidden = true
        activityIndicatorView.startAnimating()
    }
    
    func showUI() {
        activityIndicatorView.stopAnimating()
        reconnectButton.isHidden = true
        containerView.isHidden = false
    }
    
    func showReconnectButton() {
        containerView.isHidden = true
        activityIndicatorView.stopAnimating()
        reconnectButton.isHidden = false
    }
    
    func show(_ weather: Weather) {
        temperatureLabel.text = weather.temperature.description + " °C"
        let imageUrl = weather.imageUrl
        weatherImage.kf.setImage(with: imageUrl)
        pressureLabel.text = weather.pressure.description + " мм рт.ст"
        windyLabel.text = weather.windSpeed.description + " м/с"
        cloudyLabel.text = weather.clouds.description + " %"
        humidityLabel.text = weather.humidity.description + " %"
        degLabel.text = weather.deg.description + " hz"
        cityNameLabel.text = weather.cityName
        descriptionLabel.text = weather.description
        
        showUI()
    }
    
    @IBAction func reconnect(_ sender: Any) {
        output.registrationInLocationService()
        reconnectButton.isHidden = true
    }
}
