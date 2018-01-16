//
//  License.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 09/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

struct License: GHModel {
    let key: String
    let name: String
    let spdx_id: String?
    let url: String?
}
