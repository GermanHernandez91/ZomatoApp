//
//  RestaurantListVC.swift
//  ZomatoApp
//
//  Created by German Hernandez on 12/01/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class RestaurantListVC: UIViewController {
    
    enum Section { case main }
    
    // MARK: - Variables
    
    var cuisines: [Cuisine] = []
    var mostPopularLabel = ZAHeadlineLabel(textAlignment: .left, title: "Most Popular")
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Cuisine>!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        configureCellCollectionView()
        configureMostPopularLabel()
        
        getCuisines()
        configureDataSource()
    }
    
    // MARK: - Layout
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureMostPopularLabel() {
        view.addSubview(mostPopularLabel)
        
        NSLayoutConstraint.activate([
            mostPopularLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            mostPopularLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mostPopularLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mostPopularLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func configureCellCollectionView() {
        let flowLayot = UICollectionViewFlowLayout()
        flowLayot.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        flowLayot.itemSize = CGSize(width: view.frame.width / 3, height: 140)
        flowLayot.scrollDirection = .horizontal
        flowLayot.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayot)
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CuisineCell.self, forCellWithReuseIdentifier: CuisineCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    // MARK: - Methods
    
    func getCuisines() {
        showLoadingView()
        
        NetworkManager.shared.getCuisines { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let cuisines):
                for cuisine in cuisines {
                    self.cuisines.append(cuisine.cuisine)
                }
                self.updateData()
            case .failure(let error):
                self.showErrorDialog(title: Constants.Errors.genericTitle, message: error.rawValue)
            }
        }
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Cuisine>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cuisines)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Cuisine>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, cuisine) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CuisineCell.reuseID, for: indexPath) as! CuisineCell
            cell.set(cuisine: cuisine)
            return cell
        })
    }

}

// MARK: - UICollectionViewDelegate

extension RestaurantListVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(cuisines[indexPath.item])
    }
    
}

