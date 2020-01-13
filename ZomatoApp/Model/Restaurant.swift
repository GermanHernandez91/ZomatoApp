//
//  Restaurant.swift
//  ZomatoApp
//
//  Created by German Hernandez on 13/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation

struct Collection: Codable {
    let collections: [CollectionElement]
    let hasMore: Int
    let hasTotal: Int
}

struct CollectionElement: Codable {
    let collection: Restaurant
}

struct Restaurant: Codable, Hashable {
    let collectionId, resCount: Int
    let imageUrl: String
    let url: String
    let title, description: String
}
