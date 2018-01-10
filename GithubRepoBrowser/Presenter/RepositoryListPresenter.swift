//
//  RepositoryListPresenter.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 10/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

final class RepositoryListPresenter: NSObject {
    private let repoListService: GHReposityListService
    private var repositoryList: RepositoryList
    
    weak var delegate: TableViewPresenterDelegate?
    
    init(repoListService: GHReposityListService = GHReposityListService()) {
        self.repoListService = repoListService
        self.repositoryList = RepositoryList(total_count: 0, incomplete_results: false, items: [])
    }
}

extension RepositoryListPresenter {
    @objc func setup() {
        self.fetchData()
    }
    
    private func fetchData() {
        self.delegate?.showStatusIndicator()
        self.repoListService.fetchRepositories(language: "Swift", page: 1) { [weak self] (result) in
            
            switch result {
            case let .success(repoList):
                self?.repositoryList = repoList
                self?.delegate?.reloadTableViewData()
            case let .error(code, err):
                self?.delegate?.showAlert(title: "Algo deu errado!", message: "Código (\(code)): \(err.localizedDescription)")
            }
            self?.delegate?.hideStatusIndicator()
        }
    }
}

extension RepositoryListPresenter: UITableViewDataSource {
    private func registerCells(for tableView: UITableView) {
        tableView.register(RepositoryListTableViewCell.self)
    }
    
    private func setupDelegate(for tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupDynamicRowSize(for tableView: UITableView) {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
    }
    
    private func setupRefreshControl(for tableView: UITableView) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(setup), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func setupTableView(_ tableView: UITableView) {
        self.registerCells(for: tableView)
        self.setupDelegate(for: tableView)
        self.setupDynamicRowSize(for: tableView)
        self.setupRefreshControl(for: tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.repositoryList.items.count > 0 ? 1 : 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositoryList.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(RepositoryListTableViewCell.self)
        cell.setup(using: self.repositoryList.items[indexPath.row])
        
        return cell
    }
}

extension RepositoryListPresenter: UITableViewDelegate {
    
}
