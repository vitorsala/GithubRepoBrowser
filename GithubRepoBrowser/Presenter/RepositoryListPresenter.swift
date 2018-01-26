//
//  RepositoryListPresenter.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 10/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

private enum SectionIndex: Int {
    case Repositories = 0
    case LoadingMark
}

final class RepositoryListPresenter: NSObject {
    
    private let repoListService: GHReposityListService
    private var repositoryList: [Repository] = []
    private var selectedIndexPath: IndexPath?
    
    private var page: Int = 1
    
    private var isFetchingData: Bool = false
    private var didFailedDataFetch: Bool = false
    
    weak var delegate: TableViewPresenterDelegate?
    
    var selectedItem: Repository? {
        guard let indexPath = self.selectedIndexPath else {
            return nil
        }
        let item = self.repositoryList[indexPath.row]
        return item
    }
    
    init(repoListService: GHReposityListService = GHReposityListService()) {
        self.repoListService = repoListService
    }
}

extension RepositoryListPresenter {
    @objc func setup() {
        self.page = 1
        self.delegate?.showStatusIndicator()
        self.loadPage(self.page) { [weak self] in
            self?.delegate?.hideStatusIndicator()
        }
    }
    
    private func loadPage(_ page: Int, completion: (() -> Void)? = nil) {
        self.isFetchingData = true
        self.didFailedDataFetch = false
        self.repoListService.fetchRepositories(language: .Swift, page: page) { [weak self] (result) in
            
            switch result {
            case let .success(repoList):
                self?.repositoryList.append(contentsOf: repoList.items)
            case let .error(code, err):
                let title = LocalizedStrings.Alert.ConnectionError.localizedString
                let codeWord = LocalizedStrings.Alert.CodeWord.localizedString
                self?.delegate?.showAlert(title: title, message: "\(codeWord) (\(code)): \(err.localizedDescription)")
                self?.didFailedDataFetch = true
            }
            self?.isFetchingData = false
            self?.delegate?.reloadTableViewData()
            completion?()
        }
    }
    
    private func loadNextPage() {
        if !self.didFailedDataFetch {
            self.page += 1
        }
        
        self.loadPage(self.page) { [weak self] in
            guard let `self` = self else { return }
            if self.didFailedDataFetch {
                let indexPath = IndexPath(item: self.repositoryList.count - 1, section: 0)
                self.delegate?.scrollToRow(at: indexPath, at: .bottom)
            }
        }
    }
}

extension RepositoryListPresenter {
    private func registerCells(for tableView: GHTableView) {
        tableView.register(RepositoryListTableViewCell.self)
        tableView.register(LoadingViewCell.self)
    }
    
    private func setupDelegate(for tableView: GHTableView) {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupTableView(_ tableView: GHTableView) {
        self.registerCells(for: tableView)
        self.setupDelegate(for: tableView)
        tableView.setDynamicRowSize()
        tableView.setRefreshControl(target: self, action: #selector(setup))
        tableView.separatorStyle = .none
    }
}

extension RepositoryListPresenter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let tableView = tableView as? GHTableView else { return 0 }
        
        if !self.isFetchingData {
            if self.didFailedDataFetch {
                tableView.setBackgroundStyle(for: .Error)
            } else {
                let event: GHTableViewEvent = (self.repositoryList.isEmpty ? .NoData : .OK)
                tableView.setBackgroundStyle(for: event)
            }
        }
        return (self.repositoryList.isEmpty ? 0 : 2)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == SectionIndex.Repositories.rawValue ? self.repositoryList.count : 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SectionIndex.LoadingMark.rawValue {
            let cell = tableView.dequeueReusableCell(LoadingViewCell.self)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(RepositoryListTableViewCell.self)
            cell.setup(using: self.repositoryList[indexPath.row])
            return cell
        }
    }
}

extension RepositoryListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == SectionIndex.Repositories.rawValue else { return }
        self.selectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.perform(segue: SegueIdentifiers.showPRList)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == SectionIndex.LoadingMark.rawValue {
            self.loadNextPage()
        }
    }
}
