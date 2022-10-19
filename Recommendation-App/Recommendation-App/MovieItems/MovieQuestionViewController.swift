//
//  MovieQuestionViewController.swift
//  mbRecommendationSystem
//
//  Created by Mark Battistella on 7/4/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import UIKit

class MovieQuestionViewController: UIViewController {
	
	// variable: IB
	@IBOutlet var movieQuestionLabel:	UILabel!
	@IBOutlet var movieProgressBar:		UIProgressView!
	@IBOutlet var movieAnswerButton01:	UIButton!
	@IBOutlet var movieAnswerButton02:	UIButton!
	@IBOutlet var movieAnswerButton03:	UIButton!
	@IBOutlet var movieAnswerButton04:	UIButton!
	

	
	

	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		a()
		
	}

	
	func a() {
		
		var decades = [String]()
		for movie in movieListArray {
//			decades.append(movie.decade)
			
			print( movie.dec )
		}
		
	}
	
}
