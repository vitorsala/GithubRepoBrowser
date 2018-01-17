//
//  GHClientErrorSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 17/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubRepoBrowser

final class GHClientErrorSpec: QuickSpec {
    override func spec() {
        describe("equatable protocol") {
            it("should return true for 2 indentical generic error") {
                let err1 = GHClientError.genericError(description: "An test")
                let err2 = GHClientError.genericError(description: "An test")
                expect(err1 == err2).to(beTrue())
            }
            it("Should return false for 2 errors with different descriptions") {
                let err1 = GHClientError.genericError(description: "An test")
                let err2 = GHClientError.genericError(description: "Another test")
                expect(err1 == err2).to(beFalse())
            }
        }
    }
}
