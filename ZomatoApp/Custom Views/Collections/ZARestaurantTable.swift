//
//  ZARestaurantTable.swift
//  ZomatoApp
//
//  Created by German Hernandez on 13/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class ZARestaurantTable: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        register(RestaurantCell.self, forCellReuseIdentifier: RestaurantCell.reuseID)
        //contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
}
