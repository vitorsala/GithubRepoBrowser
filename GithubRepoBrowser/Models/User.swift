//
//  User.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 02/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

struct User: GHModel {
    let id: Int
    let login: String
    let avatar_url: String?
    let url: String
}
