//
//  mbShuffle.swift
//  mbRecommendation
//
//  Created by Mark Battistella on 12/4/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import Foundation

func shuffleMovieQuestion( stringArray:[MovieQuestion]) -> [MovieQuestion] {

    // create a copy of the input array
    var items = stringArray

    // our new shuffled array
    var shuffled = [MovieQuestion]();

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



func shuffleMovieAnswer( stringArray:[MovieAnswer]) -> [MovieAnswer] {

    // create a copy of the input array
    var items = stringArray

    // our new shuffled array
    var shuffled = [MovieAnswer]();

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






func shuffleSnackQuestion( stringArray:[SnackQuestion]) -> [SnackQuestion] {

    // create a copy of the input array
    var items = stringArray

    // our new shuffled array
    var shuffled = [SnackQuestion]();

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



func shuffleSnackAnswer( stringArray:[SnackAnswer]) -> [SnackAnswer] {

    // create a copy of the input array
    var items = stringArray

    // our new shuffled array
    var shuffled = [SnackAnswer]();

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
