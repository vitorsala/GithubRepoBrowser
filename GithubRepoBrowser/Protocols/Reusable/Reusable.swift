//
//  Reusable.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 15/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

protocol Reusable: class {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String {
        let className = String(describing: self)
        return className
    }
}
