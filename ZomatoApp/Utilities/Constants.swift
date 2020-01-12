//
//  Constants.swift
//  ZomatoApp
//
//  Created by German Hernandez on 12/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Strings {
        static let postCodePlaceholder = NSLocalizedString("Enter your post code", comment: "Post code placeholder")
        static let locateMeBtn = NSLocalizedString("Locate me", comment: "Locate me button text")
    }
    
    struct Errors {
        static let validationTitle = NSLocalizedString("Oops !", comment: "Validation error")
        static let postCodeValidation = NSLocalizedString("You need to type a postcode 😄", comment: "Post code validation error")
        static let genericTitle = NSLocalizedString("Something went wrong", comment: "Generic error title")
        static let alertDismissTitle = NSLocalizedString("Dismiss", comment: "Generic error alert title")
    }
    
    struct Images {
        static let logoImage = "logo"
    }
    
}


