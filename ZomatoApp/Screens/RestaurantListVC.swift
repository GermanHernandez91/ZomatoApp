//
//  RestaurantListVC.swift
//  ZomatoApp
//
//  Created by German Hernandez on 12/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class RestaurantListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        getCuisines()
    }
    
    // MARK: - Layout
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Methods
    
    func getCuisines() {
        
        showLoadingView()
        
        NetworkManager.shared.getCuisines { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let cuisines):
                print("Cuisines => \(cuisines)")
            case .failure(let error):
                self.showErrorDialog(title: Constants.Errors.genericTitle, message: error.rawValue)
            }
        }
        
    }

}

