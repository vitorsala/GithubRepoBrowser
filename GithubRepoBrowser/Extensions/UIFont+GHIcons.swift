//
//  UIFont+GHIcons.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 11/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

extension UIFont {
    static func GHIconFont(size: CGFloat) -> UIFont {
        let fontName = "octicons"
        guard let font = UIFont(name: fontName, size: size) else {
            fatalError("\(fontName).ttf is missing!")
        }
        return font
    }
}
