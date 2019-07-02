//
//  EndpointType.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
