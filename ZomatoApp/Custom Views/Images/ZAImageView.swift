//
//  ZAImageView.swift
//  ZomatoApp
//
//  Created by German on 13/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class ZAImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(imageName: String) {
        super.init(frame: .zero)
        
        self.image = UIImage(named: imageName)
        
        configure()
    }
    
    private func configure() {
        clipsToBounds = true
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 2.0
    }

}
