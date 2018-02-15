//
//  GHClientRouter.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 15/02/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

final class GHClientRouter {
    static var apiClient: GHClient {
        return GHClientAF()
    }
}
