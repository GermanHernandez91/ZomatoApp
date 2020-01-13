//
//  ZACuisineCollection.swift
//  ZomatoApp
//
//  Created by German Hernandez on 13/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class ZACuisineCollection: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        showsHorizontalScrollIndicator = false
        register(CuisineCell.self, forCellWithReuseIdentifier: CuisineCell.reuseID)
    }

}
