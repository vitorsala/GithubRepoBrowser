//
//  RepositoryListPresenterSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 10/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit
import Nimble
import Quick

@testable import GithubRepoBrowser

class RepositoryListPresenterSpec: QuickSpec {
    override func spec() {
        var presenter: RepositoryListPresenter!
        var stub: TableViewPresenterDelegateStub!
        var client: GHClientStub!
        
        beforeEach {
            client = GHClientStub()
            let manager = GHReposityListService(client: client)
            presenter = RepositoryListPresenter(repoListService: manager)
            stub = TableViewPresenterDelegateStub()
            presenter.delegate = stub
        }
        
        afterEach {
            presenter = nil
            stub = nil
            client = nil
        }
        
        describe("Presenter") {
            context("Core") {
                it("selectedItem should return nil when no selection were made") {
                    expect(presenter.selectedItem).to(beNil())
                }
                
                it("Should fetch data and call delegate") {
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
            
            context("Table View") {
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
                        expect(cell).to(beAnInstanceOf(RepositoryListTableViewCell.self))
                    }
                    
                    it("Should return loading cell when tableview is at over last element") {
                        presenter.setup()
                        let cell = presenter.tableView(tableView, cellForRowAt: IndexPath(item: 0, section: 1))
                        expect(cell).to(beAnInstanceOf(LoadingViewCell.self))
                    }
                    
                    it("Should return correct number of elements (num of repositories)") {
                        presenter.setup()
                        let count = presenter.tableView(tableView, numberOfRowsInSection: 0)
                        expect(count).to(equal(30))
                    }
                    
                    it("Should create an background view when table view have no elements") {
                        let sectionCount = presenter.numberOfSections(in: tableView)
                        expect(sectionCount).to(equal(0))
                        expect(tableView.backgroundView).toNot(beNil())
                    }
                    
                    it("Should have no background view when table view have at least 1 element") {
                        presenter.setup()
                        let sectionCount = presenter.numberOfSections(in: tableView)
                        expect(sectionCount).to(equal(2))
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
                    
                    it("didSelectRow should ignore loading cell") {
                        presenter.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 1))
                        expect(presenter.selectedItem).to(beNil())
                    }
                    
                    it("willDisplay should trigger an new fetch if user is in last row") {
                        presenter.tableView(tableView, willDisplay: UITableViewCell(), forRowAt: IndexPath(row: 0, section: 1))
                        let count = presenter.tableView(tableView, numberOfRowsInSection: 0)
                        expect(count).toEventually(equal(60))
                    }
                }
            }
        }
    }
}
