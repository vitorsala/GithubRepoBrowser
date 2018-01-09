//
//  Service.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 09/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

enum GHService: String {
    case root = "https://api.github.com/"
    case userSearch = "https://api.github.com/search/"
    case repositoryList = "https://api.github.com/search/repositories"
}
