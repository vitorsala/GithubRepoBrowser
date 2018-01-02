//
//  GHReposityListService.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 02/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

class GHReposityListService {
    private let client: GHClient
    
    init(client: GHClient = GHClientImpl()) {
        self.client = client
    }
}
