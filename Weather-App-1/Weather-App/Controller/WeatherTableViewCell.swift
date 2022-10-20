//
//  WeatherTableViewCell.swift
//  mbWeatherApp
//
//  Created by Mark Battistella on 9/8/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
	
	@IBOutlet weak var forecastCellIconImage: UIImageView!
	@IBOutlet weak var forecastCellTemperatureLabel: UILabel!
	@IBOutlet weak var forecastCellWindSpeedLabel: UILabel!
	@IBOutlet weak var forecastCellWindBearingLabel: UILabel!
	@IBOutlet weak var forecastCellSummaryLabel: UILabel!
	@IBOutlet weak var forecastCellTimeRecordedLabel: UILabel!
	
	@IBOutlet weak var forecastCellTemperatureHighLabel: UILabel!
	@IBOutlet weak var forecastCellTemperatureLowLabel: UILabel!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
}
