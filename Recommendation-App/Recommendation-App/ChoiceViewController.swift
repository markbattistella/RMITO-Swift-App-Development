//
//  ViewController.swift
//  mbRecommendationSystem
//
//  Created by Mark Battistella on 7/4/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController {
    
    // variable: IB
    @IBOutlet var choiceButton1:        UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// do some cosmetic fixes
		choiceButton1.setTitle("Let's begin", for: .normal)
	}
    
	// allow to go back to this view
	@IBAction func unwind(unwindSegue: UIStoryboardSegue){}

}
