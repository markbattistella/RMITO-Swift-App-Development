//
//  MovieQuestionData.swift
//  mbRecommendationSystem
//
//  Created by Mark Battistella on 8/4/20.
//  Copyright © 2020 Mark Battistella. All rights reserved.
//

import UIKit





//
enum MovieCriteria: String, CaseIterable {
    case decade, genres
}

struct Movie {
	var title: String
	var year: Int
	var decade: String
	var rating: Int
	var genres: [String]
	var service: [String]
}




let movieListArray: Array = [
	[
			"title":	"The Mask",
			"year":		1994,
			"decade":	"1990s",
			"rating":	7.4,
			"genres":	["Comedy"],
			"service":	["Foxtel"]
	],
		
	[
			"title":	"Serendipity",
			"year":		2001,
			"decade":	"2000s",
			"rating":	6.0,
			"genres":	["Romance"],
			"service":	["Foxtel"]
	],
		
	[
			"title":	"The Evil Dead",
			"year":		1980,
			"decade":	"1980s",
			"rating":	7.8,
			"genres":	["Horror"],
			"service":	["Youtube"]
	],
		
	[
			"title":	"Looper",
			"year":		2012,
			"decade":	"2010s",
			"rating":	8.9,
			"genres":	["Sci-Fi"],
			"service":	["Netflix"]
	]
		
]
