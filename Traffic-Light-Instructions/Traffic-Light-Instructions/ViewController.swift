//
//  ViewController.swift
//  mbTrafficLightButton
//
//  Created by Mark Battistella on 22/10/19.
//  Copyright © 2019 Mark Battistella. All rights reserved.
//

import UIKit

// create global colours
extension UIColor {
    static let redOff       = UIColor(red: 255/255, green:   0/255, blue: 0/255, alpha: 0.25 )
    static let yellowOff    = UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 0.25 )
    static let greenOff     = UIColor(red:   0/255, green: 255/255, blue: 0/255, alpha: 0.25 )
}

class ViewController: UIViewController {
    
    // set the parameters
    @IBOutlet var redLight          : UIImageView!
    @IBOutlet var yellowLight       : UIImageView!
    @IBOutlet var greenLight        : UIImageView!
    @IBOutlet var informationLabel  : UILabel!
    @IBOutlet var beginButton       : UIButton!
    @IBOutlet var nextButton        : UIButton!
    var colourCounter   = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide the next button on load
        nextButton.isHidden = true
        
        // initiate the colour switcher
        colourSwitcher()
    }

    // when first run
    @IBAction func beginLightCycle(_ sender: Any) {
        // set the colour counter to 1
        colourCounter = 1
        
        // run the colour switcher
        colourSwitcher()
        
        // hide the begin and show the next buttons
        beginButton.isHidden = true
        nextButton.isHidden = false
    }

    // when next button is pressed
    @IBAction func nextNavigation(_ sender: Any) {
        // cycle through only 1-3
        if( colourCounter >= 3 ) {
            // if passing 3, begin at 1 again
            colourCounter = 1;
        } else {
            // otherwise + 1 to counter
            colourCounter += 1
        }
        
        // run the colour switcher
        colourSwitcher()
    }
    
    // pass Int 1-3 and change colours based on that
    // using switch as tester rather than if/else
    func colourSwitcher() {
        
        switch colourCounter {
        case 1:
            // turn red off, turn green on, yellow already off
            redLight.tintColor      = .redOff;
            greenLight.tintColor    = .systemGreen;
            
            informationLabel.text = "Green light means GO"
            informationLabel.backgroundColor = .greenOff
            
        case 2:
            // turn green off, turn yellow on, red already off
            yellowLight.tintColor   = .systemYellow;
            greenLight.tintColor    = .greenOff;
            
            informationLabel.text = "Yellow light means SLOW DOWN"
            informationLabel.backgroundColor = .yellowOff
            
        case 3:
            // turn yellow off, turn red on, green already off
            redLight.tintColor      = .systemRed;
            yellowLight.tintColor   = .yellowOff;
            
            informationLabel.text = "Red light means STOP"
            informationLabel.backgroundColor = .redOff
            
        default:
            // turn all off to start with
            redLight.tintColor    = .redOff;
            yellowLight.tintColor = .yellowOff;
            greenLight.tintColor  = .greenOff;
            informationLabel.text = "";
        }
    }
}
