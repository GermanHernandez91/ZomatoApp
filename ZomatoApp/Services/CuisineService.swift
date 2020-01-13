//
//  CuisineService.swift
//  ZomatoApp
//
//  Created by German Hernandez on 13/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation

class CuisineService {
    private let networkManager = NetworkManager.shared
    
    func getCuisines(completed: @escaping (Result<[CuisineElement], ZANetworkError>) -> Void) {
        let endpoint = networkManager.baseURL + "/cuisines"
        
        var params: [String:String] = [:]
        
        params["lat"] = LocationService.shared.getLatitude()
        params["lon"] = LocationService.shared.getLongitude()
        
        networkManager.get(with: endpoint, parameters: params) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let cuisines = try decoder.decode(Cuisines.self, from: data)
                    completed(.success(cuisines.cuisines))
                } catch {
                    completed(.failure(.invalidData))
                }
            case.failure(let error):
                completed(.failure(error))
            }
        }
    }
}
