//
//  GHParams.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 17/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

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
