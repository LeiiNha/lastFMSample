//
//  AlbumResultViewModel.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit

protocol AlbumResultDelegate: class {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String, _ completion: @escaping () -> Void)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, viewController: UIViewController)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath, _ completion: @escaping () -> Void)
    func numberOfSections(in tableView: UITableView) -> Int
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
}

final class AlbumResultViewModel {
    private(set) var albumResults: [Album]?
    private(set) var lastResultPage: Int?
    let networkManager: NetworkManager
    let favoritesManager: FavoritesManagerProtocol
    private(set) var isRequesting: Bool = false
    private(set) var albumSearchText: String?
    
    private enum Constants {
        static let pageLimit: Int = 20
        static let firstPage: Int = 1
    }
    
    init(favoritesManager: FavoritesManagerProtocol) {
        self.favoritesManager = favoritesManager
        self.networkManager = NetworkManager()
    }
    
    private func getAlbumDetails(album: String, artist: String, _ completion: @escaping (Album) -> Void) {
        self.isRequesting = true
        networkManager.getInfo(album: album, artist: artist, completion:  { album, _ in
            self.isRequesting = false
            guard let album = album else { return }
            completion(album)
        })
    }

    private func downloadImage(from url: URL, completion: @escaping (UIImage?)  -> ()) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                completion(UIImage(data: data))
            }
        }
    }

    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

extension AlbumResultViewModel: AlbumResultDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath, _ completion: @escaping () -> Void) {
        if let count = self.albumResults?.count, indexPath.row == count - 1 {
            guard let albumSearchText = self.albumSearchText else { return }
            self.isRequesting = true
            networkManager.searchAlbum(album: albumSearchText, limit: Constants.pageLimit, page: self.lastResultPage.orDefault(Constants.firstPage)+1, completion: { album, _ in
                self.isRequesting = false
                guard let album = album else { return }
                self.albumResults?.append(contentsOf: album)
                self.lastResultPage = self.lastResultPage.orDefault(Constants.firstPage) + 1
                completion()
            })
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.reuseIdentifier, for: indexPath) as? AlbumTableViewCell
            else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.name = self.albumResults?[indexPath.row].name
        if let imageUrl = self.albumResults?[indexPath.row].image.first?.url, let url = URL(string: imageUrl) {
            downloadImage(from: url, completion: { image in
                cell.albumImage = image
            })
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.albumResults?.count).orDefault(0)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String, _ completion: @escaping () -> Void) {
        if self.isRequesting { networkManager.cancel()}
        self.isRequesting = true
        self.albumSearchText = searchText
        networkManager.searchAlbum(album: searchText, limit: Constants.pageLimit, page: Constants.firstPage, completion: { albuns, _ in
            self.isRequesting = false
            guard let albuns = albuns else { print("no albuns found"); return }
            self.lastResultPage = Constants.firstPage
            self.albumResults = albuns
            completion()
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, viewController: UIViewController) {
        guard let selectedAlbum = self.albumResults?[indexPath.row] else { return }
        self.getAlbumDetails(album: selectedAlbum.name, artist: selectedAlbum.artist) { album in
            let viewModel = AlbumDetailViewModel(album: selectedAlbum, favoritesManager: self.favoritesManager)
            let detailPage = AlbumDetailViewController(viewModel: viewModel)
            DispatchQueue.main.async {
             viewController.navigationController?.pushViewController(detailPage, animated: true)
            }
        }
    }
}
