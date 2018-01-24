//
//  String+Localization.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 24/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return self.localized(comment: "")
    }
    
    func localized(value: String? = nil, comment: String) -> String {
        return NSLocalizedString(self, value: value ?? "**\(self)**", comment: comment)
    }
}
