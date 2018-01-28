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
    private func openInfo(for pr: PullRequest) {
        let unformattedString = LocalizedStrings.PullRequestListTableViewCell.OpenInfo.localizedString
        let formattedString = String(format: unformattedString, pr.created_at.localizedString, pr.user.login)
        self.lblPROpenInfo?.text = formattedString
    }
    
    func setup(using pr: PullRequest) {
        self.lblPRTitle?.text = pr.title
        self.lblPRNumber?.text = "#\(pr.number)"
        self.openInfo(for: pr)
    }
}
