//
//  RepositoryListTableViewCell.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 09/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

final class RepositoryListTableViewCell: UITableViewCell {
    @IBOutlet private weak var lblRepoName: UILabel?
    @IBOutlet private weak var lblUserName: UILabel?
    @IBOutlet private weak var lblUpdatedDate: UILabel?
    @IBOutlet private weak var lblForkCount: UILabel?
    @IBOutlet private weak var lblStarredCount: UILabel?
    @IBOutlet private weak var lblDescription: UILabel?
}

extension RepositoryListTableViewCell {
    func setup(using repo: Repository) {
        self.lblRepoName?.text = repo.name
        self.lblUserName?.text = repo.owner.login
        self.lblUpdatedDate?.text = repo.updated_at.localizedString
        self.lblForkCount?.text = String(repo.forks_count)
        self.lblStarredCount?.text = String(repo.stargazers_count)
        self.lblDescription?.text = String(repo.description ?? "No description")
    }
}

extension RepositoryListTableViewCell: NibReusable {}
