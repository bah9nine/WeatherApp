//
//  ForecastCell.swift
//  weather
//
//  Created by Иван Миронов on 01.04.2021.
//

import UIKit

class ForecastCell: UITableViewCell {
    static let identifier: String = "ForecastCell"
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func fill(_ weather: WeatherForForecast, _ day: String) {
        temperatureLabel.text = weather.temperature.description + "°C"
        dateLabel.text = day
        iconImageView.kf.setImage(with: weather.iconUrl)
    }
}
