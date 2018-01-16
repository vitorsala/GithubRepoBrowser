//
//  Service.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 09/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

protocol GHService {
    func url() -> URL?
    func string() -> String
}

extension GHService {
    func url() -> URL? {
        return URL(string: self.string())
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
    func string() -> String {
        switch self {
        case .root :
            return "https://api.github.com"
        }
    }
}

extension GHServiceEndpoint.Search: GHService {
    func string() -> String {
        switch self {
        case .repositories:
            return "\(GHServiceEndpoint.root.string())/search/repositories"
        }
    }
}

extension GHServiceEndpoint.Repository: GHService {
    private func common(login: String, name: String) -> String {
        return "\(GHServiceEndpoint.root.string())/repos/\(login)/\(name)"
    }
    
    func string() -> String {
        switch self {
        case let .info(login, name):
            return "\(GHServiceEndpoint.root.string())/repos/\(login)/\(name)"
        case let .pullRequest(login, name):
            return "\(GHServiceEndpoint.Repository.info(login: login, name: name).string())/pulls"
        }
    }
}
