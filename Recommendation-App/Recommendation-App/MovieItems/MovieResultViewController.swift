//
//  MovieResultViewController.swift
//  mbRecommendationSystem
//
//  Created by Mark Battistella on 8/4/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import UIKit

class MovieResultViewController: UIViewController {
	
	// variables: IB
	@IBOutlet var movieResultImage: UIImageView!
	@IBOutlet var movieResultTitle: UILabel!
	
	@IBOutlet var findAMovieButton: UIButton!
	@IBOutlet var restartButton: UIButton!
	@IBOutlet var footerLabel: UILabel!
	
	
	var responses: [MovieAnswer]!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// method: sum all answers and return recommendation
		calculateMovieResult()
	}
	
	// method: sum the movie answers
	func calculateMovieResult() {
		
		// create the { movie : frequency }
		var frequencyOfAnswers: [Movie: Int] = [:]
		
		let responseTypes = responses.map { $0.movie }
		
		for response in responseTypes {
			frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
		}
		
		// sort the results for high to low
		let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key
		
		// update the IB fields
		movieResultImage.image		= mostCommonAnswer.recommendation.moviePoster.image
		movieResultTitle.text		= mostCommonAnswer.recommendation.movieTitle
		movieResultTitle.textColor	= mostCommonAnswer.recommendation.movieFont
		footerLabel.textColor 		= mostCommonAnswer.recommendation.movieFont
		findAMovieButton.setTitleColor( mostCommonAnswer.recommendation.movieFont, for: .normal)
		restartButton.setTitleColor( mostCommonAnswer.recommendation.movieFont, for: .normal)

		// update the view background to match movie
		view.backgroundColor		= mostCommonAnswer.recommendation.movieColour
	}
	
}
