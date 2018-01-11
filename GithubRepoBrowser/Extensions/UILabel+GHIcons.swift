//
//  UILabel+GHIcons.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 11/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

extension UILabel {
    func setIcon(icon: GHIcons, size: CGFloat = 20) {
        self.font = UIFont.GHIconFont(size: size)
        self.text = icon.rawValue
    }
}
