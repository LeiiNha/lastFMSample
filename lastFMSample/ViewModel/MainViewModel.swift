//
//  MainViewModel.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit

protocol MainViewModelDelegate: class {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar, viewController: UIViewController)
    func numberOfSections(in tableView: UITableView) -> Int
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

final class MainViewModel {
    private(set) var favoritesTableView: UITableView?
    private(set) var resultsTableView: UITableView?
    private(set) var albumResults: [Album]?
    private(set) var favoriteAlbums: [Album]?
    private let favoritesManager = FavoritesManager()
    
    init() {
        self.favoriteAlbums = self.favoritesManager.loadFavorites()
    }
    
}

extension MainViewModel: MainViewModelDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar, viewController: UIViewController) {
        let resultsViewModel = AlbumResultViewModel(favoritesManager: self.favoritesManager)
        let results = AlbumResultsTableViewController(style: .grouped, viewModel: resultsViewModel)
        searchBar.resignFirstResponder()
        viewController.navigationController?.pushViewController(results, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.favoriteAlbums?.count).orDefault(0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.reuseIdentifier, for: indexPath) as? AlbumTableViewCell
            else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.name = self.favoriteAlbums?[indexPath.row].name
        
        return cell
    }
}
