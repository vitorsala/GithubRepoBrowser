//
//  PullRequest.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 15/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

struct PullRequest: GHModel {
    let url: String
    let id: Int
    let html_url: String
    let number: Int
    let state: String
    let locked: Bool
    let title: String
    let user: User
    let body: String
    let created_at: Date
    let commits_url: String
}
