//
//  Enum+Identifier.swift
//  mbWeatherApp
//
//  Created by Mark Battistella on 3/8/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import UIKit

// stringy: Cell Identifier
enum CellIdentifier: String {
	case cityCell			= "CityIdentifierCell"
	case weatherCell		= "ForecastIdentifierCell"
}

// stringy: Segue ID
enum SegueIdentifier: String {
	// from city to forecast type
	case forecastVC			= "ToForecastSegue"
	
	// from forecast type to view
	case currentForecast	= "ToCurrentForecast"
	case dailyForecast		= "ToDailyForecast"
	case weeklyForecast		= "ToWeeklyForecast"
}

// stringly: switch view
enum ForecastSwitch: String {
	// from staticlist
	case currentForecast	= "Current weather"
	case dailyForecast		= "24-hour Forecast"
	case weeklyForecast		= "7-day Forecast"
}

// stringly: Storyboard View Controller ID
enum ViewControllers: String {
	case navigationViewController		= "NavigationController"
	case citiesTableViewController		= "CitiesTableViewController"
	case forecastTableViewController	= "ForecastTableViewController"
	case weatherTableViewController		= "WeatherTableViewController"
}

// stringly: User Defaults
enum Keys: String {
	case pinnedCitySelection	= "pinnedCitySelection"
	case pinnedCityName			= "pinnedCityName"
	case pinnedCityLatitude		= "pinnedCityLatitude"
	case pinnedCityLongitude	= "pinnedCityLongitude"	
}
