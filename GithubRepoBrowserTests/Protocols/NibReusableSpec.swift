//
//  NibReusableSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 11/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubRepoBrowser

final class NibReusableSpec: QuickSpec {
    override func spec() {
        
        context("NibLoadable") {
            it("Should return correct nib") {
                let nib = TableViewCellStub.nib
                let vc = nib.instantiate(withOwner: nil, options: nil).first
                expect(vc).notTo(beNil())
                expect(vc).to(beAnInstanceOf(TableViewCellStub.self))
            }
            
            it("Should load correct view") {
                let vc = TableViewCellStub.loadFromNib()
                expect(vc).notTo(beNil())
                expect(vc).to(beAnInstanceOf(TableViewCellStub.self))
            }
        }
        
        context("NibReusable") {
            describe("identifier") {
                it("should have correct identifier") {
                    let identifier = TableViewCellStub.identifier
                    expect(identifier).to(equal("TableViewCellStub"))
                }
            }
        }
    }
}
