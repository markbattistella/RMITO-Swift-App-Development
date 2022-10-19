//
//  ShuffleFunction.swift
//  mbPictureMatch
//
//  Created by Mark Battistella on 13/2/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import Foundation

func shuffleArray( stringArray:[String]) -> [String] {

    // create a copy of the input array
    var items = stringArray

    // our new shuffled array
    var shuffled = [String]();

    // iterate through the item array
    for _ in items.enumerated() {
    
        // choose random number
        let rand = Int( arc4random_uniform( UInt32( items.count ) ) )
        
        // using that random number, select a random item
        let randomItem = items[rand]
        
        // append that random item to our new shuffled array
        shuffled.append( randomItem )
        
        // make sure to remove that item from the original array
        items.remove( at: rand )
        
    }

    return shuffled
}
