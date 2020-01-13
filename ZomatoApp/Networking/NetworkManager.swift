//
//  NetworkManager.swift
//  ZomatoApp
//
//  Created by German Hernandez on 12/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

enum HTTMethod: String {
    case get = "GET"
}

typealias NetworkResult = (Result<Data, ZANetworkError>) -> Void

class NetworkManager {
    static let shared = NetworkManager()
    
    let baseURL = "https://developers.zomato.com/api/v2.1"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func get(with route: String, parameters: [String: String]?, completed: @escaping NetworkResult) {
        
        guard var url = URL(string: route) else {
           completed(.failure(.genericError))
           return
       }
        
        if let parameters = parameters {
            var queryItems: [URLQueryItem] = []
            
            for (key, value) in parameters {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = queryItems
            
            guard let urlFormatted = urlComponents?.url else {
                completed(.failure(.genericError))
                return
            }
            
            url = urlFormatted
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTMethod.get.rawValue
        request.setValue(Environment.Variables.zomatoApiKey, forHTTPHeaderField: "user-key")
        
        performTask(with: request) { result in
            switch result {
            case .success(let data):
                completed(.success(data))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    private func performTask(with request: URLRequest, completed: @escaping NetworkResult) {
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
            
            completed(.success(data))
        }
        
        task.resume()
    }
}
