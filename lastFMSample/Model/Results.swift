//
//  Query.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct Results {
    var searchTerms: String
    var startPage: String
    var totalResults: String
    var startIndex: String
    var itemsPerPage: String
    var album: [Album]
}

extension Results: Codable {
    enum QueryKeys: String, CodingKey {
        case results
        case opensearchQuery = "opensearch:Query"
        enum openSearchQuery: String, CodingKey {
            case searchTerms
            case startPage
        }
        case totalResults = "opensearch:totalResults"
        case startIndex = "opensearch:startIndex"
        case itemsPerPage = "opensearch:itemsPerPage"
        case albummatches
        enum albumMatches: String, CodingKey {
            case album
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QueryKeys.self)
        let resultsContainer = try container.nestedContainer(keyedBy: QueryKeys.self, forKey: .results)
        let openSearchQueryContainer = try resultsContainer.nestedContainer(keyedBy: QueryKeys.openSearchQuery.self, forKey: .opensearchQuery)
        try searchTerms = openSearchQueryContainer.decode(String.self, forKey: .searchTerms)
        try startPage = openSearchQueryContainer.decode(String.self, forKey: .startPage)
        try totalResults = resultsContainer.decode(String.self, forKey: .totalResults)
        try startIndex = resultsContainer.decode(String.self, forKey: .startIndex)
        try itemsPerPage = resultsContainer.decode(String.self, forKey: .itemsPerPage)
        
        let albumContainer = try resultsContainer.nestedContainer(keyedBy: QueryKeys.albumMatches.self, forKey: .albummatches)
        try album = albumContainer.decode([Album].self, forKey: .album)
    }
}
