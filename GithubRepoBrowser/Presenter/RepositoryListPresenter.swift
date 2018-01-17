//
//  RepositoryListPresenter.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 10/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

final class RepositoryListPresenter: NSObject {
    
    private let noDataIcon = GHIcons.exclamationMark
    private let noDataText = "Nenhum dado encontrado.  :("
    
    private let failedDataFetchIcon = GHIcons.warningMark
    private let failedDataFetchText = "Ocorreu um erro!\nPuxe a tela para baixo para atualizar."
    
    private let repoListService: GHReposityListService
    private var repositoryList: RepositoryList
    private var selectedIndexPath: IndexPath?
    
    private var isFetchingData: Bool = false
    private var didFailedDataFetch: Bool = false
    
    weak var delegate: TableViewPresenterDelegate?
    
    var selectedItem: Repository? {
        guard let indexPath = self.selectedIndexPath else {
            return nil
        }
        let item = self.repositoryList.items[indexPath.row]
        return item
    }
    
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
        self.isFetchingData = true
        self.didFailedDataFetch = false
        self.repoListService.fetchRepositories(language: "Swift", page: 1) { [weak self] (result) in
            
            switch result {
            case let .success(repoList):
                self?.repositoryList = repoList
            case let .error(code, err):
                self?.delegate?.showAlert(title: "Algo deu errado!", message: "Código (\(code)): \(err.localizedDescription)")
                self?.didFailedDataFetch = true
            }
            self?.isFetchingData = false
            self?.delegate?.reloadTableViewData()
            self?.delegate?.hideStatusIndicator()
        }
    }
}

extension RepositoryListPresenter {
    private func registerCells(for tableView: UITableView) {
        tableView.register(RepositoryListTableViewCell.self)
    }
    
    private func setupDelegate(for tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func backgroundView(for tableView: UITableView) {
        if !self.isFetchingData {
            var view: TableViewBackgroundView?
            view = TableViewBackgroundView.loadFromNib()
            
            if self.didFailedDataFetch {
                view?.set(icon: self.failedDataFetchIcon, text: self.failedDataFetchText)
            } else {
                view?.set(icon: self.noDataIcon, text: self.noDataText)
            }
            
            tableView.backgroundView = view
        }
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
}

extension RepositoryListPresenter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.repositoryList.items.isEmpty {
            tableView.separatorStyle = .none
            self.backgroundView(for: tableView)
            return 0
        } else {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
            return 1
        }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.perform(segue: SegueIdentifiers.showPRList)
    }
}
