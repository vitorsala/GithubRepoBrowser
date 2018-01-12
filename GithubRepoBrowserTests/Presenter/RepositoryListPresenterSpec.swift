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
        
        context("Presenter") {
            describe("Core") {
                it("Should fetch data and call delegate") {
                    presenter.setup()
                    expect(stub.showAlertTriggered).to(beFalse())
                    expect(stub.showStatusIndicatorTriggered).to(beTrue())
                    expect(stub.hideStatusIndicatorTriggered).to(beTrue())
                    expect(stub.reloadTableViewDataTriggered).to(beTrue())
                }
                
                it("Should call an alert with error") {
                    client.shouldReturnSuccess = false
                    presenter.setup()
                    expect(stub.showAlertTriggered).to(beTrue())
                    expect(stub.showStatusIndicatorTriggered).to(beTrue())
                    expect(stub.hideStatusIndicatorTriggered).to(beTrue())
                    expect(stub.reloadTableViewDataTriggered).to(beTrue())
                }
            }
            context("Table View") {
                var tableView: UITableView!
                
                beforeEach {
                    tableView = UITableView()
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
                }
                
                describe("UITableViewDelegate") {
                    
                }
            }
        }
    }
}
