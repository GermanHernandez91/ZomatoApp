//
//  LocationService.swift
//  ZomatoApp
//
//  Created by German Hernandez on 12/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService {
    static let shared = LocationService()
    
    private init() {}
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private let defaults = UserDefaults.standard
    
    func requestLocationPermissions() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func getLatitude() -> String? {
        return defaults.string(forKey: Keys.latitude)
    }
    
    func getLongitude() -> String? {
        return defaults.string(forKey: Keys.longitude)
    }
    
    func locationIsStored() -> Bool {
        return defaults.string(forKey: Keys.city) != nil ? true : false
    }
    
    func getLocationByPostCode(with postCode: String, completed: @escaping(Result<String, ZALocationError>) -> Void) {
        if CLLocationManager.locationServicesEnabled() {
            geocoder.geocodeAddressString(postCode) { placemarks, error in
                if let _ = error { completed(.failure(.invalidLocation)) }
                
                guard let placemarks = placemarks else {
                    completed(.failure(.invalidLocation))
                    return
                }
                
                guard let location = placemarks.first?.location, let city = placemarks.first?.locality else {
                    completed(.failure(.locationNotFound))
                    return
                }
                
                self.defaults.set(location.coordinate.latitude, forKey: Keys.latitude)
                self.defaults.set(location.coordinate.longitude, forKey: Keys.longitude)
                self.defaults.set(city, forKey: Keys.city)
                
                completed(.success(city))
            }
        }
    }
    
}
