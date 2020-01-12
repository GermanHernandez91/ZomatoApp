//
//  ZALocationError.swift
//  ZomatoApp
//
//  Created by German Hernandez on 12/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation

enum ZALocationError: String, Error {
    case invalidLocation = "Unable to get your current location"
    case locationNotFound = "We are unable to find that location. Please try again."
}
