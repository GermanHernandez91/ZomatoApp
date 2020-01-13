//
//  CuisineCell.swift
//  ZomatoApp
//
//  Created by German Hernandez on 12/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class CuisineCell: UICollectionViewCell {
    static let reuseID = "CuisineCell"
    
    let cuisineLabel = ZATitleLabel(textAlignment: .center, fontSize: 16)
    let imageView = ZAImageView(imageName: "gradient")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(cuisine: Cuisine) {
        cuisineLabel.text = cuisine.cuisineName.uppercased()
    }
    
    private func configure() {
        addSubview(cuisineLabel)
        
        backgroundView = imageView
    
        NSLayoutConstraint.activate([
            cuisineLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cuisineLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cuisineLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
}
