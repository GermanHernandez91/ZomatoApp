//
//  OnboardingVC.swift
//  ZomatoApp
//
//  Created by German Hernandez on 12/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit
import CoreLocation

class OnboardingVC: UIViewController {
    
    // MARK: - Variables
    
    let geocoder = CLGeocoder()
    let locationManager = CLLocationManager()
    
    var logoImageView = ZALogoView(frame: .zero)
    var postcodeTextField = ZATextField(placeholder: Constants.Strings.postCodePlaceholder, returnKeyType: .done)
    var locationButton = ZAButton(title: Constants.Strings.locateMeBtn)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationService.shared.requestLocationPermissions()
        setupUI()
        dismissKeyboardTapGesture()
        
        // Testing purposes
        postcodeTextField.text = "EH112AU"
    }
    
    // MARK: - Layout configuration
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        configureLogo()
        configurePostCodeField()
        configureLocateMeButton()
    }
    
    func configureLogo() {
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 250),
            logoImageView.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    func configurePostCodeField() {
        view.addSubview(postcodeTextField)
        
        NSLayoutConstraint.activate([
            postcodeTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            postcodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            postcodeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            postcodeTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configureLocateMeButton() {
        view.addSubview(locationButton)
        
        locationButton.addTarget(self, action: #selector(locationButtonClicked), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: postcodeTextField.bottomAnchor, constant: 20),
            locationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            locationButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
    // MARK: - Methods
    
    @objc func locationButtonClicked() {
        showLoadingView()
        
        guard let postCode = postcodeTextField.text, !postCode.isEmpty else {
            showErrorDialog(title: Constants.Errors.validationTitle, message: Constants.Errors.postCodeValidation)
            return
        }
        
        LocationService.shared.getLocationByPostCode(with: postCode) { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(_):
                self.navigateAway()
            case .failure(let error):
                self.showErrorDialog( title: Constants.Errors.genericTitle, message: error.rawValue)
            }
        }
    }
    
    func navigateAway() {
        let destVC = TestVC()
        destVC.modalPresentationStyle = .fullScreen
        present(destVC, animated: true)
    }

}
