//
//  ViewController.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit
final class ViewController: UIViewController {
    
    private(set) var searchBar: SearchBar?
    private(set) var resultsTableView: UITableView?
    private(set) var mainViewModel: MainViewModel
    
    private enum Constants {
        static let mapZoomDefault: Float = 13.2
    }
    
    init(viewModel: MainViewModel) {
        self.mainViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        self.view.backgroundColor = UIColor.white
    }
    override func viewDidLayoutSubviews() {
        self.resultsTableView?.reloadData()
    }
}

private extension ViewController {
    
    func configureViews() {
        configureSearchBar()
        configureFavoritesTableView()
    }
    
    func configureSearchBar() {
        searchBar = SearchBar(delegate: self)
        guard let searchBar = searchBar else { return }
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchBar)
        searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                       constant: Spacing.large).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func configureFavoritesTableView() {
        guard self.mainViewModel.favoriteAlbums != nil else { return }
        
        let favoritesTableView = UITableView(frame: CGRect.zero, style: .grouped)
        favoritesTableView.register(AlbumTableViewCell.self,
                                    forCellReuseIdentifier: AlbumTableViewCell.reuseIdentifier)
        self.view.addSubview(favoritesTableView)
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.mainViewModel.searchBarTextDidBeginEditing(searchBar, viewController: self)
    }
}

extension ViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.mainViewModel.numberOfSections(in: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.mainViewModel.tableView(tableView, heightForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DidSelect")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainViewModel.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.mainViewModel.tableView(tableView, cellForRowAt: indexPath)
    }
}

