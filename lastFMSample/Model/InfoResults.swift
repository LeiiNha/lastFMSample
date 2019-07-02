//
//  InfoResults.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct InfoResults {
    var album: Album
}

extension InfoResults: Codable {
    enum InfoResultsKeys: String, CodingKey {
        case album
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: InfoResultsKeys.self)
        try album = container.decode(Album.self, forKey: .album)
        
    }
}
