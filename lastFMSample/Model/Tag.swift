//
//  Tag.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct Tag {
    var name: String
    var url: URL
    
}
extension Tag: Codable {
    enum TagKeys: String, CodingKey {
        case name
        case url
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TagKeys.self)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(URL.self, forKey: .url)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TagKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(url, forKey: .url)
    }
    
}
