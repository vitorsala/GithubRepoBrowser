//
//  UITableView+ReusableSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 11/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import GithubRepoBrowser

final class UITableViewReusableSpec: QuickSpec {
    override func spec() {
        var tableView: UITableView!
        
        beforeEach {
            tableView = UITableView()
        }
        
        afterEach {
            tableView = nil
        }
        
        describe("table view") {
            describe("cell register") {
                it("should allow through cell type") {
                    tableView.register(TableViewCellStub.self)
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellStub")
                    expect(cell).notTo(beNil())
                }
            }
            
            describe("cell dequeue") {
                it("should dequeue correct cell") {
                    tableView.register(TableViewCellStub.self)
                    let cell = tableView.dequeueReusableCell(TableViewCellStub.self)
                    expect(cell).notTo(beNil())
                }
            }
        }
    }
}
