//
//  NetworkManager.swift
//  ZomatoApp
//
//  Created by German Hernandez on 12/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://developers.zomato.com/api/v2.1"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getCuisines(completed: @escaping (Result<[CuisineElement], ZANetworkError>) -> Void) {
        let lat = LocationService.shared.getLatitude()
        let lon = LocationService.shared.getLongitude()
        
        guard let latitude = lat else {
            completed(.failure(.invalidData))
            return
        }
        
        guard let longitude = lon else {
            completed(.failure(.invalidData))
            return
        }
        
        let endpoint = baseURL + "/cuisines?lat=\(latitude)&lon=\(longitude)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.genericError))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(Environment.Variables.zomatoApiKey, forHTTPHeaderField: "user-key")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let cuisines = try decoder.decode(Cuisines.self, from: data)
                completed(.success(cuisines.cuisines))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
