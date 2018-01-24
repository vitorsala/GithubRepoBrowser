//
//  Localizable.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 24/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

protocol Localizable {
    var localizedString: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localizedString: String {
        return self.rawValue.localized
    }
}
