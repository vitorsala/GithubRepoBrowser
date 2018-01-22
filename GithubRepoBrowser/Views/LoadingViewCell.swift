//
//  LoadingViewCell.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 17/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

final class LoadingViewCell: UITableViewCell {
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
}

extension LoadingViewCell: NibReusable {}
