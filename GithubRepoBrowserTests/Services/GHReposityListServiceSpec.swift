//
//  GHReposityListServiceSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 08/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubRepoBrowser

final class GHReposityListServiceSpec: QuickSpec {
    override func spec() {
        var service: GHReposityListService!
        
        beforeEach {
            service = GHReposityListService()
        }
        
        afterEach {
            service = nil
        }
        
        context("Service") {
            describe("request") {
                it("should bring an valid response") {
                    var res: Result<RepositoryList>! = nil
                    service.fetchRepositories(page: 1, result: { (result) in
                        res = result
                    })
                    expect(res).toEventuallyNot(beNil(), timeout: 5)
                }
            }
        }
    }
}
