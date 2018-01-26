//
//  PullRequestListTableViewCell.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 26/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

final class PullRequestListTableViewCell: UITableViewCell {
    @IBOutlet private weak var lblPRTitle: UILabel?
    @IBOutlet private weak var lblPROpenInfo: UILabel?
    @IBOutlet private weak var lblPRNumber: UILabel?
}

extension PullRequestListTableViewCell {
    func setup(using pr: PullRequest) {
        self.lblPRTitle?.text = pr.title
        self.lblPROpenInfo?.text = pr.created_at.localizedString
        self.lblPRNumber?.text = "#\(pr.number)"
    }
}
