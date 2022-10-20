//
//  CitiesTableViewController+Extension.swift
//  mbWeatherApp
//
//  Created by Mark Battistella on 1/9/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import UIKit

// extend to make it clean
extension CitiesTableViewController {
	
	// number of sections
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	// number of rows
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cities.count
	}
	
	// what to display on the label
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.cityCell.rawValue, for: indexPath)
		
		let city = cities[indexPath.row]
		cell.textLabel?.text = city.name
		
		return cell
	}
}
