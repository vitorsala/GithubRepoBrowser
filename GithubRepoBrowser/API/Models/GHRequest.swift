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

struct GHRequest {
    let method: Method
    let service: GHService
    let parameters: GHParams?
}
