//
//  FavoritesManagerTests.swift
//  lastFMSampleTests
//
//  Created by Erica Geralde on 02/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//
import XCTest
@testable import lastFMSample

class FavoritesManagerTests: XCTestCase {

    var album1 = Album(name: "album1", artist: "artist1", url: URL(string: "http://www.google.com")!, image: [Image(url: "bla", size: "bla")], listeners: "1232131", mbid: "", isFavorite: nil, tracks: nil, wiki: nil)
    var album2 = Album(name: "album2", artist: "artist1", url: URL(string: "http://www.google.com")!, image: [Image(url: "bla", size: "bla")], listeners: "1232131", mbid: "", isFavorite: nil, tracks: nil, wiki: nil)
    var album3 = Album(name: "album3", artist: "artist1", url: URL(string: "http://www.google.com")!, image: [Image(url: "bla", size: "bla")], listeners: "1232131", mbid: "", isFavorite: nil, tracks: nil, wiki: nil)
    var album4 = Album(name: "album4", artist: "artist1", url: URL(string: "http://www.google.com")!, image: [Image(url: "bla", size: "bla")], listeners: "1232131", mbid: "", isFavorite: nil, tracks: nil, wiki: nil)
    var album5 = Album(name: "album5", artist: "artist1", url: URL(string: "http://www.google.com")!, image: [Image(url: "bla", size: "bla")], listeners: "1232131", mbid: "", isFavorite: nil, tracks: nil, wiki: nil)
    var album6 = Album(name: "album6", artist: "artist1", url: URL(string: "http://www.google.com")!, image: [Image(url: "bla", size: "bla")], listeners: "1232131", mbid: "", isFavorite: nil, tracks: nil, wiki: nil)
    var album7 = Album(name: "album7", artist: "artist1", url: URL(string: "http://www.google.com")!, image: [Image(url: "bla", size: "bla")], listeners: "1232131", mbid: "", isFavorite: nil, tracks: nil, wiki: nil)
    var album8 = Album(name: "album8", artist: "artist1", url: URL(string: "http://www.google.com")!, image: [Image(url: "bla", size: "bla")], listeners: "1232131", mbid: "", isFavorite: nil, tracks: nil, wiki: nil)
    var album9 = Album(name: "album9", artist: "artist1", url: URL(string: "http://www.google.com")!, image: [Image(url: "bla", size: "bla")], listeners: "1232131", mbid: "", isFavorite: nil, tracks: nil, wiki: nil)
    var album10 = Album(name: "album10", artist: "artist1", url: URL(string: "http://www.google.com")!, image: [Image(url: "bla", size: "bla")], listeners: "1232131", mbid: "", isFavorite: nil, tracks: nil, wiki: nil)
    

    var favoritesManager: FavoritesManager!

    override func setUp() {
        self.favoritesManager = FavoritesManager()
    }
    override func tearDown() {
        self.favoritesManager.clearFavorites()
        self.favoritesManager = nil
    }
    func testIfIsFavoriteTrue() {
        self.favoritesManager.saveFavorite(album: album1)
        XCTAssertTrue(self.favoritesManager.checkIsFavorite(album1))
    }

    func testIfIsFavoriteFalse() {
        XCTAssertFalse(self.favoritesManager.checkIsFavorite(album1))
    }

    func testFavoriteRemoved() {
        self.favoritesManager.saveFavorite(album: album1)
        XCTAssertTrue(self.favoritesManager.checkIsFavorite(album1))
        self.favoritesManager.removeFavorite(album1)
        XCTAssertFalse(self.favoritesManager.checkIsFavorite(album1))
    }

    func testFavoriteAdded() {
        self.favoritesManager.saveFavorite(album: album1)
        XCTAssertTrue(self.favoritesManager.checkIsFavorite(album1))
    }

    func testIfFavoritesFull() {
        self.favoritesManager.saveFavorite(album: album1)
        self.favoritesManager.saveFavorite(album: album2)
        self.favoritesManager.saveFavorite(album: album3)
        self.favoritesManager.saveFavorite(album: album4)
        self.favoritesManager.saveFavorite(album: album5)
        self.favoritesManager.saveFavorite(album: album6)
        self.favoritesManager.saveFavorite(album: album7)
        self.favoritesManager.saveFavorite(album: album8)
        self.favoritesManager.saveFavorite(album: album9)
        self.favoritesManager.saveFavorite(album: album10)
        XCTAssertTrue(self.favoritesManager.checkFavoritesIsFull())
    }

    func testGetFavorites() {
        self.favoritesManager.saveFavorite(album: album1)
        XCTAssert((self.favoritesManager.loadFavorites()?.count).orDefault(0) > 0, "error in loading favorites!")
    }

    func testFavoritesCleared() {
        self.favoritesManager.saveFavorite(album: album1)
        self.favoritesManager.clearFavorites()
        XCTAssert(self.favoritesManager.loadFavorites() == nil, "Error in clearing favorites!")
    }
}
