//
//  ForecastTableViewController.swift
//  mbWeatherApp
//
//  Created by Mark Battistella on 3/8/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import UIKit

class ForecastTableViewController: UITableViewController {
	
	// variables
	var currentCity:		String = ""
	var currentLatitude:	String = ""
	var currentLongitude:	String = ""
	
	// IB variables
	@IBOutlet var tableLabelCollection: [UILabel]!
	
	
	// just load the Storyboard
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		// set the destination VC
		let WeatherTableViewController = segue.destination as! WeatherTableViewController
		let indexPath = tableView.indexPathForSelectedRow!
		
		guard let selectedForecast = ForecastSwitch(rawValue: tableLabelCollection[indexPath.row].text!) else {
			print("No static row label text!")
			return
		}
		
		// what to pass on
		WeatherTableViewController.currentCity		= currentCity
		WeatherTableViewController.currentLatitude	= currentLatitude
		WeatherTableViewController.currentLongitude	= currentLongitude
		WeatherTableViewController.currentSelection	= selectedForecast
		
	}
	
}
