//
//  NetworkError.swift
//  lastFMSample
//
//  Created by Erica Geraldes on 01/07/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Encoding parameters went wrong"
    case missingUrl = "Url is missing"
    case failedBuildRequest = "There was an issue building request"
}
