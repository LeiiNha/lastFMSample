//
//  AlbumInfo.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct AlbumInfo {
    var tracks: [Track]
    var wiki: Wiki?
    var tags: [Tag]
}

extension AlbumInfo: Codable {
    enum AlbumInfoKeys: String, CodingKey {
        case tracks
        enum trackKey: String, CodingKey {
            case track
        }
        case wiki
        case tags
        enum tagKey: String, CodingKey {
            case tag
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumInfoKeys.self)
        let tracksContainer = try container.nestedContainer(keyedBy: AlbumInfoKeys.trackKey.self, forKey: .tracks)
        tracks = try tracksContainer.decode([Track].self, forKey: .track)
        wiki = try container.decodeIfPresent(Wiki.self, forKey: .wiki)
        let tagContainer = try container.nestedContainer(keyedBy: AlbumInfoKeys.tagKey.self, forKey: .tags)
        tags = try tagContainer.decode([Tag].self, forKey: .tag)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumInfoKeys.self)
        try container.encode(tracks, forKey: .tracks)
        try container.encode(wiki, forKey: .wiki)
        try container.encode(tags, forKey: .tags)
    }
}
