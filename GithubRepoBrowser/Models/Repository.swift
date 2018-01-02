//
//  Repository.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 02/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

struct Repository: Codable {
    let id: Int
    let name: String
    let description: String?
    let stargazersCount: Int
    let forksCount: Int
    let owner: User
}
