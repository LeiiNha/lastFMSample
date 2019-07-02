//
//  FavoritesManager.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

protocol FavoritesManagerProtocol {
    func loadFavorites() -> [Album]?
    func saveFavorite(album: Album)
    func removeFavorite(_ album: Album)
    func checkIsFavorite(_ album: Album) -> Bool
    func checkFavoritesIsFull() -> Bool
    func clearFavorites()
}

struct FavoritesManager: FavoritesManagerProtocol {
    private enum Constants {
        static let maximumFavorites = 10
        static let favoritesKey = "SavedFavorites"
    }
    
    func loadFavorites() -> [Album]? {
        if let savedFavorites = UserDefaults.standard.object(forKey: Constants.favoritesKey) as? Data {
            if let loadedFavorites = try? JSONDecoder().decode([Album].self, from: savedFavorites) {
                return loadedFavorites
            }
        }
        return nil
    }
    
    func saveFavorite(album: Album) {
        var loadedFavorites: [Album] = self.loadFavorites().orDefault([])
        guard !checkFavoritesIsFull(), !checkIsFavorite(album) else { return }
        loadedFavorites.append(album)
        if let encoded = try? JSONEncoder().encode(loadedFavorites) {
            UserDefaults.standard.set(encoded, forKey: Constants.favoritesKey)
        }
    }
    
    func removeFavorite(_ album: Album) {
        if var loadedFavorites = self.loadFavorites() {
            loadedFavorites.removeAll(where: { $0 == album })
            if let encoded = try? JSONEncoder().encode(loadedFavorites) {
                UserDefaults.standard.set(encoded, forKey: Constants.favoritesKey)
            }
        }
    }
    
    func checkIsFavorite(_ album: Album) -> Bool {
        if let favorites = self.loadFavorites(), favorites.contains(where: {$0 == album}) {
            return true
        }
        return false
    }
    
    func checkFavoritesIsFull() -> Bool {
        if let favorites = self.loadFavorites(), favorites.count >= Constants.maximumFavorites {
            return true
        }
        return false
    }
    
    func clearFavorites() {
        UserDefaults.standard.removeObject(forKey: Constants.favoritesKey)
    }
}

extension Optional {
    func orDefault(_ defaultExpression: @autoclosure () -> Wrapped) -> Wrapped {
        guard let value = self else {
            return defaultExpression()
        }
        return value
    }
}
