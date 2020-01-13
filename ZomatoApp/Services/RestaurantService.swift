//
//  RestaurantService.swift
//  ZomatoApp
//
//  Created by German Hernandez on 13/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation

class RestaurantService {
    private let networkManager = NetworkManager.shared
    
    func getRestaurantsByCity(limit: Int, completed: @escaping (Result<[CollectionElement], ZANetworkError>) -> Void) {
        let endpoint = networkManager.baseURL + "/collections"
        
        var params: [String:String] = [:]
        
        params["lat"] = LocationService.shared.getLatitude()
        params["lon"] = LocationService.shared.getLongitude()
        params["count"] = String(limit)
        
        networkManager.get(with: endpoint, parameters: params) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let restaurants = try decoder.decode(Collection.self, from: data)
                    completed(.success(restaurants.collections))
                } catch {
                    print(error)
                    completed(.failure(.invalidData))
                }
            case.failure(let error):
                completed(.failure(error))
            }
        }
    }
}
