//
//  SceneDelegate.swift
//  mbWeatherApp
//
//  Created by Mark Battistella on 30/7/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		self.window = UIWindow(windowScene: windowScene)
		
		// name of the main storyboard
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		
		// check the navigation exist
		guard let navigationController = storyboard.instantiateViewController(identifier: ViewControllers.navigationViewController.rawValue) as? UINavigationController else {
			print("ViewController not found")
			return
		}
		
		// check the saved keys exist
		if let foundForecastSelection = UserDefaults.standard.string(forKey: Keys.pinnedCitySelection.rawValue),
			let foundForecastCity = UserDefaults.standard.string(forKey: Keys.pinnedCityName.rawValue),
			let foundForecastLatitude = UserDefaults.standard.string(forKey: Keys.pinnedCityLatitude.rawValue),
			let foundForecastLongitude = UserDefaults.standard.string(forKey: Keys.pinnedCityLongitude.rawValue) {
			
			// check the VC exists
			if let citiesVC = storyboard.instantiateViewController(identifier: ViewControllers.citiesTableViewController.rawValue) as? CitiesTableViewController,
				let forecastVC = storyboard.instantiateViewController(identifier: ViewControllers.forecastTableViewController.rawValue) as? ForecastTableViewController,
				let weatherVC = storyboard.instantiateViewController(identifier: ViewControllers.weatherTableViewController.rawValue) as? WeatherTableViewController {
				
				// set up the saved city
				let city = City(
					name: foundForecastCity,
					latitude: foundForecastLatitude,
					longitude: foundForecastLongitude
				)
				
				// set the VC variables
				weatherVC.currentCity = city.name
				weatherVC.currentLatitude = city.latitude
				weatherVC.currentLongitude = city.longitude
				
				// set up the destination view
				if foundForecastSelection == ForecastSwitch.currentForecast.rawValue {
					weatherVC.currentSelection = .currentForecast
				} else if foundForecastSelection == ForecastSwitch.dailyForecast.rawValue {
					weatherVC.currentSelection = .dailyForecast
				} else if foundForecastSelection == ForecastSwitch.weeklyForecast.rawValue {
					weatherVC.currentSelection = .weeklyForecast
				}
				
				// set up the list variables
				forecastVC.currentCity = city.name
				forecastVC.currentLatitude = city.latitude
				forecastVC.currentLongitude = city.longitude
				
				// build the VC
				navigationController.viewControllers = [citiesVC, forecastVC, weatherVC]
			}
		}
		
		self.window?.rootViewController = navigationController
		self.window?.makeKeyAndVisible()
		
	}
	
	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
	}
	
	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
	}
	
	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}
	
	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}
	
	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
	}
	
	
}

