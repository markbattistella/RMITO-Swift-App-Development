//
//  WeatherTableViewController+Extension.swift
//  mbWeatherApp
//
//  Created by Mark Battistella on 1/9/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import UIKit

// functions
extension WeatherTableViewController {
	
	// format the date
	func apiDateFormatter(apiDouble: Double) -> String {
		let date = Date(timeIntervalSince1970: apiDouble)
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
		dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
		dateFormatter.timeZone = .current
		let localDate = dateFormatter.string(from: date)
		
		return localDate
	}
	
	// convert the api image to system
	enum WeatherIcons: String {
		case clearDay			= "clear-day"
		case clearNight			= "clear-night"
		case partCloudDay		= "partly-cloudy-day"
		case partCloudNight		= "partly-cloudy-night"
		case cloud				= "cloudy"
		case rain				= "rain"
		case sleet				= "sleet"
		case snow				= "snow"
		case wind				= "wind"
		case fog				= "fog"
	}
	
	func apiIconToImage(apiImage: String) -> UIImage {
		switch apiImage {
			case WeatherIcons.clearDay.rawValue:
				return UIImage(systemName: "sun.max.fill")!
			case WeatherIcons.clearNight.rawValue:
				return UIImage(systemName: "moon.stars.fill")!
			case WeatherIcons.partCloudDay.rawValue:
				return UIImage(systemName: "cloud.sun.fill")!
			case WeatherIcons.partCloudNight.rawValue:
				return UIImage(systemName: "cloud.moon.fill")!
			case WeatherIcons.cloud.rawValue:
				return UIImage(systemName: "cloud.fill")!
			case WeatherIcons.rain.rawValue:
				return UIImage(systemName: "cloud.rain.fill")!
			case WeatherIcons.sleet.rawValue:
				return UIImage(systemName: "cloud.sleet.fill")!
			case WeatherIcons.snow.rawValue:
				return UIImage(systemName: "cloud.snow.fill")!
			case WeatherIcons.wind.rawValue:
				return UIImage(systemName: "wind")!
			case WeatherIcons.fog.rawValue:
				return UIImage(systemName: "fog")!
			default:
				return UIImage(systemName: "")!
		}
	}
}
