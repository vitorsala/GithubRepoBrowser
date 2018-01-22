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
        var client: GHClientStub!
        beforeEach {
            client = GHClientStub()
            service = GHReposityListService(client: client)
        }
        afterEach {
            service = nil
            client = nil
        }
        context("Service") {
            describe("request") {
                it("should bring an valid response") {
                    var res: Result<RepositoryList>! = nil
                    service.fetchRepositories(language: .Swift, page: 1, result: { (result) in
                        res = result
                    })
                    expect(res).notTo(beNil())
                    switch res! {
                    case .success(let repoList):
                        expect(repoList.items).toNot(haveCount(0))
                    case let .error(_, error):
                        fail("expected an .success, returned .error: \(error.localizedDescription)")
                    }
                }
                
                it("it should fail") {
                    var res: Result<RepositoryList>! = nil
                    client.shouldReturnSuccess = false
                    service.fetchRepositories(language: .Swift, page: 1, result: { (result) in
                        res = result
                    })
                    expect(res).notTo(beNil())
                    switch res! {
                    case .success(_):
                        fail("expected an error, returned an success instead")
                    case let .error(code, error):
                        expect(code).to(equal(404))
                        expect(error as? GHClientError).to(equal(GHClientError.genericError(description: "Simulated Error")))
                    }
                }
            }
        }
    }
}
