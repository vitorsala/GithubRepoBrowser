//
//  PullRequestListViewController.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 26/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import UIKit

final class PullRequestListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: GHTableView?
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?
    
    private let presenter: PullRequestListPresenter = PullRequestListPresenter()
    
    override func viewDidLoad() {
        self.setup()
    }
}

extension PullRequestListViewController {
    private func setup() {
        presenter.delegate = self
        if let tableView = self.tableView {
            presenter.setupTableView(tableView)
        }
        presenter.setup()
    }
    
    func set(repository: Repository) {
        self.presenter.repository = repository
    }
}

extension PullRequestListViewController: TableViewPresenterDelegate {
    func showStatusIndicator() {
        if let refreshControl = self.tableView?.refreshControl,
            !refreshControl.isRefreshing {
            
            self.activityIndicator?.startAnimating()
        }
    }
    
    func hideStatusIndicator() {
        self.activityIndicator?.stopAnimating()
        self.tableView?.refreshControl?.endRefreshing()
    }
    
    func reloadTableViewData() {
        self.tableView?.reloadData()
    }
    
    func scrollToRow(at indexPath: IndexPath, at position: UITableViewScrollPosition) {
        self.tableView?.scrollToRow(at: indexPath, at: position, animated: true)
    }
    
    func perform(segue: SegueIdentifiers) {
    }
    
    func showAlert(title: String, message: String) {
        self.presentAlert(title: title, message: message)
    }
}
