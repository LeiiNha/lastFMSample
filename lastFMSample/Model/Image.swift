//
//  Image.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct Image {
    var url: String
    var size: String
}

extension Image: Codable {
    enum ImageKeys: String, CodingKey {
        case url = "#text"
        case size
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageKeys.self)
        try url = container.decode(String.self, forKey: .url)
        try size = container.decode(String.self, forKey: .size)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ImageKeys.self)
        try container.encode(url, forKey: .url)
        try container.encode(size, forKey: .size)
    }
}
