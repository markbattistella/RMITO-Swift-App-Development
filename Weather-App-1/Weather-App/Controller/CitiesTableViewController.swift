//
//  CitiesTableViewController.swift
//  mbWeatherApp
//
//  Created by Mark Battistella on 3/8/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController {
	
	// variables
	var cities = [City]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// create the array
		createCitiesArray()
	}
	
	// cities - longitude - latitude
	func createCitiesArray() {
		cities = [
			City(name: "Paris",			latitude: "48.856613",	longitude: "2.352222"),
			City(name: "Bruges",		latitude: "51.209347",	longitude: "3.224699"),
			City(name: "Amsterdam",		latitude: "52.370216",	longitude: "4.895168"),
			City(name: "Berlin",		latitude: "52.520008",	longitude: "13.404954"),
			City(name: "Prague",		latitude: "50.075539",	longitude: "14.437800"),
			City(name: "Munich",		latitude: "48.1351",	longitude: "11.5820"),
			City(name: "Salzburg",		latitude: "47.8095",	longitude: "13.0550"),
			City(name: "Vienna",		latitude: "48.2082",	longitude: "16.3738"),
			City(name: "Krakow",		latitude: "50.0647",	longitude: "19.9450"),
			City(name: "Budapest",		latitude: "47.4979",	longitude: "19.0402"),
			City(name: "Split",			latitude: "43.5081",	longitude: "16.4402"),
			City(name: "Venice",		latitude: "45.4408",	longitude: "12.3155"),
			City(name: "Rome",			latitude: "41.9028",	longitude: "12.4964"),
			City(name: "Florence",		latitude: "43.7696",	longitude: "11.2558"),
			City(name: "Cinque Terre",	latitude: "44.1461",	longitude: "9.6439"),
			City(name: "Lauterbrunnen",	latitude: "46.5935",	longitude: "7.9091"),
			City(name: "Milan",			latitude: "45.4642",	longitude: "9.1900"),
			City(name: "Nice",			latitude: "43.7102",	longitude: "7.2620"),
			City(name: "Barcelona",		latitude: "41.3851",	longitude: "2.1734"),
			City(name: "San Sebastian",	latitude: "43.3183",	longitude: "1.9812")
		]
	}

	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == SegueIdentifier.forecastVC.rawValue {
			let forecastTableViewController = segue.destination as! ForecastTableViewController
			let indexPath = tableView.indexPathForSelectedRow!
			let selectedCity = cities[indexPath.row]

			forecastTableViewController.currentCity			= selectedCity.name
			forecastTableViewController.currentLongitude	= selectedCity.longitude
			forecastTableViewController.currentLatitude		= selectedCity.latitude
		}
	}

}
