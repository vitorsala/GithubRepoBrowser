//
//  TableViewBackgroundView.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 11/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

final class TableViewBackgroundView: UIView {
    @IBOutlet private weak var lblIcon: UILabel?
    @IBOutlet private weak var lblText: UILabel?
}

extension TableViewBackgroundView {
    func set(icon: GHIcons, text: String) {
        lblIcon?.text = icon.rawValue
        lblText?.text = text
    }
    
    func set(icon: GHIcons, attributedText: NSAttributedString) {
        lblIcon?.text = icon.rawValue
        lblText?.attributedText = attributedText
    }
}

extension TableViewBackgroundView: NibLoadable {}
