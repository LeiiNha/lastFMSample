//
//  Album.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct Album {
    var name: String
    var artist: String
    var url: URL
    var image: [Image]
    var listeners: String?
    var mbid: String?
    var isFavorite: Bool?
    var tracks: [Track]?
    var wiki: Wiki?
}

extension Album: Equatable {
    static func ==(lhs:Album, rhs:Album) -> Bool { // Implement Equatable
        return lhs.name == rhs.name
    }
}

extension Album: Codable {
    enum AlbumKeys: String, CodingKey {
        case name
        case artist
        case url
        case image
        case listeners
        case mbid
        case isFavorite
        case tracks
        enum trackKey: String, CodingKey {
            case track
        }
        case wiki
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        url = try container.decode(URL.self, forKey: .url)
        image = try container.decode([Image].self, forKey: .image)
        listeners = try container.decodeIfPresent(String.self, forKey: .listeners)
        mbid = try container.decodeIfPresent(String.self, forKey: .mbid)
        isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
        do {
            let tracksContainer = try container.nestedContainer(keyedBy: AlbumKeys.trackKey.self, forKey: .tracks)
            tracks = try tracksContainer.decode([Track].self, forKey: .track)
        } catch {
            print("Album with no tracks")
        }
        wiki = try container.decodeIfPresent(Wiki.self, forKey: .wiki)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        try container.encode(url, forKey: .url)
        try container.encode(image, forKey: .image)
        try container.encode(listeners, forKey: .listeners)
        try container.encode(mbid, forKey: .mbid)
        try container.encode(isFavorite, forKey: .isFavorite)
        try container.encode(tracks, forKey: .tracks)
        try container.encode(wiki, forKey: .wiki)
    }
    
    
}
