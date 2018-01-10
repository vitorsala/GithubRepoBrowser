//
//  RepositoryListViewController.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 10/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

final class RepositoryListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView?
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?
    
    private let presenter: RepositoryListPresenter = RepositoryListPresenter()
    
    override func viewDidLoad() {
        presenter.delegate = self
        if let tableView = self.tableView {
            presenter.setupTableView(tableView)
        }
        presenter.setup()
    }
}

extension RepositoryListViewController: TableViewPresenterDelegate {
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
    
    func present(viewController: UIViewController) {
        
    }
    
    func showAlert(title: String, message: String) {
        self.presentAlert(title: title, message: message)
    }
}