//
//  GHClientSpec.swift
//  GithubRepoBrowserTests
//
//  Created by Vitor Kawai Sala on 02/01/18.
//  Copyright © 2018 Vitor Kawai Sala. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import GithubRepoBrowser

final class GHClientSpec: QuickSpec {
    override func spec() {
        var client: GHClient!
        
        beforeEach {
            client = GHClientImpl()
        }
        
        afterEach {
            client = nil
        }
        
        describe("Client") {
            it("Should be able to adquire an valid response") {
                let params = GHParams(params: [
                    "q" : "language:Swift",
                    "sort" : "stars",
                    "page" : 1
                    ])
                let request = GHRequest(method: .get, service: Service.repositoryList, parameters: params)
                
                var response: GHResponse? = nil
                
                client.fetch(request: request, callback: { (testingResponse) in
                    response = testingResponse
                })
                
                expect(response).toEventuallyNot(beNil(), timeout: 3)
                expect(response?.data).toEventuallyNot(beNil())
                expect(response?.code).toEventually(equal(200))
            }
        }
    }
}
