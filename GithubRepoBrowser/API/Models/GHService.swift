//
//  Service.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 09/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

protocol GHService {
    var url: URL { get }
    var string: String { get }
}

extension GHService {
    var url: URL {
        guard let url = URL(string: self.string) else {
            fatalError("Invalid URL String \(self.string)")
        }
        return url
    }
}

enum GHServiceEndpoint {
    case root
    
    enum Search {
        case repositories
    }
    
    enum Repository {
        case info(login: String, name: String)
        case pullRequest(login: String, name: String)
    }
}

extension GHServiceEndpoint: GHService {
    var string: String {
        switch self {
        case .root :
            return "https://api.github.com"
        }
    }
}

extension GHServiceEndpoint.Search: GHService {
    var string: String {
        switch self {
        case .repositories:
            return "\(GHServiceEndpoint.root.string)/search/repositories"
        }
    }
}

extension GHServiceEndpoint.Repository: GHService {
    var string: String {
        switch self {
        case let .info(login, name):
            return "\(GHServiceEndpoint.root.string)/repos/\(login)/\(name)"
        case let .pullRequest(login, name):
            return "\(GHServiceEndpoint.Repository.info(login: login, name: name).string)/pulls"
        }
    }
}
