//
//  ViewController.swift
//  mbPictureMatch
//
//  Created by Mark Battistella on 1/2/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
	
	// variables
	var fruitsToGuess = ["Lemon", "Apple", "Orange", "Strawberry", "Grapes", "Cherry"]
	var fruitsToGuessShuffled = [String]()
	var fruitsToGuessNumber = 0
	var totalButtonPresses = 0
	var totalWins = 0
	var highScore = 0
	
	
	// IB variable
	@IBOutlet var currentGameScoreLabel: UILabel!
	@IBOutlet var highScoreLabel: UILabel!
	@IBOutlet var wordToGuessLabel: UILabel!
	@IBOutlet var buttonCollection: [UIButton]!
	
	// IB function
	@IBAction func buttonImagePressed(_ sender: UIButton) {
		
		// get the button title
		let buttonImageTitle = sender.currentTitle!
		
		// check the button outcome and
		// pass the button title to the function
		buttonImageChecker(userGuessedWord: "\(buttonImageTitle)")
		
		// increment button counts
		totalButtonPresses += 1
		
		// otherwise update the interface
		updateUI()
	}
	
	// did the view load
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// set the high score label
		highScoreLabel.text = "High score\n\(highScore)"
		
		// shuffle the fruit names
		fruitsToGuessShuffled = shuffleArray(stringArray: fruitsToGuess)
		
		// initiate a new round
		newRound()
	}
	
	// function: new round
	func newRound() {
		
		// update the label
		fruitToGuessLabel()
		
		// update the UI
		updateUI()
	}
	
	// function: update interface
	func updateUI() {
		
		// if there are fruits remaining
		if totalButtonPresses < fruitsToGuess.count {
			
			// update the label
			fruitToGuessLabel()
			
			// show the current score
			currentGameScoreLabel.text = "Current score\n\(totalWins)"
			
		} else {
			
			// show the game over page
			performSegue(withIdentifier: "GameOverSegue", sender: self)
			
			// update the high score
			highScoreUpdater()
			
			newGameReset()
		}
	}
	
	// function:
	func highScoreUpdater() {
		
		if totalWins > highScore {
			highScore = totalWins
		}
		
		highScoreLabel.text = "High score\n\(highScore)"
		
	}
	
	// function: update the label
	func fruitToGuessLabel() {
		
		// add the fruit name to the label based off array key
		let currentFruit = fruitsToGuessShuffled[fruitsToGuessNumber]
		
		// update the label
		wordToGuessLabel.text = currentFruit
	}
	
	// function: check the outcome of the button pressed
	func buttonImageChecker( userGuessedWord: String ) {
		
		// check if the passed string matches the question
		if fruitsToGuessShuffled[fruitsToGuessNumber] == userGuessedWord {
			
			
			// add to the current score
			totalWins += 1
		}
		
		// increment the fruit array number
		fruitsToGuessNumber += 1
	}
	
	// function: reset the game stats for new games
	func newGameReset() {
		
		// set the variables to 0
		totalWins = 0
		totalButtonPresses = 0
		fruitsToGuessNumber = 0
		
		// reset the round
		newRound()
	}
	
	// prepare for the popover
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		// create the variables to pass through
		let currentGameScore = totalWins
		let currentHighScore = highScore
		
		// set the destination view controller
		let gameoverViewController = segue.destination as! GameOverViewController
		
		// pass the variables
		gameoverViewController.currentGameScore = currentGameScore
		gameoverViewController.currentHighScore = currentHighScore
		
	}
	
}
