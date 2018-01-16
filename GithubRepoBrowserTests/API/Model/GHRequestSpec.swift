//
//  GHRequestSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 02/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubRepoBrowser

final class GHRequestSpec: QuickSpec {
    override func spec() {
        it("should be created correctly") {
            let request: GHRequest = GHRequest(method: .get, service: GHServiceEndpoint.Search.repositories, parameters: GHParams(params: ["an" : "test"]))
            
            expect(request.method).to(equal(Method.get))
            expect(request.parameters).toNot(beNil())
            expect(request.parameters?.params).to(haveCount(1))
        }
    }
}
