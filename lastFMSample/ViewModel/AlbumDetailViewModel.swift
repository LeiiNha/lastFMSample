//
//  AlbumDetailViewModel.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit

protocol AlbumDetailDelegate: class {
    func handleBtnPress(_ sender: UIButton)
}
final class AlbumDetailViewModel {
    let album: Album
    let favoritesManager: FavoritesManagerProtocol
    
    private(set) var favoriteAlbums: [Album]?
    
    init(album: Album,
         favoritesManager: FavoritesManagerProtocol) {
        self.album = album
        self.favoritesManager = favoritesManager
        self.favoriteAlbums = self.favoritesManager.loadFavorites()
    }
}

extension AlbumDetailViewModel {
    
    func getTextForAlbum() -> String {

        return String(format: "Name: %@\n Tracks count: %@\n Publish Date: %@\n Artist(s) Name:%@\n Artist(s) Listener: %@", self.album.name, (self.album.tracks?.count.description).orDefault("0"), (self.album.wiki?.published).orDefault("No date found"), self.album.artist, self.album.listeners.orDefault("data not found"))
    }
    
    func getImageForAlbum() -> UIImage? {
        if self.favoritesManager.checkIsFavorite(self.album) {
            return Images.likeFilled
        }
        return Images.like
    }
}

extension AlbumDetailViewModel: AlbumDetailDelegate {
    func handleBtnPress(_ sender: UIButton) {
        if sender.currentImage == Images.like {
            self.favoritesManager.saveFavorite(album: self.album)
        } else {
            self.favoritesManager.removeFavorite(self.album)
        }
    }
}
