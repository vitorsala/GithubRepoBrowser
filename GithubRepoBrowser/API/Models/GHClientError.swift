//
//  GHClientError.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 09/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

enum GHClientError: Error {
    case genericError(description: String)
}

extension GHClientError: Equatable {
    static func ==(lhs: GHClientError, rhs: GHClientError) -> Bool {
        switch (lhs, rhs) {
        case (let .genericError(lDescription), let .genericError(rDescription)):
            return lDescription == rDescription
        }
    }
}
