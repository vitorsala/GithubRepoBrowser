//
//  PullRequestListPresenterSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 29/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit
import Nimble
import Quick

@testable import GithubRepoBrowser

final class PullRequestListPresenterSpec: QuickSpec {
    override func spec() {
        var presenter: PullRequestListPresenter!
        var stub: TableViewPresenterDelegateStub!
        var client: GHClientStub!
        
        beforeEach {
            client = GHClientStub()
            let manager = GHPullRequestListService(client: client)
            presenter = PullRequestListPresenter(prService: manager)
            stub = TableViewPresenterDelegateStub()
            presenter.delegate = stub
            
            let user = User(id: 000,
                            login: "Username",
                            avatar_url: nil,
                            url: "url")
            let repo = Repository(id: 0000,
                                  name: "RepositoryName",
                                  description: "descriptio ",
                                  created_at: Date(),
                                  updated_at: Date(),
                                  url: "test",
                                  stargazers_count: 2,
                                  forks_count: 1,
                                  owner: user,
                                  license: nil)
            
            presenter.repository = repo
        }
        
        afterEach {
            presenter = nil
            stub = nil
            client = nil
        }
        
        describe("Presenter") {
            describe("Core") {
                it("Should be able to fetch data and call delegate on finish") {
                    presenter.setup()
                    expect(stub.showAlertTriggered).to(beFalse())
                    expect(stub.showStatusIndicatorTriggered).to(beTrue())
                    expect(stub.hideStatusIndicatorTriggered).to(beTrue())
                    expect(stub.reloadTableViewDataTriggered).to(beTrue())
                }
                
                it("Should call an alert with error if fetch fails") {
                    client.shouldReturnSuccess = false
                    presenter.setup()
                    expect(stub.showAlertTriggered).to(beTrue())
                    expect(stub.showStatusIndicatorTriggered).to(beTrue())
                    expect(stub.hideStatusIndicatorTriggered).to(beTrue())
                    expect(stub.reloadTableViewDataTriggered).to(beTrue())
                }
            }
            
            describe("table view") {
                var tableView: GHTableView!
                
                beforeEach {
                    tableView = GHTableView()
                    presenter.setupTableView(tableView)
                }
                
                afterEach {
                    tableView = nil
                }
                
                describe("Setup") {
                    it("Should setup properties") {
                        expect(tableView.delegate).notTo(beNil())
                        expect(tableView.dataSource).notTo(beNil())
                        expect(tableView.rowHeight).to(equal(UITableViewAutomaticDimension))
                        expect(tableView.refreshControl).notTo(beNil())
                    }
                }
                
                describe("UITableViewDataSource") {
                    it("Should return correct cell when IndexPath do not point to last element") {
                        presenter.setup()
                        let cell = presenter.tableView(tableView, cellForRowAt: IndexPath(item: 0, section: 0))
                        expect(cell).to(beAnInstanceOf(PullRequestListTableViewCell.self))
                    }
                    
                    it("Should return correct number of elements (num of pull requests)") {
                        presenter.setup()
                        let count = presenter.tableView(tableView, numberOfRowsInSection: 0)
                        expect(count).to(equal(15))
                    }
                    
                    it("Should create an background view when table view have no elements") {
                        let sectionCount = presenter.numberOfSections(in: tableView)
                        expect(sectionCount).to(equal(0))
                        expect(tableView.backgroundView).toNot(beNil())
                    }
                    
                    it("Should have no background view when table view have at least 1 element") {
                        presenter.setup()
                        let sectionCount = presenter.numberOfSections(in: tableView)
                        expect(sectionCount).to(equal(1))
                        expect(tableView.backgroundView).to(beNil())
                    }
                }
                
                describe("UITableViewDelegate") {
                    beforeEach {
                        presenter.setup()
                    }
                    
                    it("didSelectRow should select an valid repository") {
                        presenter.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                        expect(presenter.selectedItem).toNot(beNil())
                    }
                }
            }
        }
    }
}
