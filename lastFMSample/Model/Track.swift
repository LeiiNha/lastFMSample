//
//  Track.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct Track {
    var name: String
    var duration: String
}

extension Track: Codable {
    enum TrackKeys: String, CodingKey {
        case name
        case duration
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TrackKeys.self)
        name = try container.decode(String.self, forKey: .name)
        duration = try container.decode(String.self, forKey: .duration)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TrackKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(duration, forKey: .duration)
    }
    
}
