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
    
    let cuisineService: CuisineService = CuisineService()
    let restaurantService: RestaurantService = RestaurantService()
    
    var restaurants: [Restaurant] = []
    var cuisines: [Cuisine] = []
    var mostPopularLabel = ZAHeadlineLabel(textAlignment: .left, title: "Most Popular")
    var cuisineLabel = ZAHeadlineLabel(textAlignment: .left, title: "Cuisines")
    var collectionView: ZACuisineCollection!
    var tableView: UITableView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Cuisine>!
    var dataTableSource: UITableViewDiffableDataSource<Section, Restaurant>!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        configureCuisineLabel()
        configureCellCollectionView()
        configureMostPopularLabel()
        configureCellTableView()
        
        getCuisines()
        configureDataSource()
        configureTableDataSource()
    }
    
    // MARK: - Layout
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCuisineLabel() {
        view.addSubview(cuisineLabel)
        
        NSLayoutConstraint.activate([
            cuisineLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cuisineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cuisineLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cuisineLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configureMostPopularLabel() {
        view.addSubview(mostPopularLabel)
        
        NSLayoutConstraint.activate([
            mostPopularLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            mostPopularLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mostPopularLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mostPopularLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func configureCellCollectionView() {
        collectionView = ZACuisineCollection(frame: .zero, collectionViewLayout: UIHelper.generateCollectionCellHorizontalCell(in: view))
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: cuisineLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func configureCellTableView() {
        tableView = ZARestaurantTable(frame: .zero, style: .plain)
        
        view.addSubview(tableView)
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: mostPopularLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    // MARK: - Methods
    
    func getCuisines() {
        showLoadingView()
        
        cuisineService.getCuisines { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let cuisines):
                for cuisine in cuisines {
                    self.cuisines.append(cuisine.cuisine)
                }
                self.updateData()
                self.getRestaurants()
            case .failure(let error):
                self.showErrorDialog(title: Constants.Errors.genericTitle, message: error.rawValue)
            }
        }
    }
    
    func getRestaurants() {
        restaurantService.getRestaurantsByCity(limit: 10) { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let collections):
                for restaurant in collections {
                    self.restaurants.append(restaurant.collection)
                }
                self.updateTableData()
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
    
    func updateTableData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.main])
        snapshot.appendItems(restaurants)
        DispatchQueue.main.async { self.dataTableSource.apply(snapshot, animatingDifferences: true) }
    }
    
    func configureTableDataSource() {
        dataTableSource = UITableViewDiffableDataSource<Section, Restaurant>(tableView: tableView, cellProvider: { (tableView, indexPath, restaurant) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantCell.reuseID, for: indexPath) as! RestaurantCell
            cell.set(restaurant: restaurant)
            return cell
        })
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

// MARK: - UITableViewDelegate

extension RestaurantListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
}
