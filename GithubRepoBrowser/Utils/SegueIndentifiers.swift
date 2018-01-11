//
//  SegueIndentifiers.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 11/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

enum SegueIdentifiers: String {
    case showPRList
}

extension SegueIdentifiers {
    var string: String {
        return self.rawValue
    }
}
