//
//  UIHelper.swift
//  ZomatoApp
//
//  Created by German on 13/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

struct UIHelper {
    
    static func generateCollectionCellHorizontalCell(in view: UIView) -> UICollectionViewFlowLayout {
        let flowLayot = UICollectionViewFlowLayout()
        
        flowLayot.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        flowLayot.itemSize = CGSize(width: view.frame.width / 3, height: 120)
        flowLayot.scrollDirection = .horizontal
        flowLayot.minimumLineSpacing = 10
        
        return flowLayot
    }
    
}
