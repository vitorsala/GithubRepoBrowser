//
//  PullRequestListPresenter.swift
//  GithubRepoBrowser
//
//  Created by Vitor Kawai Sala on 26/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit

final class PullRequestListPresenter: NSObject {
    
    private let prService: GHPullRequestListService
    private var isFetchingData: Bool = false
    private var didFailedDataFetch: Bool = false
    private var selectedIndexPath: IndexPath?
    
    weak var delegate: TableViewPresenterDelegate?
    var repository: Repository?
    var prList: [PullRequest] = []
    
    var selectedItem: PullRequest? {
        guard let indexPath = self.selectedIndexPath else {
            return nil
        }
        return self.prList[indexPath.row]
    }
    
    init(prService: GHPullRequestListService = GHPullRequestListService()) {
        self.prService = prService
    }
}

extension PullRequestListPresenter {
    @objc func loadPRList() {
        guard let repo = self.repository else { return }
        self.isFetchingData = true
        self.didFailedDataFetch = false
        self.prService.fetchPullrequest(for: repo) { [weak self] (result) in
            switch result {
            case let .success(prs):
                self?.prList = prs
            case let .error(code, error):
                let title = LocalizedStrings.Alert.ConnectionError.localizedString
                let codeWord = LocalizedStrings.Alert.CodeWord.localizedString
                self?.delegate?.showAlert(title: title, message: "\(codeWord) (\(code)): \(error.localizedDescription)")
                self?.didFailedDataFetch = true
            }
            self?.isFetchingData = false
            self?.delegate?.hideStatusIndicator()
            self?.delegate?.reloadTableViewData()
        }
    }
}

extension PullRequestListPresenter {
    private func registerCells(for tableView: GHTableView) {
        tableView.register(PullRequestListTableViewCell.self)
    }
    
    private func setupDelegate(for tableView: GHTableView) {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func backgroundView(for tableView: GHTableView) {
        if !self.isFetchingData {
            if self.didFailedDataFetch {
                tableView.setBackgroundStyle(for: .Error)
            } else {
                let event: GHTableViewEvent = (self.prList.isEmpty ? .NoData : .OK)
                tableView.setBackgroundStyle(for: event)
            }
        }
    }
    
    func setupTableView(_ tableView: GHTableView) {
        self.registerCells(for: tableView)
        self.setupDelegate(for: tableView)
        tableView.setDynamicRowSize()
        tableView.setRefreshControl(target: self, action: #selector(loadPRList))
        tableView.separatorStyle = .none
    }
    
    func setup() {
        self.delegate?.showStatusIndicator()
        self.loadPRList()
    }
}

extension PullRequestListPresenter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let tableView = tableView as? GHTableView else { return 0 }
        self.backgroundView(for: tableView)
        return (self.prList.isEmpty ? 0 : 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.prList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(PullRequestListTableViewCell.self)
        cell.setup(using: self.prList[indexPath.row])
        return cell
    }
}

extension PullRequestListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedIndexPath = indexPath
    }
}
