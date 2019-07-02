//
//  Wiki.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct Wiki {
    var published: String
    var summary: String
    var content: String
}
extension Wiki: Codable {
    enum WikiKeys: String, CodingKey {
        case published
        case summary
        case content
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WikiKeys.self)
        published = try container.decode(String.self, forKey: .published)
        summary = try container.decode(String.self, forKey: .summary)
        content = try container.decode(String.self, forKey: .content)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: WikiKeys.self)
        try container.encode(published, forKey: .published)
        try container.encode(summary, forKey: .summary)
        try container.encode(content, forKey: .content)
    }
    
}
