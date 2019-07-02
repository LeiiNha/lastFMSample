//
//  NetworkManager.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation
struct NetworkManager {

    private let router = Router<LastFMAPI>()

    enum NetworkResponse: String {
        case success
        case badRequest = "bad request"
        case failed = "request failed"
        case noData = "response with no data"
        case unableToDecode = "Could not decode"
        case networkFail = "Check your connection"
    }

    enum Result<String> {
        case success
        case failure(String)
    }

    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func cancel() {
        router.cancel()
    }
    
    func searchAlbum(album: String, limit: Int, page: Int, completion: @escaping(_ albums: [Album]?, _ error: String?) -> Void) {
        
        router.request(.searchAlbum(album: album, limit: limit, page: page), completion: { data, response, error in
            guard error == nil else { completion(nil, "Error in searchAlbum"); return }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else { completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(Results.self, from: responseData)
                        completion(apiResponse.album, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
            
        })
    }
    func getInfo(album: String, artist: String, completion: @escaping(_ album: Album?, _ error: String?) -> Void) {
        
        router.request(.getInfo(album: album.trimmingCharacters(in: .whitespacesAndNewlines), artist: artist.trimmingCharacters(in: .whitespacesAndNewlines)), completion: { data, response, error in
            print("ALBUM: ", album)
            print("artist: ", artist)
            guard error == nil else { completion(nil, "Error in getInfo" ); return }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else { completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let teste = try JSONSerialization.jsonObject(with: responseData, options: [])
                        print(teste)
                        let apiResponse = try JSONDecoder().decode(InfoResults.self, from: responseData)
                        completion(apiResponse.album, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        })
    }

}
