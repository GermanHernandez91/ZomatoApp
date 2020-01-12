//
//  Cuisine.swift
//  ZomatoApp
//
//  Created by German Hernandez on 12/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation

struct Cuisines: Codable {
    let cuisines: [CuisineElement]
}

struct CuisineElement: Codable {
    let cuisine: Cuisine
}

struct Cuisine: Codable {
    let cuisineId: Int
    let cuisineName: String
}
