//
//  Weather.swift
//  mbWeatherApp
//
//  Created by Mark Battistella on 5/8/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import Foundation

// reusable delegate
protocol WeatherManagerDelegate {
	
	// requirement
	func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherData)
	func didFailWithError(error: Error)
}


struct WeatherManager {
	
	// initilise the API
	let weatherBase = DarkSkyAPI()
	
	var delegate: WeatherManagerDelegate?

	// create the
	func fetchWeather(latitude: String, longitude: String) {
		
		// create the string
		let urlString = "\(weatherBase.baseURL(longitude: longitude, latitude: latitude))"
		
		// get the json data
		performRequest(from: urlString)
	}
	
	//
	func performRequest(from apiURL: String) {
		
		// 1. create url
		if let url = URL(string: apiURL) {
			
			print(url)
			
			// 2. create a url session
			let session = URLSession(configuration: .default)
			
			// 3. give the session a task
			let task = session.dataTask(with: url) { (data, response, error) in
				// stop if there is an error
				if error != nil {
					// pass it to the VC for display
					self.delegate?.didFailWithError(error: error!)
					return
				}
				
				if let safeData = data {
					// self to tell swift its inside this Class
					// optional output
					if let weatherReturn = self.parseJSON(safeData) {
						self.delegate?.didUpdateWeather(self, weather: weatherReturn)
					}
				}
			}
			
			// 4. start the task
			task.resume()
		}
		
	}
	
	func parseJSON(_ weatherData: Data) -> WeatherData? {
		let decoder = JSONDecoder()
		
		do {
			let decodedData = try decoder.decode(WeatherData.self, from: weatherData)

			// constant: currently
			let currentTime			= decodedData.currently.time
			let currentTemperature	= decodedData.currently.temperature
			let currentSummary		= decodedData.currently.summary
			let currentWindBearing	= decodedData.currently.windBearing
			let currentWindSpeed	= decodedData.currently.windSpeed
			let currentIcon			= decodedData.currently.icon

			// current
			let weatherCurrently = WeatherData.Currently(
										time:			currentTime,
										temperature:	currentTemperature,
										summary:		currentSummary,
										windBearing:	currentWindBearing,
										windSpeed:		currentWindSpeed,
										icon:			currentIcon
								)


			// hourly array
			var weatherHourlyData = [WeatherData.HourlyData]()
			for i in 0...23 {
				
				// constant: hourly
				let hourlyTime			= decodedData.hourly.data[i].time
				let hourlyTemperature	= decodedData.hourly.data[i].temperature
				let hourlySummary		= decodedData.hourly.data[i].summary
				let hourlyWindBearing	= decodedData.hourly.data[i].windBearing
				let hourlyWindSpeed		= decodedData.hourly.data[i].windSpeed
				let hourlyIcon			= decodedData.hourly.data[i].icon

				// hourly data
				weatherHourlyData.append(WeatherData.HourlyData(
											time:			hourlyTime,
											temperature:	hourlyTemperature,
											summary:		hourlySummary,
											windBearing:	hourlyWindBearing,
											windSpeed:		hourlyWindSpeed,
											icon:			hourlyIcon
				))
			}
			let weatherHourly = WeatherData.Hourly(data: weatherHourlyData)


			// daily array
			var weatherDailyData = [WeatherData.DailyData]()
			for i in 0...6 {
				
				// constant: daily
				let dailyTime				= decodedData.daily.data[i].time
				let dailySummary			= decodedData.daily.data[i].summary
				let dailyWindBearing		= decodedData.daily.data[i].windBearing
				let dailyWindSpeed			= decodedData.daily.data[i].windSpeed
				let dailyIcon				= decodedData.daily.data[i].icon
				let dailyTemperatureHigh	= decodedData.daily.data[i].temperatureHigh
				let dailyTemperatureLow		= decodedData.daily.data[i].temperatureLow

				// daily data
				weatherDailyData.append(WeatherData.DailyData(
											time:				dailyTime,
											summary:			dailySummary,
											windBearing:		dailyWindBearing,
											windSpeed:			dailyWindSpeed,
											icon:				dailyIcon,
											temperatureHigh:	dailyTemperatureHigh,
											temperatureLow:		dailyTemperatureLow
										))
			}
			let weatherDaily = WeatherData.Daily(data: weatherDailyData)

			return WeatherData(currently: weatherCurrently, hourly: weatherHourly, daily: weatherDaily)

		} catch {
			// return the error to the VC
			self.delegate?.didFailWithError(error: error)

			// return nil for optional
			return nil
		}
	}

}
