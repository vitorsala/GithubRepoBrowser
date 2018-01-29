//
//  RepositoryListViewController.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 10/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

final class RepositoryListViewController: UIViewController {
    @IBOutlet private weak var tableView: GHTableView?
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?
    
    private let presenter: RepositoryListPresenter = RepositoryListPresenter()
    
    override func viewDidLoad() {
        self.setup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier,
            identifier == SegueIdentifiers.showPRList.rawValue {
            
            if let vc = segue.destination as? PullRequestListViewController,
                let selectedItem = self.presenter.selectedItem {
                
                vc.set(repository: selectedItem)
            }
        }
    }
}

extension RepositoryListViewController {
    private func setup() {
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
    
    func scrollToRow(at indexPath: IndexPath, at position: UITableViewScrollPosition) {
        self.tableView?.scrollToRow(at: indexPath, at: position, animated: true)
    }
    
    func perform(segue: SegueIdentifiers) {
        self.performSegue(withIdentifier: segue.rawValue, sender: self)
    }
    
    func showAlert(title: String, message: String) {
        self.presentAlert(title: title, message: message)
    }
}
