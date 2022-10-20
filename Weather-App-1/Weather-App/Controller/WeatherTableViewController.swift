//
//  OutputTableViewController.swift
//  mbWeatherApp
//
//  Created by Mark Battistella on 9/8/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController, WeatherManagerDelegate {
	
	// variables
	var currentCity:		String	= ""
	var currentLatitude:	String	= ""
	var currentLongitude:	String	= ""
	var currentSelection:	ForecastSwitch = .currentForecast
	var weatherManager		= WeatherManager()
	var weatherData:		WeatherData?
	
	// IB: variable
	@IBOutlet weak var navigationPin: UIBarButtonItem!
	
	
	
	
	// MARK: - Begin loading
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// set the VC as the delegate
		weatherManager.delegate = self
		
		// get the data
		weatherManager.fetchWeather(latitude: currentLongitude, longitude: currentLatitude)
		
		//
		navigationItem.title = currentCity
		
		tableView.tableFooterView = UIView()
		
		updatePinnedButton()
	}
	
	
	
	
	@IBAction func pinnedCityForecastTapped(_ sender: Any) {
		UserDefaults.standard.setValue(currentSelection.rawValue, forKey: Keys.pinnedCitySelection.rawValue)
		
		UserDefaults.standard.setValue(currentCity, forKey: Keys.pinnedCityName.rawValue)
		UserDefaults.standard.setValue(currentLatitude, forKey: Keys.pinnedCityLatitude.rawValue)
		UserDefaults.standard.setValue(currentLongitude, forKey: Keys.pinnedCityLongitude.rawValue)
		updatePinnedButton()
	}
	
	func updatePinnedButton() {
		guard let foundForecastSelection = UserDefaults.standard.string(forKey: Keys.pinnedCitySelection.rawValue),
			let foundCityName = UserDefaults.standard.string(forKey: Keys.pinnedCityName.rawValue) else {
				return
		}
		
		if foundForecastSelection == currentSelection.rawValue && foundCityName == currentCity {
			navigationPin.image = UIImage(systemName: "pin.fill")
		}
	}
	
	
	// MARK: - Protocol stubs
	
	// return the data
	func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherData) {
		DispatchQueue.main.async {
			self.weatherData = weather
			self.tableView.reloadData()
		}
	}
	
	// output the error
	func didFailWithError(error: Error) {
		print(error)
	}
	
	// MARK: - Table view data source
	
	// how many sections
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	// switch numebr of rows on number of results
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch currentSelection {
			
			// fixed 1 for current
			case .currentForecast:
				return 1
			case .dailyForecast:
				return weatherData?.hourly.data.count ?? 0
			case .weeklyForecast:
				return weatherData?.daily.data.count ?? 0
		}
	}
	
	// pass data onto the cell for formatting
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// use the reusable identifier
		// guard is for returning the error if failed
		guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherCell.rawValue) as? WeatherTableViewCell else {
			fatalError("Could not dequeue a cell")
		}
		
		// hide all elements
		cell.forecastCellTemperatureLabel.isHidden		= true
		cell.forecastCellTemperatureLowLabel.isHidden	= true
		cell.forecastCellTemperatureHighLabel.isHidden	= true
		
		
		
		switch currentSelection {
			
			// .current forecast
			case ForecastSwitch.currentForecast:
				if let data = weatherData?.currently {
					
					// icon
					cell.forecastCellIconImage.image = apiIconToImage(apiImage: data.icon)
					
					// time
					cell.forecastCellTimeRecordedLabel.text = apiDateFormatter(apiDouble: data.time)
					
					// temperature
					cell.forecastCellTemperatureLabel.text = String(data.temperature) + "°C"
					cell.forecastCellTemperatureLabel.isHidden = false
					cell.forecastCellTemperatureLowLabel.isHidden = true
					cell.forecastCellTemperatureHighLabel.isHidden = true
					
					// summary
					cell.forecastCellSummaryLabel.text = data.summary
					
					// windBearing
					cell.forecastCellWindBearingLabel.text =  "Wind direction: " +  String(data.windBearing) + "°"
					
					// windSpeed
					cell.forecastCellWindSpeedLabel.text = "Wind speed: " + String(data.windSpeed) + "km/h"
			}
			
			// .daily forecast
			case ForecastSwitch.dailyForecast:
				if let data = weatherData?.hourly.data[indexPath.row] {
					
					// icon
					cell.forecastCellIconImage.image = apiIconToImage(apiImage: data.icon)
					
					// time
					cell.forecastCellTimeRecordedLabel.text = apiDateFormatter(apiDouble: data.time)
					
					// temperature
					cell.forecastCellTemperatureLabel.text = String(data.temperature) + "°C"
					cell.forecastCellTemperatureLabel.isHidden = false
					cell.forecastCellTemperatureLowLabel.isHidden = true
					cell.forecastCellTemperatureHighLabel.isHidden = true
					
					// summary
					cell.forecastCellSummaryLabel.text = data.summary
					
					// windBearing
					cell.forecastCellWindBearingLabel.text = "Wind direction: " + String(data.windBearing) + "°"
					
					// windSpeed
					cell.forecastCellWindSpeedLabel.text = "Wind speed: " + String(data.windSpeed) + " km/h"
					
			}
			
			// .weekly forecast
			case ForecastSwitch.weeklyForecast:
				if let data = weatherData?.daily.data[indexPath.row] {
					
					// icon
					cell.forecastCellIconImage.image = apiIconToImage(apiImage: data.icon)
					
					// time
					cell.forecastCellTimeRecordedLabel.text = apiDateFormatter(apiDouble: data.time)
					
					// temperature
					cell.forecastCellTemperatureLabel.isHidden = true
					cell.forecastCellTemperatureLowLabel.isHidden = false
					cell.forecastCellTemperatureHighLabel.isHidden = false
					cell.forecastCellTemperatureLowLabel.text = "L: " + String(data.temperatureLow) + "°C"
					cell.forecastCellTemperatureHighLabel.text = "H: " + String(data.temperatureHigh) + "°C"
					// summary
					cell.forecastCellSummaryLabel.text = data.summary
					
					// windBearing
					cell.forecastCellWindBearingLabel.text = "Wind direction: " + String(data.windBearing) + "°"
					
					// windSpeed
					cell.forecastCellWindSpeedLabel.text = "Wind speed: " + String(data.windSpeed) + " km/h"
			}
		}
		return cell
	}
	
	// fixed row sizing
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 156
	}
}
