//
//  RestaurantCell.swift
//  ZomatoApp
//
//  Created by German Hernandez on 13/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {
    static let reuseID = "RestaurantCell"

    let restaurantImage = ZANetworkImage(frame: .zero)
    let restaurantTitle = ZATitleLabel(textAlignment: .left, fontSize: 20)
    let restaurantDesc = ZABodyLabel(textAlignment: .left, fontSize: 16)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    func set(restaurant: Restaurant) {
        restaurantTitle.text = restaurant.title
        restaurantDesc.text = restaurant.description
        restaurantImage.downloadImage(from: restaurant.imageUrl)
    }
    
    private func configure() {
        // addSubview(restaurantImage)
        // addSubview(restaurantTitle)
        // addSubview(restaurantDesc)
        
        // let padding: CGFloat = 8
        
        backgroundView = restaurantImage
        
        NSLayoutConstraint.activate([
//            restaurantImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
//            restaurantImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
//            restaurantImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
//            restaurantImage.heightAnchor.constraint(equalTo: restaurantImage.widthAnchor),
            
//            restaurantTitle.topAnchor.constraint(equalTo: restaurantImage.bottomAnchor, constant: 12),
//            restaurantTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
//            restaurantTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
//            restaurantTitle.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
