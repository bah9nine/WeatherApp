//
//  DisplayManager.swift
//  weather
//
//  Created by Иван Миронов on 06.04.2021.
//

import UIKit

protocol ForecastDisplayManagerDelegate: AnyObject {
    func forecastDisplayManager(_ forecastDisplayManager: ForecastDisplayManager, didSelectRowAt row: Int)
}

class ForecastDisplayManager: NSObject {
    var tableView: UITableView
    private var twoDemetionArray: [[WeatherForForecast]] = []
    weak var delegate: ForecastDisplayManagerDelegate?
    let dateFormatter = DateFormatter()
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: ForecastCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ForecastCell.identifier)
        tableView.rowHeight = 70
        tableView.delegate = self
        tableView.dataSource = self
    }

    func reload(with data: [[WeatherForForecast]]) {
        self.twoDemetionArray = data
        tableView.reloadData()
    }
}

extension ForecastDisplayManager: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = twoDemetionArray[section][0].dateTwo
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM dd")
        return dateFormatter.string(from: date)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return twoDemetionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDemetionArray[section].count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.identifier) as! ForecastCell
        let weather = twoDemetionArray[indexPath.section][indexPath.row]
        let date = weather.dateTwo
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        let day = dateFormatter.string(from: date)
        cell.fill(weather,day)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.forecastDisplayManager(self, didSelectRowAt: indexPath.row)
    }
}

