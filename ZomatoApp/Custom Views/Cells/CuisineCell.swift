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
        
        backgroundColor = .systemBlue
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 2.0
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        NSLayoutConstraint.activate([
            cuisineLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cuisineLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cuisineLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
}
