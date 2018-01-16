//
//  GHPullRequestListServiceSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 16/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubRepoBrowser

final class GHPullRequestListServiceSpec: QuickSpec {
    override func spec() {
        var service: GHPullRequestListService!
        var client: GHClientStub!
        beforeEach {
            client = GHClientStub()
            service = GHPullRequestListService(client: client)
        }
        afterEach {
            service = nil
            client = nil
        }
        context("Service") {
            describe("request") {
                it("should bring an valid response") {
                    let user = User(id: 000,
                                    login: "Username",
                                    avatar_url: nil,
                                    url: "url")
                    let repo = Repository(id: 0000,
                                          name: "RepositoryName",
                                          description: "descriptio ",
                                          created_at: Date(),
                                          url: "test",
                                          stargazers_count: 2,
                                          forks_count: 1,
                                          owner: user,
                                          license: nil)
                    
                    var res: Result<[PullRequest]>! = nil
                    service.fetchPullrequest(for: repo, result: { (result) in
                        res = result
                    })
                    expect(res).notTo(beNil())
                    switch res! {
                    case .success(let pullrequests):
                        expect(pullrequests).toNot(haveCount(0))
                    case let .error(_, error):
                        fail("expected an .success, returned .error: \(error.localizedDescription)")
                    }
                }
                
                it("it should fail") {
                    let user = User(id: 000,
                                    login: "Username",
                                    avatar_url: nil,
                                    url: "url")
                    let repo = Repository(id: 0000,
                                          name: "RepositoryName",
                                          description: "descriptio ",
                                          created_at: Date(),
                                          url: "test",
                                          stargazers_count: 2,
                                          forks_count: 1,
                                          owner: user,
                                          license: nil)
                    
                    var res: Result<[PullRequest]>! = nil
                    
                    client.shouldReturnSuccess = false
                    service.fetchPullrequest(for: repo, result: { (result) in
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
