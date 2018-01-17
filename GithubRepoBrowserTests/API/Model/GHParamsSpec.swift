//
//  GHParamsSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 17/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubRepoBrowser

final class GHParamsSpec: QuickSpec {
    override func spec() {
        describe("Parameters") {
            it("should be able to be inited with dictionary") {
                let params = GHParams(params: ["foo": "bar"])
                expect(params.params).toNot(beEmpty())
                expect(params.params["foo"] as? String).to(equal("bar"))
            }
            
            it("should be able to add 1 nonnull key/value") {
                var params = GHParams()
                params.add(key: "foo", value: "bar")
                expect(params.params).toNot(beEmpty())
                expect(params.params["foo"] as? String).to(equal("bar"))
            }
            
            it("should ignore an nil value") {
                var params = GHParams()
                params.add(key: "foo", value: nil)
                expect(params.params).to(beEmpty())
            }
            
            it("should be able to add multiple keys/values") {
                var params = GHParams()
                params.add(["foo": "bar", "yawl": "yuwl"])
                expect(params.params).toNot(beEmpty())
                expect(params.params["foo"] as? String).to(equal("bar"))
                expect(params.params["yawl"] as? String).to(equal("yuwl"))
            }
        }
    }
}
