//
//  LastFMAPI.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

fileprivate let API_KEY = "0ebb88eb4fd97d5eadb931a04e9092f9"

public enum LastFMAPI {
    case searchAlbum(album: String, limit: Int, page: Int)
    case getInfo(album: String, artist: String)
}

extension LastFMAPI: EndpointType {
    var baseURL: URL {
        return URL(string: "https://ws.audioscrobbler.com/2.0")!
        
    }
    
    var path: String {
        return ""
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    
    var headers: [String : String]? {
        return nil
    }
    
    var task: HTTPTask {
        return .requestParameters(bodyParameters: nil, urlParameters: urlParameters)
    }
    
    var urlParameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .searchAlbum(let album, let limit, let page):
            params["method"] = "album.search"
            params["limit"] = limit
            params["page"] = page
            params["album"] = album
        case .getInfo(let album, let artist):
            params["method"] = "album.getinfo"
            params["album"] = album
            params["artist"] = artist
        }
        params["api_key"] = API_KEY
        params["format"] = "json"
        
        return params
        
    }
}
