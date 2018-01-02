//
//  GHRequest.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 02/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

enum Method {
    case get
    case post
}

enum Service: String {
    case userSearch = "https://api.github.com/search/"
    case repositoryList = "https://api.github.com/search/repositories"
}

struct GHRequest {
    let method: Method
    let service: Service
    let parameters: [String: Any]?
}
