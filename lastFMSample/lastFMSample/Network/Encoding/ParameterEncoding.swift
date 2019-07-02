//
//  ParameterEncoding.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation
public typealias Parameters = [String: Any]

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
