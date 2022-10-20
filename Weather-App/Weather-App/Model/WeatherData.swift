//
//  WeatherData.swift
//  mbWeatherApp
//
//  Created by Mark Battistella on 7/8/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
	
	let currently:	Currently
	let hourly:		Hourly
	let daily:		Daily
	
	// baseline
	struct Currently: Decodable {
		// required
		let time:					Double	// the date
		let temperature:			Double	// current temperature (current scenario only)
		let summary:				String	// weather description
		let windBearing:			Int		// wind direction/bearing
		let windSpeed:				Double	// wind speed
		let icon:					String	// image representing the forecast
	}
	
	// hourly data
	struct Hourly: Decodable {
		let data: [HourlyData]
	}
	
		struct HourlyData: Decodable {
			let time:				Double	// the date
			let temperature:		Double	// current temperature (current scenario only)
			let summary:			String	// weather description
			let windBearing:		Int		// wind direction/bearing
			let windSpeed:			Double	// wind speed
			let icon:				String	// image representing the forecast
		}
	
	
	// daily data
	struct Daily: Decodable {
		let data: [DailyData]
	}

		struct DailyData: Decodable {
			let time:				Double	// the date
			let summary:			String	// weather description
			let windBearing:		Int		// wind direction/bearing
			let windSpeed:			Double	// wind speed
			let icon:				String	// image representing the forecast
			
			let temperatureHigh:	Double	// the high temp
			let temperatureLow:		Double	// the low temp
		}

}
