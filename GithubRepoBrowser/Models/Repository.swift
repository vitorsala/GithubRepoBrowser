//
//  Repository.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 02/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

struct RepositoryList: GHModel {
    let total_count: Int
    let incomplete_results: Bool
    let items: [Repository]
}

struct Repository: GHModel {
    let id: Int
    let name: String
    let description: String?
    let created_at: Date
    let updated_at: Date
    let url: String
    let stargazers_count: Int
    let forks_count: Int
    let owner: User
    let license: License?
}
