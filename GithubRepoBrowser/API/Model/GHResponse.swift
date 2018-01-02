//
//  GHResponse.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 02/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

struct GHResponse {
    let code: Int
    let data: Any?
    let error: Error?
}
