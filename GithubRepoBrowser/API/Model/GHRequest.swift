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

struct GHParams {
    private(set) var params: [String: Any]
    
    init(params: [String: Any] = [:]) {
        self.params = params
    }
    
    mutating func add(key: String, value: Any?) {
        guard let value = value else { return }
        params[key] = value
    }
    
    mutating func add(_ dict: [String: Any]) {
        params.merge(dict) { (_, new) -> Any in new }
    }
}

struct GHRequest {
    let method: Method
    let service: Service
    let parameters: GHParams?
}
