//
//  GHServiceSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 17/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubRepoBrowser

final class GHServiceSpec: QuickSpec {
    override func spec() {
        describe("Service Endpoint") {
            it("Should return the correct url string") {
                expect(GHServiceEndpoint.root.string).to(equal("https://api.github.com"))
                expect(GHServiceEndpoint.Search.repositories.string).to(equal("https://api.github.com/search/repositories"))
                expect(GHServiceEndpoint.Repository.info(login: "TestU", name: "TestR").string).to(equal("https://api.github.com/repos/TestU/TestR"))
                expect(GHServiceEndpoint.Repository.pullRequest(login: "TestU", name: "TestR").string).to(equal("https://api.github.com/repos/TestU/TestR/pulls"))
            }
            it("Should return an valid URL") {
                expect(GHServiceEndpoint.root.url.absoluteString).to(equal("https://api.github.com"))
                expect(GHServiceEndpoint.Search.repositories.url.absoluteString).to(equal("https://api.github.com/search/repositories"))
                expect(GHServiceEndpoint.Repository.info(login: "TestU", name: "TestR").url.absoluteString).to(equal("https://api.github.com/repos/TestU/TestR"))
                expect(GHServiceEndpoint.Repository.pullRequest(login: "TestU", name: "TestR").url.absoluteString).to(equal("https://api.github.com/repos/TestU/TestR/pulls"))
            }
        }
    }
}
